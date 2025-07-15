package geos

import grails.converters.JSON
import groovy.sql.Sql

// ─── Librerías para Excel ──────────────────────────────────────────────────────
import org.apache.poi.ss.usermodel.*
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Cell

// ─── Transacciones ────────────────────────────────────────────────────────────
import grails.gorm.transactions.Transactional

/**
 * CRUD de Persona + utilidades (búsqueda AJAX, conteo SQL directo)
 * Incluye acción `reporteExcel()` que descarga un .xlsx con el listado completo
 */
class PersonaController {

    /** Inyección del DataSource de la aplicación */
    def dataSource

    // ───────────────────────────────────────────────────────────────────────────
    // Helpers
    // ───────────────────────────────────────────────────────────────────────────

    private Sql conectarDB() {
        new Sql(dataSource)
    }

    // ───────────────────────────────────────────────────────────────────────────
    // Acciones CRUD y AJAX
    // ───────────────────────────────────────────────────────────────────────────

    def list() {
        [personas: Persona.list(sort: 'nombre')]
    }

    def form_ajax() {
        def persona = params.id ? Persona.get(params.id) : new Persona()
        [
            personaInstance: persona,
            tiposPersona   : TipoPersona.list(sort: 'descripcion', order: 'asc'),
            perfiles       : Perfil.list(sort: 'nombre', order: 'asc')
        ]
    }

    def save_ajax() {
        println "guarda persona: $params"
        def persona = params.id ? Persona.get(params.id) : new Persona()

        // Conservar hash previo, por si la contraseña no cambia
        def passwordActual = persona.password
        persona.properties = params

        if (params.tipoPersona) {
            persona.tipoPersona = TipoPersona.get(params.tipoPersona)
        }

        // (Re)-encriptar contraseña si procede
        if (params.password) {
            if (!params.id) {
                persona.password = params.password.encodeAsMD5()
            } else {
                def nuevoHash = params.password.encodeAsMD5()
                persona.password = (nuevoHash != passwordActual) ? nuevoHash : passwordActual
            }
        }

        if (!persona.save(flush: true)) {
            println "error al guardar la persona ${persona.errors}"
            render "no"
        } else {
            render "ok"
        }
    }

    def delete_ajax() {
        println "elimina persona: $params"
        def persona = params.id ? Persona.get(params.id) : null
        if (!persona) {
            render "no"; return
        }

        try {
            persona.delete(flush: true)
            render "ok"
        } catch (Exception e) {
            println "error al eliminar la persona: ${e.message}"
            render "no"
        }
    }

    def show_ajax() {
        [personaInstance: params.id ? Persona.get(params.id) : null]
    }

    def buscar_ajax() {
        println "buscar personas: $params"
        def filtro = params.filtro?.trim()
        List<Persona> personas

        if (filtro) {
            personas = Persona.findAll("""
                FROM Persona p WHERE
                    LOWER(p.nombre)   LIKE LOWER(:f) OR
                    LOWER(p.apellido) LIKE LOWER(:f) OR
                    LOWER(p.login)    LIKE LOWER(:f) OR
                    LOWER(p.mail)     LIKE LOWER(:f)
            """, [f: "%${filtro}%"])
        } else {
            personas = Persona.list(sort: 'nombre')
        }

        render template: 'buscar_ajax', model: [
            personas : personas,
            totalSQL : personas.size(),
            filtro   : filtro
        ]
    }

    def contar() {
        Sql sql = conectarDB()
        try {
            def total   = sql.firstRow("SELECT COUNT(*) total FROM prsn")?.total
            def fechaDB = sql.firstRow("SELECT CURRENT_DATE fecha")?.fecha
            render """
                <h3>Consultas SQL Directas</h3>
                <p><strong>Total de personas:</strong> ${total}</p>
                <p><strong>Fecha servidor:</strong> ${fechaDB}</p>
            """
        } catch (e) {
            render "Error SQL: ${e.message}"
        } finally {
            sql?.close()
        }
    }

