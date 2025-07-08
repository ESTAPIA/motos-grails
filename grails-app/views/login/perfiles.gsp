<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="login">
    <title>Perfil</title>
    <style type="text/css">
        .hidden {
            visibility: hidden;
        }
        .container-center {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>

<body>

<div style="text-align: center; margin-top: 30px; height: ${(flash.message) ? '650' : '580'}px;" class="well">

    <!-- Mensaje si existe -->
    <g:if test="${flash.message}">
        <div class="message" role="status" style="margin-bottom: 20px;">${flash.message}</div>
    </g:if>

    <!-- Título e ícono -->
    <h2 style="color: #c00;">Seleccione su perfil de trabajo</h2>
    <div style="margin-bottom: 20px;">
        <i class="fa fa-users fa-4x text-success"></i>
    </div>

    <!-- Formulario de selección -->
    <div class="container-center" style="margin-top: 30px;">
        <g:form name="frmLogin" action="savePer" class="form-signin well" role="form" style="width: 300px;">
            <h3 class="text-center">Perfil</h3>
            <g:select name="prfl" class="form-control" from="${perfilesUsr}" optionKey="id" optionValue="nombre"/>
            <div class="divBtn" style="margin-top: 30px; text-align: center;">
                <a href="#" class="btn btn-primary btn-lg btn-block btn-login" id="btnPerfiles" style="width: 140px; margin: auto;">
                    <i class="fa fa-lock"></i> Entrar
                </a>
            </div>
        </g:form>
    </div>

    <!-- Cargando -->
    <div id="cargando" class="text-center hidden" style="margin-top: 30px;">
        <img src="${resource(dir: 'images', file: 'spinner32.gif')}" alt="Cargando..." width="32px" height="32px"/>
    </div>

</div>

<!-- Redirección automática si hay un solo perfil tipo 'CLI' -->
<g:if test="${perfilesUsr.size() == 1 && perfilesUsr[0].codigo == 'CLI'}">
    <%
        response.sendRedirect(createLink(controller: 'cliente', action: 'index'))
    %>
</g:if>

<!-- Script JS -->
<script type="text/javascript">
    function doLogin() {
        $("#cargando").removeClass('hidden');
        $("#btnPerfiles").replaceWith($("#cargando"));
        $("#frmLogin").submit();
    }

    $(function () {
        $("#btnPerfiles").click(function () {
            doLogin();
        });

        $("input").keyup(function (ev) {
            if (ev.keyCode === 13) {
                doLogin();
            }
        });
    });
</script>

</body>
</html>
