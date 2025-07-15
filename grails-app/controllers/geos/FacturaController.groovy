package geos

// ─── Librerías para Excel ──────────────────────────────────────────────────────
import org.apache.poi.ss.usermodel.*
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Cell

// ─── Transacciones ────────────────────────────────────────────────────────────
import grails.gorm.transactions.Transactional

class FacturaController {

    def list() {
        def fechaInicio = params.fechaInicio ? Date.parse('yyyy-MM-dd', params.fechaInicio) : null
        def fechaFin = params.fechaFin ? Date.parse('yyyy-MM-dd', params.fechaFin) : null
        def fechaFinMasUno = fechaFin ? fechaFin + 1 : null

        def facturas = Factura.createCriteria().list {
            if (fechaInicio) {
                ge("fechaEmision", fechaInicio)
            }
            if (fechaFinMasUno) {
                lt("fechaEmision", fechaFinMasUno)
            }
            order("fechaEmision", "desc")
        }
        [facturas: facturas, params: params]
    }

    def buscar_ajax() {
        def fechaInicio = params.fechaInicio ? Date.parse('yyyy-MM-dd', params.fechaInicio) : null
        def fechaFin = params.fechaFin ? Date.parse('yyyy-MM-dd', params.fechaFin) : null
        def fechaFinMasUno = fechaFin ? fechaFin + 1 : null

        def facturas = Factura.createCriteria().list {
            if (fechaInicio) {
                ge("fechaEmision", fechaInicio)
            }
            if (fechaFinMasUno) {
                lt("fechaEmision", fechaFinMasUno)
            }
            order("fechaEmision", "desc")
        }
        def totalSQL = facturas.size()
        render(template: 'buscar_ajax', model: [
            facturas: facturas,
            totalSQL: totalSQL,
            params: params
        ])
    }

    def show_ajax() {
        def factura = Factura.get(params.id)
        [facturaInstance: factura]
    }

    def edit_ajax() {
        def factura = Factura.get(params.id)
        [facturaInstance: factura]
    }

    def save_edit_ajax() {
        def factura = Factura.get(params.id)
        if (!factura) {
            render "no"
            return
        }
        // Actualizar cantidades de los detalles
        factura.detalles.each { det ->
            def nuevaCantidad = params["cantidad_${det.id}"]?.toInteger()
            if (nuevaCantidad && nuevaCantidad > 0) {
                det.cantidad = nuevaCantidad
                det.save(flush: true)
            }
        }
        // Recalcular total
        factura.total = factura.detalles.sum { it.cantidad * it.precioUnitario }
        factura.save(flush: true)
        render "ok"
    }

    def delete_ajax() {
        println "Intentando eliminar factura: ${params.id}"
        def factura = Factura.get(params.id)
        if (factura) {
            try {
                def pedido = factura.pedido
                def detalles = factura.detalles?.toList() ?: []
                detalles.each { det ->
                    factura.removeFromDetalles(det)
                    det.delete(flush: true)
                }
                factura.save(flush: true)
                factura.delete(flush: true)
                // Cambiar el estado del pedido a CANCELADO
                if (pedido) {
                    pedido.estado = "CANCELADO"
                    pedido.save(flush: true)
                }
                render "ok"
            } catch (Exception e) {
                println "Error al eliminar: ${e.message}"
                render "no"
            }
        } else {
            println "Factura no encontrada"
            render "no"
        }
    }

    // ───────────────────────────────────────────────────────────────────────────
    // Exportar a Excel
    // ───────────────────────────────────────────────────────────────────────────

    @Transactional(readOnly = true)
    def reporteExcel() {
        List<Factura> facturas = Factura.list(sort: 'fechaEmision', order: 'desc')
        
        // 1) Crear libro y hoja
        XSSFWorkbook wb = new XSSFWorkbook()
        Sheet sheet = wb.createSheet('Facturas')
        
        // 2) Encabezados
        String[] cols = ['ID Factura', 'ID Pedido', 'Cliente', 'Fecha Emisión', 'Estado Pedido', 'Total']
        Row header = sheet.createRow(0)
        cols.eachWithIndex { label, idx -> header.createCell(idx).setCellValue(label) }
        
        // 3) Datos
        int rowNum = 1
        facturas.each { factura ->
            Row row = sheet.createRow(rowNum++)
            row.createCell(0).setCellValue(factura.id ?: '')
            row.createCell(1).setCellValue(factura.pedido?.id ?: '')
            row.createCell(2).setCellValue(factura.pedido?.persona?.nombre ?: '')
            row.createCell(3).setCellValue(factura.fechaEmision ? factura.fechaEmision.format('dd/MM/yyyy') : '')
            row.createCell(4).setCellValue(factura.pedido?.estado ?: '')
            row.createCell(5).setCellValue(factura.total ?: 0.0)
        }
        
        // 4) Ajustar columnas
        cols.indices.each { sheet.autoSizeColumn(it) }
        
        // 5) Preparar respuesta HTTP
        String fileName = "reporte_facturas_${new Date().format('yyyyMMdd_HHmm')}.xlsx"
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
