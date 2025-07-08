package geos

import org.apache.commons.codec.digest.DigestUtils // <-- Agrega este import

class LoginController {

    def index() {
        redirect(controller: 'login', action: 'login')
    }

    def login() {
        def usro = session.usuario
        def cn = "inicio"
        def an = "index"
        if (usro) {
            redirect(controller: cn, action: an)
        }
    }

    def validar() {
        println "=== INICIO VALIDACION ==="
        println "Parámetros recibidos: ${params}"
        
        // Calcular el hash MD5 de la contraseña ingresada
        def md5Pass = params.pass ? DigestUtils.md5Hex(params.pass.toString()) : null

        def userList = Persona.withCriteria {
            eq("login", params.login, [ignoreCase: true])
            eq("activo", 1)
            eq("password", md5Pass) // Comparar usando el hash MD5
        }
        
        println "userList: ${userList} size: ${userList?.size()}"
        
        if (!userList || userList.size() == 0) {
            flash.message = "Usuario o contraseña incorrectos"
            redirect(controller: 'login', action: "login")
            return
        }
        
        def user = userList[0]  // Obtener el primer usuario de la lista
        println "usuario encontrado: ${user.nombre} login: ${user.login}"

        // Verificar si tiene perfil directo o sesiones activas
        def tienePerfilDirecto = user.perfil != null
        def sesionesActivas = Sesion.findAllByUsuarioAndFechaFinIsNull(user)
        
        println "Perfil directo: ${user.perfil} - Sesiones activas: ${sesionesActivas.size()}"
        
        // Si el usuario es cliente, redirigir directo a su área
        if (user.perfil?.codigo == 'CLI') {
            session.usuario = user
            session.perfil = user.perfil

            // Crear registro de sesión en la base de datos
            def sesion = new Sesion(
                usuario: user,
                perfil: user.perfil,
                fechaInicio: new Date()
            )
            sesion.save(flush: true)
            session.sesionId = sesion.id

            redirect(controller: 'cliente', action: 'index')
            return
        }

        if (tienePerfilDirecto || sesionesActivas.size() > 0) {
            session.usuario = user

            // Crear registro de sesión en la base de datos (perfil aún no seleccionado)
            def perfil = user.perfil ?: (sesionesActivas ? sesionesActivas[0].perfil : null)
            if (perfil) {
                session.perfil = perfil
                def sesion = new Sesion(
                    usuario: user,
                    perfil: perfil,
                    fechaInicio: new Date()
                )
                sesion.save(flush: true)
                session.sesionId = sesion.id
            }

            redirect(controller: 'login', action: "perfiles")
            return
        } else {
            flash.message = "No hay perfiles definidos para este usuario"
            redirect(controller: 'login', action: "login")
        }
    }


    def perfiles() {
        // Solo mostrar selección si tiene más de un perfil y no es cliente
        def usuarioLog = session.usuario
        if (usuarioLog?.perfil?.codigo == 'CLI') {
            redirect(controller: 'cliente', action: 'index')
            return
        }
        def perfiles = []
        
        // Agregar perfil directo si existe
        if (usuarioLog.perfil) {
            perfiles.add(usuarioLog.perfil)
        }
        
        // Agregar perfiles de sesiones activas
        def perfilesUsr = Sesion.findAllByUsuarioAndFechaFinIsNull(usuarioLog, [sort: 'perfil'])
        perfilesUsr.each { sesion ->
            if (sesion.fechaFin == null && !perfiles.contains(sesion.perfil)) {
                perfiles.add(sesion.perfil)
            }
        }
        
        println "---- perfiles ---- ${perfiles} --> ${perfiles.collect{it.id}}"
        // Elimina duplicados por id
        def perfilesUnicos = perfiles.unique { it.id }
        return [perfilesUsr: perfilesUnicos.sort { it.descripcion }]
    }

    def savePer() {
        println ("entra en el sistema" + params)
        def prfl = Perfil.get(params.prfl)
        if (prfl) {
            session.perfil = prfl

            // Crear registro de sesión en la base de datos al elegir perfil
            def sesion = new Sesion(
                usuario: session.usuario,
                perfil: prfl,
                fechaInicio: new Date()
            )
            sesion.save(flush: true)
            session.sesionId = sesion.id

            redirect(controller: 'inicio', action: 'index')
        } else {
            redirect(controller: 'login', action: "login")
        }
    }

    def logout() {
        // Cerrar la sesión en la base de datos
        if (session.sesionId) {
            def sesion = Sesion.get(session.sesionId)
            if (sesion && !sesion.fechaFin) {
                sesion.fechaFin = new Date()
                sesion.save(flush: true)
            }
        }
        session.usuario = null
        session.perfil = null
        session.an = null
        session.cn = null
        session.sesionId = null
        session.invalidate()

        redirect(controller: 'login', action: 'login')
    }


}
