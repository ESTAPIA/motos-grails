<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Pedidos</title>
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
    <form id="formFiltroFechas" class="form-inline" style="width: 100%;">
        <label for="fechaInicio">Desde:</label>
        <input type="date" name="fechaInicio" id="fechaInicio" class="form-control" value="${params.fechaInicio ?: ''}" style="margin: 0 10px 0 5px;"/>
        <label for="fechaFin">Hasta:</label>
        <input type="date" name="fechaFin" id="fechaFin" class="form-control" value="${params.fechaFin ?: ''}" style="margin: 0 10px 0 5px;"/>
        <button type="button" id="btnFiltrar" class="btn btn-primary btn-sm">Filtrar</button>
        <button type="button" id="btnLimpiar" class="btn btn-default btn-sm">Limpiar</button>
    </form>
</div>

<table class="table table-condensed table-bordered table-striped table-hover" id="tablaPedidos">
    <thead>
        <tr>
            <th>ID</th>
            <th>Cliente</th>
            <th>Fecha</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <!-- Los datos se cargarán via AJAX -->
    </tbody>
</table>

<script type="text/javascript">
    function filtrarTabla() {
        var fechaInicio = $("#fechaInicio").val();
        var fechaFin = $("#fechaFin").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'pedido', action:'buscar_ajax')}",
            data: {fechaInicio: fechaInicio, fechaFin: fechaFin},
            success: function (html) {
                $("#tablaPedidos tbody").html(html);
            },
            error: function(xhr, status, error) {
                $("#tablaPedidos tbody").html('<tr class="danger"><td colspan="5" class="text-center"><i class="fa fa-exclamation-triangle"></i> Error al cargar datos</td></tr>');
            }
        });
    }

    $(function () {
        filtrarTabla();

        $("#btnFiltrar").click(function() {
            filtrarTabla();
        });

        $("#btnLimpiar").click(function() {
            $("#fechaInicio").val('');
            $("#fechaFin").val('');
            filtrarTabla();
        });

        $(document).on("click", ".btn-show", function () {
            var id = $(this).data("id");
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'pedido', action:'show_ajax')}",
                data: {id: id},
                success: function (msg) {
                    var b = bootbox.dialog({
                        title: "Ver Pedido",
                        closeButton: false,
                        message: msg,
                        buttons: {
                            aceptar: {
                                label: "Aceptar",
                                className: "btn-primary",
                                callback: function () {}
                            }
                        }
                    });
                    setTimeout(function () {
                        b.find(".form-control").first().focus()
                    }, 500);
                }
            });
        });
    });
</script>
</body>
</html>
