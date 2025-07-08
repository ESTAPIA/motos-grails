package geos

class TipoPersona {
    String descripcion
    Date dateCreated
    Date lastUpdated

    static mapping = {
        table 'tppr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        autoTimestamp true  // Habilita timestamps automáticos
        columns {
            id column: 'tppr__id'
            descripcion column: 'tpprdscr'
            dateCreated column: 'tpprdtcr'
            lastUpdated column: 'tpprdtup'
        }
    }

    static constraints = {
        descripcion(blank: false, nullable: false, size: 1..50, 
                   attributes: [title: 'Tipo de persona'])
        dateCreated(nullable: true)
        lastUpdated(nullable: true)
    }

    String toString() {
        return "${this.descripcion}"
    }
}
