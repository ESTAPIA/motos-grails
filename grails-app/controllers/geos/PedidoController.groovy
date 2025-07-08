package geos

class PedidoController {

    def list() {
        def fechaInicio = params.fechaInicio ? Date.parse('yyyy-MM-dd', params.fechaInicio) : null
        def fechaFin = params.fechaFin ? Date.parse('yyyy-MM-dd', params.fechaFin) : null
        def fechaFinMasUno = fechaFin ? fechaFin + 1 : null

        def pedidos = Pedido.createCriteria().list {
            if (fechaInicio) {
                ge("fechaPedido", fechaInicio)
            }
            if (fechaFinMasUno) {
                lt("fechaPedido", fechaFinMasUno)
            }
            order("fechaPedido", "desc")
        }
        [pedidos: pedidos, params: params]
    }

    def buscar_ajax() {
        def fechaInicio = params.fechaInicio ? Date.parse('yyyy-MM-dd', params.fechaInicio) : null
        def fechaFin = params.fechaFin ? Date.parse('yyyy-MM-dd', params.fechaFin) : null
        def fechaFinMasUno = fechaFin ? fechaFin + 1 : null

        def pedidos = Pedido.createCriteria().list {
            if (fechaInicio) {
                ge("fechaPedido", fechaInicio)
            }
            if (fechaFinMasUno) {
                lt("fechaPedido", fechaFinMasUno)
            }
            order("fechaPedido", "desc")
        }
        def totalSQL = pedidos.size()
        render(template: 'buscar_ajax', model: [
            pedidos: pedidos,
            totalSQL: totalSQL,
            params: params
        ])
    }

    def show_ajax() {
        def pedido = Pedido.get(params.id)
        [pedidoInstance: pedido]
    }
}
