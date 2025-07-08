package geos

class SesionController {

    def list() {
        def sesiones = Sesion.list([sort: 'fechaInicio', order: 'desc'])
        def perfiles = Perfil.list(sort: 'nombre')
        [sesiones: sesiones, perfiles: perfiles]
    }

    def show_ajax() {
        def sesion = Sesion.get(params.id)
        [sesionInstance: sesion]
    }

    def buscar_ajax() {
        def perfilId = params.perfilId
        def sesiones = Sesion.createCriteria().list {
            if (perfilId) {
                eq("perfil.id", perfilId.toLong())
            }
            order("fechaInicio", "desc")
        }
        render(template: 'buscar_ajax', model: [sesiones: sesiones])
    }
}