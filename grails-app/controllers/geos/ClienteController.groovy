package geos

import grails.gorm.transactions.Transactional

class ClienteController {

    /* ======================  Sesión  ====================== */

    def index() {
        [usuario: session.usuario]
    }

    def logout() {
        if (session.sesionId) {
            def sesion = Sesion.get(session.sesionId)
            if (sesion && !sesion.fechaFin) {
                sesion.fechaFin = new Date()
                sesion.save(flush: true)
            }
        }
        session.invalidate()      // Esto sí elimina toda la sesión
        redirect(controller: 'login', action: 'login')
    }

    /* ======================  Pedidos  ====================== */

    def pedidos() {
        def usuario = session.usuario
        def estado  = params.estado
        def pedidos = estado ?
            Pedido.findAllByPersonaAndEstado(usuario, estado, [sort: 'fechaPedido', order: 'desc']) :
            Pedido.findAllByPersona(usuario,             [sort: 'fechaPedido', order: 'desc'])

        // Mapa pedido → factura (si existe)
        def facturasPorPedido = [:]
        pedidos.each { ped ->
            facturasPorPedido[ped.id] = Factura.findByPedido(ped)
        }

        [pedidos: pedidos, facturasPorPedido: facturasPorPedido]
    }

    def nuevoPedido() {
        def articulos = Articulo.list(sort: 'nombre')
        def tipos     = TipoAccesorio.list(sort: 'tipoDeAccesorio')
        [articulos: articulos, tipos: tipos]
    }

    /**
     * Crea un pedido y sus detalles respetando el stock disponible.
     * Si algún artículo no tiene stock suficiente se hace rollback y se redirige.
     */
    @Transactional
    def guardarPedido() {

        def usuario = session.usuario
        if (!usuario) {
            flash.message = "Debe iniciar sesión para realizar pedidos."
            redirect(controller: 'login', action: 'login')
            return
        }

        /* ---------- 1. Crear cabecera de pedido ---------- */
        def pedido = new Pedido(
            persona     : usuario,
            fechaPedido : new Date(),
            estado      : "PENDIENTE"
        )
        if (!pedido.save(flush: true)) {
            flash.message = "No se pudo crear el pedido."
            redirect(action: "nuevoPedido")
            return
        }

        /* ---------- 2. Procesar arrays articuloId[] y cantidad[] ---------- */
        def articuloIds   = params.list('articuloId')
        def cantidadesRaw = params.list('cantidad')

        articuloIds.eachWithIndex { artId, idx ->

            def articulo = Articulo.get(artId)
            def cantidad = cantidadesRaw[idx]?.toInteger() ?: 1

            /* 2a. Validación de existencia y stock */
            if (!articulo || cantidad <= 0 || articulo.stock < cantidad) {
                transactionStatus.setRollbackOnly()
                flash.message = "Stock insuficiente para el artículo: ${articulo?.nombre ?: 'desconocido'}."
                redirect(action: "nuevoPedido")
                return
            }

            /* 2b. Crear detalle si pasa la validación */
            new DetallePedido(
                pedido        : pedido,
                articulo      : articulo,
                cantidad      : cantidad,
                precioUnitario: articulo.precioBase ?: 0
            ).save(flush: true)
        }

        flash.message = "Pedido realizado correctamente."
        redirect(action: "pedidos")
    }

    /**
     * Confirma un pedido pendiente, descuenta stock y genera factura (si corresponde).
     */
    @Transactional
    def confirmarPedido(Long id) {

        def pedido = Pedido.get(id)

        if (!(pedido && pedido.persona?.id == session.usuario?.id && pedido.estado == "PENDIENTE")) {
            flash.message = "No se pudo confirmar el pedido."
            redirect(action: "pedidos")
            return
        }

        /* ---------- 1. Verificación final de stock ---------- */
        def sinStock = pedido.detalles.find { it.articulo.stock < it.cantidad }
        if (sinStock) {
            flash.message = "El artículo '${sinStock.articulo.nombre}' no tiene stock suficiente."
            redirect(action: "pedidos")
            return
        }

        /* ---------- 2. Confirmar pedido y descontar stock ---------- */
        pedido.estado = "CONFIRMADO"
        pedido.save(flush: true)

        pedido.detalles.each { det ->
            det.articulo.stock -= det.cantidad
            det.articulo.save(flush: true)
        }

        /* ---------- 3. Generar factura si no existe ---------- */
        if (!Factura.findByPedido(pedido)) {
            def total = pedido.detalles.sum { it.cantidad * it.precioUnitario } ?: 0
            def factura = new Factura(
                pedido      : pedido,
                fechaEmision: new Date(),
                total       : total
            ).save(flush: true)

            pedido.detalles.each { det ->
                new DetalleFactura(
                    factura       : factura,
                    articulo      : det.articulo,
                    cantidad      : det.cantidad,
                    precioUnitario: det.precioUnitario
                ).save(flush: true)
            }
        }

        flash.message = "Pedido confirmado y factura generada correctamente."
        redirect(action: "pedidos")
    }

    /* ======================  Facturas  ====================== */

    def facturas() {
        def usuario     = session.usuario
        def fechaInicio = params.fechaInicio ? Date.parse('yyyy-MM-dd', params.fechaInicio) : null
        def fechaFin    = params.fechaFin    ? Date.parse('yyyy-MM-dd', params.fechaFin)    : null
        def fechaFinMasUno = fechaFin ? fechaFin + 1 : null   // incluye fin de día

        def facturas = Factura.createCriteria().list {
            pedido { eq "persona", usuario }
            if (fechaInicio) { ge "fechaEmision", fechaInicio }
            if (fechaFinMasUno) { lt "fechaEmision", fechaFinMasUno }
            order "fechaEmision", "desc"
        }
        [facturas: facturas]
    }

    def verFactura(Long id) {
        def factura = Factura.get(id)
        if (!factura || factura.pedido?.persona?.id != session.usuario?.id) {
            flash.message = "No existe factura para este pedido o no tiene permiso."
            redirect(action: "facturas")
            return
        }
        
        // Datos adicionales para la vista profesional
        def datosEmpresa = [
            nombre: "Moto-Shop",
            direccion: "Calle Principal #123, Ciudad",
            telefono: "(+57) 123-456-7890",
            email: "contacto@motosguido.com",
            ruc: "900.123.456-7"
        ]
        
        [factura: factura, datosEmpresa: datosEmpresa]
    }
}

