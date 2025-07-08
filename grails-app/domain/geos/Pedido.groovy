package geos

class Pedido {
    Persona persona
    Date fechaPedido
    String estado

    static hasMany = [detalles: DetallePedido]

    static mapping = {
        table 'pedd'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'pedd__id'
            persona column: 'prsn__id'
            fechaPedido column: 'peddfchp'
            estado column: 'peddestd'
        }
    }

    static constraints = {
        persona(nullable: false,
               attributes: [title: 'Cliente'])
        fechaPedido(nullable: false,
                   attributes: [title: 'Fecha del pedido'])
        estado(blank: false, nullable: false, size: 1..20,
               inList: ["PENDIENTE", "CONFIRMADO", "ENVIADO", "ENTREGADO", "CANCELADO"],
               attributes: [title: 'Estado del pedido'])
    }

    def beforeInsert() {
        if (!fechaPedido) {
            fechaPedido = new Date()
        }
    }

    String toString() {
        return "Pedido #${this.id} - ${this.persona?.nombre} (${this.estado})"
    }
}
