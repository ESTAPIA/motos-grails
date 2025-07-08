package geos

class PerfilController {

    def list() {
        def perfiles = Perfil.list([sort: 'nombre'])
        [perfiles: perfiles]
    }

    def form_ajax() {
        def perfil = params.id ? Perfil.get(params.id) : new Perfil()
        def perfilesPadre = Perfil.list(sort: 'nombre')
        [perfilInstance: perfil, perfilesPadre: perfilesPadre]
    }

    def save_ajax() {
        def perfil = params.id ? Perfil.get(params.id) : new Perfil()
        perfil.properties = params

        // Asignar perfil padre si viene el id
        if (params.padre) {
            perfil.padre = Perfil.get(params.padre)
        }

        if (!perfil.save(flush: true)) {
            render "no"
        } else {
            render "ok"
        }
    }

    def delete_ajax() {
        def perfil = Perfil.get(params.id)
        if (perfil) {
            try {
                perfil.delete(flush: true)
                render "ok"
            } catch (org.springframework.dao.DataIntegrityViolationException e) {
                // Error por restricción de llave foránea (perfil en uso)
                render "enUso"
            } catch (Exception e) {
                render "no"
            }
        } else {
            render "no"
        }
    }

    def show_ajax() {
        def perfil = Perfil.get(params.id)
        [perfilInstance: perfil]
    }

    def buscar_ajax() {
        def filtro = params.filtro?.trim()
        def perfiles = []
        def totalSQL = 0

        if (filtro && filtro != '') {
            perfiles = Perfil.findAllByNombreIlike("%${filtro}%")
            totalSQL = perfiles.size()
        } else {
            perfiles = Perfil.list([sort: 'nombre'])
            totalSQL = perfiles.size()
        }

        render(template: 'buscar_ajax', model: [
            perfiles: perfiles,
            totalSQL: totalSQL,
            filtro: filtro
        ])
    }
}
