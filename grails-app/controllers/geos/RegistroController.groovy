package geos

class RegistroController {

    def index() {
        render(view: "index")
    }

    def guardar() {
        def paramsPersona = params
        // Buscar tipo y perfil de cliente de forma robusta
        def tipoCliente = TipoPersona.findByDescripcionIlike("%Cliente%")
        def perfilCliente = Perfil.findByCodigo("CLI")
        if (!tipoCliente || !perfilCliente) {
            flash.message = "No se encuentra el tipo o perfil 'Cliente'. Contacte al administrador."
            redirect(controller: "login", action: "login")
            return
        }
        def persona = new Persona(paramsPersona)
        persona.tipoPersona = tipoCliente
        persona.perfil = perfilCliente
        persona.activo = 1

        // Encriptar la contraseña
        if (paramsPersona.password) {
            persona.password = paramsPersona.password.encodeAsMD5()
        }

        if (!persona.save(flush: true)) {
            flash.message = "No se pudo registrar: ${persona.errors.allErrors*.defaultMessage?.join(', ')}"
            render(view: "index", model: [persona: persona])
            return
        }
        flash.message = "Registro exitoso. Ahora puede iniciar sesión."
        redirect(controller: "login", action: "login")
    }
}
