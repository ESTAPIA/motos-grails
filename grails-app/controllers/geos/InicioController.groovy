package geos

import groovy.sql.Sql
import grails.converters.JSON

class InicioController {

    def dataSource

    def beforeInterceptor = {
        println "DEBUG SESSION usuario: ${session.usuario} perfil: ${session.perfil} codigo: ${session.perfil?.codigo}"
        if (!session.usuario || !session.perfil || session.perfil.codigo != 'ADM') {
            flash.message = "Acceso restringido solo para administradores"
            redirect(controller: "login", action: "login")
            return false // Esto es fundamental para que NO siga ejecutando la acción
        }
    }

    def index() {
        def sql = new Sql(dataSource)
        
        try {
            // 1. Tipos de accesorios más vendidos
            def tiposAccesorioVendidos = sql.rows("""
                SELECT ta.tpactpac as nombre, 
                       SUM(dp.dtpdcntd) as cantidad
                FROM dtpd dp
                JOIN artc a ON dp.artc__id = a.artc__id
                JOIN tpac ta ON a.tpac__id = ta.tpac__id
                JOIN pedd p ON dp.pedd__id = p.pedd__id
                WHERE p.peddestd = 'CONFIRMADO'
                GROUP BY ta.tpactpac
                ORDER BY cantidad DESC
                LIMIT 10
            """)
            
            // 2. Artículos más vendidos
            def articulosMasVendidos = sql.rows("""
                SELECT a.artcnmbr as nombre,
                       SUM(dp.dtpdcntd) as cantidad
                FROM dtpd dp
                JOIN artc a ON dp.artc__id = a.artc__id
                JOIN pedd p ON dp.pedd__id = p.pedd__id
                WHERE p.peddestd = 'CONFIRMADO'
                GROUP BY a.artc__id, a.artcnmbr
                ORDER BY cantidad DESC
                LIMIT 10
            """)
            
            // 3. Artículos con poco stock (menos de 10)
            def articulosPocoStock = sql.rows("""
                SELECT a.artcnmbr as nombre,
                       a.artcstock as stock,
                       ta.tpactpac as tipo
                FROM artc a
                JOIN tpac ta ON a.tpac__id = ta.tpac__id
                WHERE a.artcstock < 10
                ORDER BY a.artcstock ASC
            """)
            
            // 4. Ventas por mes (últimos 12 meses)
            def ventasPorMes = sql.rows("""
                SELECT TO_CHAR(f.factfcem, 'YYYY-MM') as mes,
                       COUNT(*) as facturas,
                       SUM(f.factttl) as total
                FROM fact f
                WHERE f.factfcem >= CURRENT_DATE - INTERVAL '12 months'
                GROUP BY TO_CHAR(f.factfcem, 'YYYY-MM')
                ORDER BY mes DESC
            """)
            
            // 5. Resumen general
            def resumenGeneral = [
                totalPersonas: sql.firstRow("SELECT COUNT(*) as total FROM prsn").total,
                totalArticulos: sql.firstRow("SELECT COUNT(*) as total FROM artc").total,
                totalFacturas: sql.firstRow("SELECT COUNT(*) as total FROM fact").total,
                totalVentasHoy: sql.firstRow("""
                    SELECT COALESCE(SUM(factttl), 0) as total 
                    FROM fact 
                    WHERE DATE(factfcem) = CURRENT_DATE
                """).total
            ]
            
            return [
                tiposAccesorioVendidos: tiposAccesorioVendidos,
                articulosMasVendidos: articulosMasVendidos,
                articulosPocoStock: articulosPocoStock,
                ventasPorMes: ventasPorMes,
                resumenGeneral: resumenGeneral
            ]
            
        } catch (Exception e) {
            log.error "Error al generar estadísticas: ${e.message}", e
            return [
                error: "Error al cargar estadísticas",
                tiposAccesorioVendidos: [],
                articulosMasVendidos: [],
                articulosPocoStock: [],
                ventasPorMes: [],
                resumenGeneral: [
                    totalPersonas: 0,
                    totalArticulos: 0,
                    totalFacturas: 0,
                    totalVentasHoy: 0
                ]
            ]
        } finally {
            sql.close()
        }
    }
}
