package geos

class TipoAccesorio {
    String tipoDeAccesorio

    static mapping = {
        table 'tpac'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'tpac__id'
            tipoDeAccesorio column: 'tpactpac'
        }
    }

    static constraints = {
        tipoDeAccesorio(blank: false, nullable: false, size: 1..50,
                       attributes: [title: 'Tipo de accesorio'])
    }

    String toString() {
        return "${this.tipoDeAccesorio}"
    }
}
