package geos

class Sesion {
    Persona usuario
    Perfil perfil
    Date fechaInicio
    Date fechaFin

    static mapping = {
        table 'sesn'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort "perfil"
        columns {
            id column: 'sesn__id'
            perfil column: 'prfl__id'
            usuario column: 'prsn__id'
            fechaInicio column: 'sesnfcin'
            fechaFin column: 'sesnfcfn'
        }
    }

    static constraints = {
        fechaInicio(blank: true, nullable: true)
        fechaFin(blank: true, nullable: true)
    }

    String toString() {
        return "${this.perfil}"
    }
}