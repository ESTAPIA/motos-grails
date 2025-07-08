package geos

import grails.converters.JSON

class TipoPersonaController {

    static allowedMethods = [save: "POST", update: ["PUT", "POST"], delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        
        def tipoPersonaList
        def tipoPersonaCount
        
        // Si hay búsqueda, filtrar resultados
        if (params.search) {
            def searchPattern = "%${params.search}%"
            tipoPersonaList = TipoPersona.findAllByDescripcionIlike(searchPattern, params)
            tipoPersonaCount = TipoPersona.countByDescripcionIlike(searchPattern)
        } else {
            tipoPersonaList = TipoPersona.list(params)
            tipoPersonaCount = TipoPersona.count()
        }
        
        // Si es una petición AJAX, devolver solo la tabla
        if (request.xhr) {
            render(template: 'tabla', model: [tipoPersonaList: tipoPersonaList, tipoPersonaCount: tipoPersonaCount])
            return
        }
        
        respond tipoPersonaList, model: [tipoPersonaCount: tipoPersonaCount]
    }

    def show(Long id) {
        def tipoPersona = TipoPersona.get(id)
        if (!tipoPersona) {
            flash.error = "El tipo de persona solicitado no existe"
            redirect(action: "index")
            return
        }
        
        // Contar personas asociadas a este tipo
        def personasAsociadas = Persona.countByTipoPersona(tipoPersona)
        
        respond tipoPersona, model: [personasAsociadas: personasAsociadas]
    }

    def create() {
        respond new TipoPersona(params)
    }

    def save() {
        def tipoPersona = new TipoPersona(params)
        
        try {
            tipoPersona.validate()
            
            if (tipoPersona.hasErrors()) {
                if (request.xhr) {
                    def response = [success: false, errors: tipoPersona.errors.allErrors.collect { 
                        [field: it.field, message: message(error: it)] 
                    }]
                    render(status: 400, text: response as JSON, contentType: 'application/json')
                    return
                }
                respond tipoPersona.errors, view: 'create'
                return
            }

            tipoPersona.save(flush: true)

            if (request.xhr) {
                def response = [success: true, message: "Tipo de persona '${tipoPersona.descripcion}' creado exitosamente", id: tipoPersona.id]
                render response as JSON
                return
            }

            flash.success = "Tipo de persona '${tipoPersona.descripcion}' creado exitosamente"
            redirect(action: "show", id: tipoPersona.id)

        } catch (Exception e) {
            log.error "Error al guardar tipo de persona: ${e.message}", e
            
            if (request.xhr) {
                def response = [success: false, message: "Error interno del servidor"]
                render(status: 500, text: response as JSON, contentType: 'application/json')
                return
            }
            
            flash.error = "Error al crear el tipo de persona. Inténtelo nuevamente."
            respond tipoPersona.errors, view: 'create'
        }
    }

    def edit(Long id) {
        def tipoPersona = TipoPersona.get(id)
        if (!tipoPersona) {
            flash.error = "El tipo de persona solicitado no existe"
            redirect(action: "index")
            return
        }
        respond tipoPersona
    }

    def update(Long id) {
        def tipoPersona = TipoPersona.get(id)
        if (!tipoPersona) {
            notFound()
            return
        }

        try {
            tipoPersona.properties = params
            tipoPersona.validate()
            
            if (tipoPersona.hasErrors()) {
                if (request.xhr) {
                    def response = [success: false, errors: tipoPersona.errors.allErrors.collect { 
                        [field: it.field, message: message(error: it)] 
                    }]
                    render(status: 400, text: response as JSON, contentType: 'application/json')
                    return
                }
                respond tipoPersona.errors, view: 'edit'
                return
            }

            tipoPersona.save(flush: true)

            if (request.xhr) {
                def response = [success: true, message: "Tipo de persona '${tipoPersona.descripcion}' actualizado exitosamente"]
                render response as JSON
                return
            }

            flash.success = "Tipo de persona '${tipoPersona.descripcion}' actualizado exitosamente"
            redirect(action: "show", id: tipoPersona.id)

        } catch (Exception e) {
            log.error "Error al actualizar tipo de persona: ${e.message}", e
            
            if (request.xhr) {
                def response = [success: false, message: "Error interno del servidor"]
                render(status: 500, text: response as JSON, contentType: 'application/json')
                return
            }
            
            flash.error = "Error al actualizar el tipo de persona. Inténtelo nuevamente."
            respond tipoPersona.errors, view: 'edit'
        }
    }

