package geos

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
}
