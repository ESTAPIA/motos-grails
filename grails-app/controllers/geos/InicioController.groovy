package geos

class InicioController {

    def beforeInterceptor = {
        println "DEBUG SESSION usuario: ${session.usuario} perfil: ${session.perfil} codigo: ${session.perfil?.codigo}"
        if (!session.usuario || !session.perfil || session.perfil.codigo != 'ADM') {
            flash.message = "Acceso restringido solo para administradores"
            redirect(controller: "login", action: "login")
            return false // Esto es fundamental para que NO siga ejecutando la acción
        }
    }

    def index() { }
}