    def delete(Long id) {
        def tipoPersona = TipoPersona.get(id)
        if (tipoPersona == null) {
            notFound()
            return
        }

        try {
            // TODO: Cuando se implemente Persona, descomentar estas líneas
            // def personasAsociadas = Persona.countByTipoPersona(tipoPersona)
            def personasAsociadas = 0 // Temporalmente 0 hasta implementar Persona
            
            if (personasAsociadas > 0) {
                if (request.xhr) {
                    def response = [success: false, message: "No se puede eliminar el tipo '${tipoPersona.descripcion}' porque tiene ${personasAsociadas} persona(s) asociada(s)"]
                    render(status: 400, text: response as JSON, contentType: 'application/json')
                    return
                }
                
                flash.error = "No se puede eliminar el tipo '${tipoPersona.descripcion}' porque tiene ${personasAsociadas} persona(s) asociada(s)"
                redirect(action: "show", id: tipoPersona.id)
                return
            }

            // Verificar si es un tipo predeterminado que no se puede eliminar
            def tiposProtegidos = ['Cliente', 'Empleado', 'Administrador']
            if (tiposProtegidos.contains(tipoPersona.descripcion)) {
                if (request.xhr) {
                    def response = [success: false, message: "No se puede eliminar el tipo '${tipoPersona.descripcion}' porque es un tipo predeterminado del sistema"]
                    render(status: 400, text: response as JSON, contentType: 'application/json')
                    return
                }
                
                flash.error = "No se puede eliminar el tipo '${tipoPersona.descripcion}' porque es un tipo predeterminado del sistema"
                redirect(action: "show", id: tipoPersona.id)
                return
            }

            def descripcionEliminada = tipoPersona.descripcion
            tipoPersona.delete(flush: true)

            if (request.xhr) {
                def response = [success: true, message: "Tipo de persona '${descripcionEliminada}' eliminado exitosamente"]
                render response as JSON
                return
            }

            flash.success = "Tipo de persona '${descripcionEliminada}' eliminado exitosamente"
            redirect(action: "index")

        } catch (Exception e) {
            log.error "Error al eliminar tipo de persona: ${e.message}", e
            
            if (request.xhr) {
                def response = [success: false, message: "Error interno del servidor"]
                render(status: 500, text: response as JSON, contentType: 'application/json')
                return
            }
            
            flash.error = "Error al eliminar el tipo de persona. Inténtelo nuevamente."
            redirect(action: "show", id: tipoPersona.id)
        }
    }

    // AJAX: Verificar si se puede eliminar un tipo de persona
    def checkDelete(Long id) {
        def tipoPersona = TipoPersona.get(id)
        if (tipoPersona == null) {
            def response = [success: false, message: "Tipo de persona no encontrado"]
            render(status: 404, text: response as JSON, contentType: 'application/json')
            return
        }

        // Contar personas asociadas a este tipo
        def personasAsociadas = Persona.countByTipoPersona(tipoPersona)
        def tiposProtegidos = ['Cliente', 'Empleado', 'Administrador']
        def esProtegido = tiposProtegidos.contains(tipoPersona.descripcion)

        def response = [
            canDelete: personasAsociadas == 0 && !esProtegido,
            personasAsociadas: personasAsociadas,
            esProtegido: esProtegido,
            mensaje: esProtegido ? 
                "Este es un tipo predeterminado del sistema y no se puede eliminar" :
                personasAsociadas > 0 ? 
                    "Este tipo tiene ${personasAsociadas} persona(s) asociada(s)" :
                    "Este tipo se puede eliminar de forma segura"
        ]
        render response as JSON
    }

