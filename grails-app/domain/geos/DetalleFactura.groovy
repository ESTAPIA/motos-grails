package geos

class DetalleFactura {
    Factura factura
    Articulo articulo
    Integer cantidad
    BigDecimal precioUnitario

    static belongsTo = [factura: Factura]

    static mapping = {
        table 'dtft'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dtft__id'
            factura column: 'fact__id'
            articulo column: 'artc__id'
            cantidad column: 'dtftcntd'
            precioUnitario column: 'dtftprun'
        }
    }

    static constraints = {
        factura(nullable: false,
                attributes: [title: 'Factura'])
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
