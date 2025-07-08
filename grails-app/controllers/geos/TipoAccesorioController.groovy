package geos

import grails.converters.JSON

class TipoAccesorioController {

    def list() {
        def tipoAccesorios = TipoAccesorio.list([sort: 'tipoDeAccesorio'])
        [tipoAccesorios: tipoAccesorios]
    }

    def form_ajax() {
        def tipoAccesorio = params.id ? TipoAccesorio.get(params.id) : new TipoAccesorio()
        [tipoAccesorioInstance: tipoAccesorio]
    }

    def save_ajax() {
        def tipoAccesorio
        if (params.id) {
            tipoAccesorio = TipoAccesorio.get(params.id)
        } else {
            tipoAccesorio = new TipoAccesorio()
        }
        tipoAccesorio.properties = params

        if (!tipoAccesorio.save(flush: true)) {
            render "no"
        } else {
            render "ok"
        }
    }

    def delete_ajax() {
        def tipoAccesorio = TipoAccesorio.get(params.id)
        if (tipoAccesorio) {
            try {
                tipoAccesorio.delete(flush: true)
                render "ok"
            } catch (org.springframework.dao.DataIntegrityViolationException e) {
                // Error de clave foránea - el tipo está siendo usado por artículos
                render "referenced"
            } catch (Exception e) {
                // Otros errores
                render "error"
            }
        } else {
            render "not_found"
        }
    }

    def show_ajax() {
        def tipoAccesorio = TipoAccesorio.get(params.id)
        [tipoAccesorioInstance: tipoAccesorio]
    }

    def buscar_ajax() {
        def filtro = params.filtro?.trim()
        def tipoAccesorios = []
        def totalSQL = 0

        if (filtro && filtro != '') {
            tipoAccesorios = TipoAccesorio.findAllByTipoDeAccesorioIlike("%${filtro}%")
            totalSQL = tipoAccesorios.size()
        } else {
            tipoAccesorios = TipoAccesorio.list([sort: 'tipoDeAccesorio'])
            totalSQL = tipoAccesorios.size()
        }

        render(template: 'buscar_ajax', model: [
            tipoAccesorios: tipoAccesorios,
            totalSQL: totalSQL,
            filtro: filtro
        ])
    }
}
