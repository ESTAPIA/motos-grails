package seguridad

class WardInterceptor {

    WardInterceptor() {
        matchAll()
            .excludes(controller:'login')
            .excludes(controller:'registro') // Permitir acceso libre al registro
    }

    boolean before() {
//        println "sesión: ${session.usuario}"
//        println "acción: " + actionName + " controlador: " + controllerName + " params: $params"
        session.an = actionName
        session.cn = controllerName
        session.pr = params
        def usro

        // Permitir acceso a endpoints AJAX específicos de TipoPersona
        if (controllerName == 'tipoPersona' && 
            (actionName == 'validarDescripcion' || actionName == 'checkDelete')) {
            return true
        }

        if(session.usuario){
            return true
        } else {
            if (!session?.usuario && !session?.perfil) {
                if(controllerName != "login" && actionName != "login") {
                    flash.message = "Favor ingrese el sistema para utilizarlo"
                }
                render "<script type='text/javascript'> window.location.href = '/' </script>"
                session.finalize()
                return false
            }
        }

        true
    }

    boolean after() {
//        println "+++++después"
        true
    }

    void afterView() {
//        println "+++++afterview"
        // no-op
    }


}
