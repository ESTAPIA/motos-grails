package geos

class Persona {

    String cedula
    String nombre
    String apellido
    Date fechaInicio
    Date fechaFin
    String sexo
    String mail
    String login
    String password
    int activo
    String telefono
    String direccion
    TipoPersona tipoPersona
    Perfil perfil


    static mapping = {
        table 'prsn'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'prsn__id'
            cedula column: 'prsncdla'
            nombre column: 'prsnnmbr'
            apellido column: 'prsnapll'
            fechaInicio column: 'prsnfcin'
            fechaFin column: 'prsnfcfn'
            sexo column: 'prsnsexo'
            mail column: 'prsnmail'
            login column: 'prsnlogn'
            password column: 'prsnpass'
            activo column: 'prsnactv'
            telefono column: 'prsntelf'
            direccion column: 'prsndire'
            tipoPersona column: 'tppr__id'
            perfil column: 'prfl__id'
        }
    }
    static constraints = {
        cedula(blank: true, nullable: true)
        nombre(size: 3..31, blank: false)
        apellido(size: 0..31, blank: true, nullable: true)
        fechaInicio(blank: true, nullable: true, attributes: [title: 'Fecha de inicio'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'Fecha de finalización'])
        sexo(blank: true, nullable: true, attributes: ['mensaje': 'Sexo de la persona'])
        mail(size: 3..255, blank: false, nullable: false)
        login(size: 0..255, blank: true, nullable: true, unique: true)
        password(size: 0..63, blank: true, nullable: true)
        telefono(size: 0..31, blank: true, nullable: true, attributes: [title: 'teléfono'])
        activo(blank: false, attributes: [title: 'activo'])
        direccion(size: 0..255, blank: true, nullable: true)
        tipoPersona(nullable: false, attributes: [title: 'Tipo de persona'])
        perfil(nullable: true, attributes: [title: 'Perfil del usuario'])
    }

    String toString() {
        "${this.id}: ${this.nombre} ${this.apellido ?: ''}"
    }

}