    // AJAX: Validar unicidad del nombre
    def validarDescripcion() {
        log.info "=== INICIO validarDescripcion ==="
        log.info "Parámetros recibidos: ${params}"
        
        def descripcion = params.descripcion?.trim()
        def id = params.id ? params.id.toLong() : null
        
        log.info "Descripción procesada: '${descripcion}'"
        log.info "ID procesado: ${id}"
        
        if (!descripcion) {
            log.info "Descripción vacía, retornando error"
            def response = [valid: false, message: "La descripción es requerida"]
            render response as JSON
            return
        }

        if (descripcion.length() < 3) {
            log.info "Descripción muy corta, retornando error"
            def response = [valid: false, message: "La descripción debe tener al menos 3 caracteres"]
            render response as JSON
            return
        }

        if (descripcion.length() > 50) {
            log.info "Descripción muy larga, retornando error"
            def response = [valid: false, message: "La descripción no puede exceder 50 caracteres"]
            render response as JSON
            return
        }

        def existe = false
        if (id) {
            // Verificar que no exista otro registro con la misma descripción (excluyendo el actual)
            log.info "Verificando existencia excluyendo ID: ${id}"
            existe = TipoPersona.countByDescripcionIlikeAndIdNotEqual(descripcion, id) > 0
        } else {
            // Verificar que no exista ningún registro con esa descripción
            log.info "Verificando existencia sin excluir ningún ID"
            existe = TipoPersona.countByDescripcionIlike(descripcion) > 0
        }

        log.info "Existe: ${existe}"
        log.info "Retornando respuesta JSON"
        
        def response = [valid: !existe, message: existe ? "Ya existe un tipo de persona con esa descripción" : "Descripción disponible"]
        log.info "Response to render: ${response}"
        
        // Probando con render directo sin closure
        render response as JSON
        
        log.info "=== FIN validarDescripcion ==="
    }

    // API: Obtener lista de tipos para selects dinámicos
    def getForSelect() {
        def tipos = TipoPersona.list(sort: 'descripcion', order: 'asc')
        
        def response = tipos.collect { [id: it.id, descripcion: it.descripcion] }
        render response as JSON
    }

    def list() {
        def tipoPersonas = TipoPersona.list([sort: 'descripcion'])
        [tipoPersonas: tipoPersonas]
    }

    def form_ajax() {
        def tipoPersona = params.id ? TipoPersona.get(params.id) : new TipoPersona()
        [tipoPersonaInstance: tipoPersona]
    }

    def save_ajax() {
        def tipoPersona = params.id ? TipoPersona.get(params.id) : new TipoPersona()
        tipoPersona.properties = params

        if (!tipoPersona.save(flush: true)) {
            render "no"
        } else {
            render "ok"
        }
    }

    def delete_ajax() {
        def tipoPersona = TipoPersona.get(params.id)
        if (tipoPersona) {
            try {
                tipoPersona.delete(flush: true)
                render "ok"
            } catch (org.springframework.dao.DataIntegrityViolationException e) {
                // Error por restricción de llave foránea (tipo en uso)
                render "enUso"
            } catch (Exception e) {
                render "no"
            }
        } else {
            render "no"
        }
    }

    def show_ajax() {
        def tipoPersona = TipoPersona.get(params.id)
        [tipoPersonaInstance: tipoPersona]
    }

    def buscar_ajax() {
        def filtro = params.filtro?.trim()
        def tipoPersonas = []
        def totalSQL = 0

        if (filtro && filtro != '') {
            tipoPersonas = TipoPersona.findAllByDescripcionIlike("%${filtro}%")
            totalSQL = tipoPersonas.size()
        } else {
            tipoPersonas = TipoPersona.list([sort: 'descripcion'])
            totalSQL = tipoPersonas.size()
        }

        render(template: 'buscar_ajax', model: [
            tipoPersonas: tipoPersonas,
            totalSQL: totalSQL,
            filtro: filtro
        ])
    }

    protected void notFound() {
        if (request.xhr) {
            def response = [success: false, message: "Tipo de persona no encontrado"]
            render(status: 404, text: response as JSON, contentType: 'application/json')
        } else {
            flash.error = "Tipo de persona no encontrado"
            redirect(action: "index")
        }
    }
}
