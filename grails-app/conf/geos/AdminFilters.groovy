package geos

class AdminFilters {

    def filters = {
        adminOnly(controller: 'inicio|persona|articulo|tipoAccesorio|tipoPersona|perfil', action: '*') {
            before = {
                println "FILTRO ADMIN: usuario=${session.usuario} perfil=${session.perfil} codigo=${session.perfil?.codigo}"
                if (!session.usuario || !session.perfil || session.perfil.codigo != 'ADM') {
                    flash.message = "Acceso restringido solo para administradores"
                    redirect(controller: "login", action: "login")
                    return false
                }
            }
        }
    }
}
