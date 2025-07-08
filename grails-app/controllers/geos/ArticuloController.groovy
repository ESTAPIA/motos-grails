package geos

class ArticuloController {

    def list() {
        def articulos = Articulo.list([sort: 'nombre'])
        [articulos: articulos]
    }

    def form_ajax() {
        def articulo = params.id ? Articulo.get(params.id) : new Articulo()
        def tiposAccesorio = TipoAccesorio.list(sort: 'tipoDeAccesorio')
        [articuloInstance: articulo, tiposAccesorio: tiposAccesorio]
    }

    def save_ajax() {
        def articulo = params.id ? Articulo.get(params.id) : new Articulo()
        articulo.properties = params

        // Asignar el tipo de accesorio si viene el id
        if (params.tipoAccesorio) {
            articulo.tipoAccesorio = TipoAccesorio.get(params.tipoAccesorio)
        }

        if (!articulo.save(flush: true)) {
            render "no"
        } else {
            render "ok"
        }
    }

    def delete_ajax() {
        def articulo = Articulo.get(params.id)
        if (articulo) {
            try {
                articulo.delete(flush: true)
                render "ok"
            } catch (org.springframework.dao.DataIntegrityViolationException e) {
                // Error de clave foránea - el artículo está siendo usado
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
        def articulo = Articulo.get(params.id)
        [articuloInstance: articulo]
    }

    def buscar_ajax() {
        def filtro = params.filtro?.trim()
        def articulos = []
        def totalSQL = 0

        if (filtro && filtro != '') {
            articulos = Articulo.findAllByNombreIlike("%${filtro}%")
            totalSQL = articulos.size()
        } else {
            articulos = Articulo.list([sort: 'nombre'])
            totalSQL = articulos.size()
        }

        render(template: 'buscar_ajax', model: [
            articulos: articulos,
            totalSQL: totalSQL,
            filtro: filtro
        ])
    }

    def buscar_cliente_ajax() {
        def filtro = params.filtro?.trim()
        def tipoId = params.tipoId
        def articulos = Articulo.createCriteria().list {
            if (tipoId) {
                eq("tipoAccesorio.id", tipoId.toLong())
            }
            if (filtro) {
                ilike("nombre", "%${filtro}%")
            }
            order("nombre", "asc")
        }
        render(template: '/cliente/tablaArticulos', model: [articulos: articulos])
    }
}
