package geos

class Factura {
    Pedido pedido
    Date fechaEmision
    BigDecimal total

    static hasMany = [detalles: DetalleFactura]

    static mapping = {
        table 'fact'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'fact__id'
            pedido column: 'pedd__id'
            fechaEmision column: 'factfcem'
            total column: 'factttl'
        }
    }

    static constraints = {
        pedido(nullable: false, unique: true,
               attributes: [title: 'Pedido facturado'])
        fechaEmision(nullable: false,
                    attributes: [title: 'Fecha de emisión'])
        total(min: 0.0, scale: 2,
              attributes: [title: 'Total facturado'])
    }

    def beforeInsert() {
        if (!fechaEmision) {
            fechaEmision = new Date()
        }
    }

    String toString() {
        return "Factura #${this.id} - ${this.fechaEmision?.format('dd/MM/yyyy')}"
    }
}
