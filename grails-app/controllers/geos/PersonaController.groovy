package geos

import grails.converters.JSON

import groovy.sql.Sql

class PersonaController {

    def dataSource    // Inyección del dataSource

    def conectarDB() {
        return new Sql(dataSource)
    }

    def list() {
        def personas = Persona.list([sort: 'nombre'])

        return [personas: personas]
    }

    def form_ajax() {
        def persona = params.id ? Persona.get(params.id) : new Persona()
        [
            personaInstance: persona,
            tiposPersona: TipoPersona.list(sort: 'descripcion', order: 'asc'),
            perfiles: Perfil.list(sort: 'nombre', order: 'asc')
        ]
    }

    def save_ajax(){
        println "guarda persona: $params"
        def persona

        if(params.id){
            persona = Persona.get(params.id)
        }else{
            persona = new Persona()
        }

        // Guardar la contraseña actual antes de asignar las propiedades
        def passwordActual = persona.password

        persona.properties = params

        // Asignar TipoPersona si viene el id
        if(params.tipoPersona) {
            persona.tipoPersona = TipoPersona.get(params.tipoPersona)
        }

        // Solo encriptar la contraseña si es nueva o ha cambiado realmente
        if(params.password) {
            if(!params.id) {
                // Persona nueva - siempre encriptar
                persona.password = params.password.encodeAsMD5()
            } else {
                // Persona existente - solo encriptar si la contraseña cambió
                def passwordNuevoHash = params.password.encodeAsMD5()
                if(passwordNuevoHash != passwordActual) {
                    // La contraseña cambió, usar el nuevo hash
                    persona.password = passwordNuevoHash
                } else {
                    // La contraseña no cambió, mantener la actual
                    persona.password = passwordActual
                }
            }
        }

        if(!persona.save(flush:true)){
            println("error al guardar la persona " + persona.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){
        println "elimina persona: $params"
        def persona

        if(params.id){
            persona = Persona.get(params.id)
            if(persona){
                try {
                    persona.delete(flush: true)
                    render "ok"
                } catch (Exception e) {
                    println("error al eliminar la persona: " + e.message)
                    render "no"
                }
            } else {
                render "no"
            }
        } else {
            render "no"
        }
    }

    def show_ajax(){
        def persona
        if(params.id) {
            persona = Persona.get(params.id)
        }
        return [personaInstance: persona]
    }

    def buscar_ajax(){
        println "buscar personas: $params"
        def filtro = params.filtro?.trim()
        def personas = []
        def totalSQL = 0
        
        if(filtro && filtro != '') {
            // Buscar por nombre, apellido, login o email
            personas = Persona.findAll(
                "FROM Persona p WHERE " +
                "LOWER(p.nombre) LIKE LOWER(:filtro) OR " +
                "LOWER(p.apellido) LIKE LOWER(:filtro) OR " +
                "LOWER(p.login) LIKE LOWER(:filtro) OR " +
                "LOWER(p.mail) LIKE LOWER(:filtro)",
                [filtro: "%${filtro}%"]
            )
            
            // Conteo simple - usar GORM primero
            totalSQL = personas.size()
        } else {
            // Si no hay filtro, devolver todas
            personas = Persona.list([sort: 'nombre'])
            totalSQL = personas.size()
        }
        
        println "Personas encontradas: ${totalSQL}"
        
        // Renderizar la vista _buscar_ajax.gsp
        render(template: 'buscar_ajax', model: [
            personas: personas,
            totalSQL: totalSQL,
            filtro: filtro
        ])
    }

    def contar() {
        def sql = conectarDB()
        
        try {
            // Consulta 1: Contar registros en la tabla prsn
            def totalPersonas = sql.firstRow("SELECT COUNT(*) as total FROM prsn")
            
            // Consulta 2: Obtener la fecha actual del servidor de base de datos
            def fechaServidor = sql.firstRow("SELECT CURRENT_DATE as fecha")
            
            // Mostrar los resultados
            def resultado = """
                <h3>Consultas SQL Directas</h3>
                <p><strong>Total de personas en tabla 'prsn':</strong> ${totalPersonas.total}</p>
                <p><strong>Fecha del servidor:</strong> ${fechaServidor.fecha}</p>
            """
            
            render resultado
            
        } catch (Exception e) {
            println "Error: ${e.message}"
            render "Error al ejecutar consultas: ${e.message}"
        } finally {
            sql.close()
        }
    }
    
    def beforeInterceptor = {
        // Solo el admin puede acceder al CRUD de personas
        if (!session.usuario || !session.perfil || session.perfil.codigo != 'ADM') {
            flash.message = "Acceso restringido solo para administradores"
            redirect(controller: "login", action: "login")
            return false
        }
        true
    }

    def create() {
        def tipoCliente = TipoPersona.findByDescripcionIlike("Cliente")
        def perfilCliente = Perfil.findByCodigo("CLI")
        def persona = new Persona(params)
        persona.tipoPersona = tipoCliente
        persona.perfil = perfilCliente
        respond persona, model: [
            tiposPersona: [tipoCliente],
            perfiles: Perfil.list(sort: 'nombre', order: 'asc')
        ]
    }

    def edit(Long id) {
        def personaInstance = Persona.get(id)
        if (!personaInstance) {
            notFound()
            return
        }
        respond personaInstance, model: [
            tiposPersona: TipoPersona.list(sort:'descripcion', order:'asc'),
            perfiles: Perfil.list(sort: 'nombre', order: 'asc')
        ]
    }

}