    // ───────────────────────────────────────────────────────────────────────────
    // Acciones de vista / edición normal
    // ───────────────────────────────────────────────────────────────────────────

    def create() {
        def tipoCliente  = TipoPersona.findByDescripcionIlike("Cliente")
        def perfilCliente = Perfil.findByCodigo("CLI")
        respond new Persona(params).tap {
            tipoPersona = tipoCliente
            perfil      = perfilCliente
        }, model: [
            tiposPersona: [tipoCliente],
            perfiles    : Perfil.list(sort: 'nombre', order: 'asc')
        ]
    }

    def edit(Long id) {
        def persona = Persona.get(id)
        if (!persona) { notFound(); return }
        respond persona, model: [
            tiposPersona: TipoPersona.list(sort: 'descripcion', order: 'asc'),
            perfiles    : Perfil.list(sort: 'nombre', order: 'asc')
        ]
    }

    // ───────────────────────────────────────────────────────────────────────────
    // Exportar a Excel
    // ───────────────────────────────────────────────────────────────────────────

    @Transactional(readOnly = true)
    def reporteExcel() {
        List<Persona> personas = Persona.list(sort: 'nombre')

        // 1) Crear libro y hoja
        XSSFWorkbook wb = new XSSFWorkbook()
        Sheet sheet    = wb.createSheet('Personas')

        // 2) Encabezados expandidos
        String[] cols = ['Cédula', 'Login', 'Nombre', 'Apellido', 'Mail', 'Teléfono', 'Dirección', 
                        'Sexo', 'Fecha Inicio', 'Fecha Fin', 'Tipo Persona', 'Perfil', 'Estado']
        Row header = sheet.createRow(0)
        cols.eachWithIndex { label, idx -> header.createCell(idx).setCellValue(label) }

        // 3) Datos completos
        int rowNum = 1
        personas.each { p ->
            Row row = sheet.createRow(rowNum++)
            row.createCell(0).setCellValue(p.cedula ?: '')
            row.createCell(1).setCellValue(p.login ?: '')
            row.createCell(2).setCellValue(p.nombre ?: '')
            row.createCell(3).setCellValue(p.apellido ?: '')
            row.createCell(4).setCellValue(p.mail ?: '')
            row.createCell(5).setCellValue(p.telefono ?: '')
            row.createCell(6).setCellValue(p.direccion ?: '')
            row.createCell(7).setCellValue(p.sexo ?: '')
            row.createCell(8).setCellValue(p.fechaInicio ? p.fechaInicio.format('dd/MM/yyyy') : '')
            row.createCell(9).setCellValue(p.fechaFin ? p.fechaFin.format('dd/MM/yyyy') : '')
            row.createCell(10).setCellValue(p.tipoPersona?.descripcion ?: '')
            row.createCell(11).setCellValue(p.perfil?.nombre ?: '')
            row.createCell(12).setCellValue(p.activo ? 'Activo' : 'Inactivo')
        }

        // 4) Ajustar columnas
        cols.indices.each { sheet.autoSizeColumn(it) }

        // 5) Preparar respuesta HTTP
        String fileName = "reporte_personas_${new Date().format('yyyyMMdd_HHmm')}.xlsx"
        response.contentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        response.setHeader 'Content-Disposition', "attachment; filename=${fileName}"

        // 6) Enviar archivo
        wb.write(response.outputStream)
        wb.close()
        response.outputStream.flush()
        return  // Evita que Grails busque una vista
    }

    // ───────────────────────────────────────────────────────────────────────────
    // Seguridad: solo admin
    // ───────────────────────────────────────────────────────────────────────────

    def beforeInterceptor = {
        if (!session.usuario || !session.perfil || session.perfil.codigo != 'ADM') {
            flash.message = "Acceso restringido solo para administradores"
            redirect(controller: "login", action: "login")
            return false
        }
        true
    }
}
