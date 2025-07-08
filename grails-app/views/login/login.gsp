<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="login">
    <title>Login</title>
    <link rel="preload" as="image" href="${resource(dir: 'images', file: 'fondo.webp')}">
    <style type="text/css">
        body {
            /* capa negra al 20 % sobre la imagen */
            background:
            linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.2)),
            url("${resource(dir: 'images', file: 'fondo.webp')}") no-repeat center center fixed;
            background-size: cover;
        }
        .hidden { display: none; }
        .logo-moto {
            width: 350px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.4);
        }
    </style>


</head>

<body>
<div style="text-align: center; margin-top: 22px;" class="well">

    <h1 class="titl" style="font-size: 26px; color: #fff; margin-bottom: 10px;">
        Sistema de Venta de Motos 🏍️
    </h1>

    <g:if test="${flash.message}">
        <div class="message" role="status" style="margin-bottom: 20px;">
            ${flash.message}
        </div>
    </g:if>

    <!-- Imagen de moto centrada -->
    <div style="display: flex; justify-content: center; align-items: center; margin: 20px 0;">
        <asset:image src="apli/moto.jpeg" class="logo-moto"/>
    </div>

    <div id="cargando" class="text-center hidden">
        <h1>Validando...</h1>
    </div>

    <!-- Botones -->
    <div style="width: 100%; text-align: center; margin-top: 30px; margin-bottom: 20px;">
        <a href="#" id="ingresar" class="btn btn-info" style="width: 140px; margin: 10px;">
            Ingresar <i class="fas fa-sign-in-alt"></i>
        </a>
        <a href="#" id="btnShowRegistro" class="btn btn-success" style="width: 140px; margin: 10px;">
            Registrarse <i class="fas fa-user-plus"></i>
        </a>
    </div>




    <!-- Créditos -->
    <div style="margin-top: 50px;">
        <p class="text-info" style="font-size: 10px; float: right;">
            Desarrollado por: <strong>Saul Tapia, Anthony Sosa</strong>
        </p>
        <p class="text-info" style="font-size: 10px; float: left;">
            Versión ${message(code: 'version', default: '1.1.0x')}
        </p>
    </div>
</div>

<!-- Modal Login (actualizado) -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">

      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <h4 class="modal-title" style="text-align: center">Ingresar al Sistema</h4>

      <div class="modal-body">
        <g:form name="frmLogin" action="validar" style="padding: 10px">
          <!-- Usuario -->
          <div class="row">
            <div class="col-md-5" style="text-align: right">
              <label for="login">Usuario</label>
            </div>
            <div class="col-md-5 controls">
              <input name="login" id="login" type="text" class="form-control required" placeholder="Usuario" required autofocus>
            </div>
          </div>
          <!-- Contraseña -->
          <div class="row" style="margin-top: 10px">
            <div class="col-md-5" style="text-align: right">
              <label for="pass">Contraseña</label>
            </div>
            <div class="col-md-5 controls">
              <input name="pass" id="pass" type="password" class="form-control required" placeholder="Contraseña" required>
            </div>
          </div>
          <!-- Botón -->
          <div class="divBtn" style="width: 100%; margin-top: 20px; text-align: center;">
            <button type="submit" class="btn btn-primary btn-lg" style="width: 140px;">
              <i class="fa fa-lock"></i> Ingresar
            </button>
          </div>
        </g:form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCerrarLogin">Cerrar</button>
      </div>

    </div>
  </div>
</div>



<!-- Modal Registro -->
<div id="modalRegistro" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <h4 class="modal-title" style="text-align: center">Registro de Usuario</h4>

            <div class="modal-body">
                <g:form controller="registro" action="guardar" name="frmRegistro" style="padding: 10px">
                    <div class="row">
                        <div class="col-md-5" style="text-align: right">
                            <label for="cedula">Cédula</label>
                        </div>
                        <div class="col-md-5 controls">
                            <input name="cedula" id="cedula" type="text" class="form-control required" required>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-5" style="text-align: right">
                            <label for="nombre">Nombre</label>
                        </div>
                        <div class="col-md-5 controls">
                            <input name="nombre" id="nombre" type="text" class="form-control required" required>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-5" style="text-align: right">
                            <label for="apellido">Apellido</label>
                        </div>
                        <div class="col-md-5 controls">
                            <input name="apellido" id="apellido" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-5" style="text-align: right">
                            <label for="mail">Correo</label>
                        </div>
                        <div class="col-md-5 controls">
                            <input name="mail" id="mail" type="email" class="form-control required" required>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-5" style="text-align: right">
                            <label for="login">Login</label>
                        </div>
                        <div class="col-md-5 controls">
                            <input name="login" id="loginReg" type="text" class="form-control required" required>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-5" style="text-align: right">
                            <label for="password">Contraseña</label>
                        </div>
                        <div class="col-md-5 controls">
                            <input name="password" id="passwordReg" type="password" class="form-control required" required>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-5" style="text-align: right">
                            <label for="telefono">Teléfono</label>
                        </div>
                        <div class="col-md-5 controls">
                            <input name="telefono" id="telefono" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-5" style="text-align: right">
                            <label for="direccion">Dirección</label>
                        </div>
                        <div class="col-md-5 controls">
                            <input name="direccion" id="direccion" type="text" class="form-control">
                        </div>
                    </div>

                    <div class="divBtn" style="width: 100%; margin-top: 20px; text-align: center;">
                        <button type="submit" class="btn btn-success btn-lg" style="width: 140px;">
                            <i class="fa fa-user-plus"></i> Registrarse
                        </button>
                    </div>
                </g:form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCerrarRegistro">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<!-- Script JS -->
<script type="text/javascript">
    var $frm = $("#frmLogin");
    var recargar = true;

    function doLogin() {
        var usuario = $("#login").val();
        if (usuario) {
            $("#cargando").removeClass('hidden');
            $(".btn-login").replaceWith($("#cargando"));
            $("#frmLogin").submit();
        }
    }

    $(function () {
        $("#ingresar").click(function () {
            $('#myModal').modal('show');
            setTimeout(function () {
                $("#login").focus();
            }, 500);
        });

        $("#btnShowRegistro").click(function () {
            $('#modalRegistro').modal('show');
        });

        $('#btnCerrar').click(function () {
            $('#myModal').modal('hide');
        });

        $('#btnCerrarRegistro').click(function () {
            $('#modalRegistro').modal('hide');
        });

        $("#btn-login").click(function () {
            doLogin();
        });

        $("input").keyup(function (ev) {
            if (ev.keyCode == 13) {
                doLogin();
            }
        });
    });
</script>

</body>
</html>
