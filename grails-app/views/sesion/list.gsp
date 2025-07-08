<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Sesiones</title>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="inicio" action="index" class="btn btn-secondary">
            <i class="fa fa-arrow-left"></i> Regresar
        </g:link>
    </div>
</div>

<div class="row" style="margin-bottom: 15px;">
    <form id="formBusquedaSesion" class="form-inline" style="width: 100%;">
        <label for="perfilFiltro">Perfil:</label>
        <select name="perfilId" id="perfilFiltro" class="form-control" style="margin: 0 10px 0 5px;">
            <option value="">Todos</option>
            <g:each in="${perfiles}" var="perfil">
                <option value="${perfil.id}">${perfil.nombre}</option>
            </g:each>
        </select>
        <button type="button" id="btnBuscarSesion" class="btn btn-primary btn-sm">Buscar</button>
        <button type="button" id="btnLimpiarSesion" class="btn btn-default btn-sm">Limpiar</button>
    </form>
</div>

<table class="table table-condensed table-bordered table-striped table-hover" id="tablaSesiones">
    <thead>
        <tr>
            <th>ID</th>
            <th>Usuario</th>
            <th>Perfil</th>
            <th>Inicio</th>
            <th>Fin</th>
        </tr>
    </thead>
    <tbody>
        <!-- Los datos se cargarán via AJAX -->
    </tbody>
</table>

<script type="text/javascript">
    function filtrarSesiones() {
        var perfilId = $("#perfilFiltro").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'sesion', action:'buscar_ajax')}",
            data: {
                perfilId: perfilId
            },
            success: function(data) {
                $("#tablaSesiones tbody").html(data);
            }
        });
    }

    $(document).ready(function() {
        filtrarSesiones();

        $("#btnBuscarSesion").click(function() {
            filtrarSesiones();
        });

        $("#btnLimpiarSesion").click(function() {
            $("#formBusquedaSesion")[0].reset();
            filtrarSesiones();
        });
    });
</script>
</body>
</html>