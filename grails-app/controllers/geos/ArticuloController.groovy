package geos

import org.apache.poi.ss.usermodel.*
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Cell
import grails.gorm.transactions.Transactional

class ArticuloController {

    def list() {
        def articulos = Articulo.list([sort: 'nombre'])
        [articulos: articulos]
    }

    @Transactional(readOnly = true)
    def reporteExcel() {
        List<Articulo> articulos = Articulo.list(sort: 'nombre')
        
        // Crear libro y hoja
        XSSFWorkbook wb = new XSSFWorkbook()
        Sheet sheet = wb.createSheet('Articulos')
        
        // Encabezados
        String[] cols = ['ID', 'Nombre', 'Descripción', 'Precio Base', 'Stock', 
                        'Tipo de Accesorio', 'Imagen', 'Fecha Creación', 'Fecha Actualización']
        Row header = sheet.createRow(0)
        cols.eachWithIndex { label, idx -> header.createCell(idx).setCellValue(label) }
        
        // Datos
        int rowNum = 1
        articulos.each { art ->
            Row row = sheet.createRow(rowNum++)
            row.createCell(0).setCellValue(art.id ?: '')
            row.createCell(1).setCellValue(art.nombre ?: '')
            row.createCell(2).setCellValue(art.descripcion ?: '')
            row.createCell(3).setCellValue(art.precioBase ?: 0.0)
            row.createCell(4).setCellValue(art.stock ?: 0)
            row.createCell(5).setCellValue(art.tipoAccesorio?.tipoDeAccesorio ?: '')
            row.createCell(6).setCellValue(art.imagen ?: '')
            row.createCell(7).setCellValue(art.dateCreated ? art.dateCreated.format('dd/MM/yyyy HH:mm') : '')
            row.createCell(8).setCellValue(art.lastUpdated ? art.lastUpdated.format('dd/MM/yyyy HH:mm') : '')
        }
        
        // Autoajustar columnas
        cols.indices.each { sheet.autoSizeColumn(it) }
        
        // Configurar respuesta HTTP
        String fileName = "reporte_articulos_${new Date().format('yyyyMMdd_HHmm')}.xlsx"
        response.contentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        response.setHeader 'Content-Disposition', "attachment; filename=${fileName}"
        
        // Enviar archivo
        wb.write(response.outputStream)
        wb.close()
        response.outputStream.flush()
        return
    }

    def form_ajax() {
        def articulo = params.id ? Articulo.get(params.id) : new Articulo()
        def tiposAccesorio = TipoAccesorio.list(sort: 'tipoDeAccesorio')
        [articuloInstance: articulo, tiposAccesorio: tiposAccesorio]
    }

    def save_ajax() {
        def articulo = params.id ? Articulo.get(params.id) : new Articulo()
        articulo.properties = params

        // Asignar el tipo de accesorio si viene el id
        if (params.tipoAccesorio) {
            articulo.tipoAccesorio = TipoAccesorio.get(params.tipoAccesorio)
        }

        if (!articulo.save(flush: true)) {
            render "no"
        } else {
            render "ok"
        }
    }

    def delete_ajax() {
        def articulo = Articulo.get(params.id)
        if (articulo) {
            try {
                articulo.delete(flush: true)
                render "ok"
            } catch (org.springframework.dao.DataIntegrityViolationException e) {
                // Error de clave foránea - el artículo está siendo usado
                render "referenced"
            } catch (Exception e) {
                // Otros errores
                render "error"
            }
        } else {
            render "not_found"
        }
    }

    def show_ajax() {
        def articulo = Articulo.get(params.id)
        [articuloInstance: articulo]
    }

    def buscar_ajax() {
        def filtro = params.filtro?.trim()
        def articulos = []
        def totalSQL = 0

        if (filtro && filtro != '') {
            articulos = Articulo.findAllByNombreIlike("%${filtro}%")
            totalSQL = articulos.size()
        } else {
            articulos = Articulo.list([sort: 'nombre'])
            totalSQL = articulos.size()
        }

        render(template: 'buscar_ajax', model: [
            articulos: articulos,
            totalSQL: totalSQL,
            filtro: filtro
        ])
    }

    def buscar_cliente_ajax() {
        def filtro = params.filtro?.trim()
        def tipoId = params.tipoId
        def articulos = Articulo.createCriteria().list {
            if (tipoId) {
                eq("tipoAccesorio.id", tipoId.toLong())
            }
            if (filtro) {
                ilike("nombre", "%${filtro}%")
            }
            order("nombre", "asc")
        }
        render(template: '/cliente/tablaArticulos', model: [articulos: articulos])
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
