package geos

class Perfil {
    String nombre
    String descripcion
    Perfil padre
    String observaciones
    String codigo

    static mapping = {
        table 'prfl'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'prfl__id'
            nombre column: 'prflnmbr'
            descripcion column: 'prfldscr'
            padre column: 'prflpdre'
            observaciones column: 'prflobsr'
            codigo column: 'prflcdgo'
        }
    }

    static constraints = {
        padre(blank: true, nullable: true)
        observaciones(blank: true, nullable: true)
    }

    String toString() {
        return "${this.nombre}"
    }
}
