package geos

class DetallePedido {
    Pedido pedido
    Articulo articulo
    Integer cantidad
    BigDecimal precioUnitario

    static belongsTo = [pedido: Pedido]

    static mapping = {
        table 'dtpd'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dtpd__id'
            pedido column: 'pedd__id'
            articulo column: 'artc__id'
            cantidad column: 'dtpdcntd'
            precioUnitario column: 'dtpdprun'
        }
    }

    static constraints = {
        pedido(nullable: false,
               attributes: [title: 'Pedido'])
        articulo(nullable: false,
                attributes: [title: 'Artículo'])
        cantidad(min: 1,
                attributes: [title: 'Cantidad'])
        precioUnitario(min: 0.0, scale: 2,
                      attributes: [title: 'Precio unitario'])
    }

    BigDecimal getSubtotal() {
        return cantidad * precioUnitario
    }

    String toString() {
        return "${this.cantidad}x ${this.articulo?.nombre} @ \$${this.precioUnitario}"
    }
}
