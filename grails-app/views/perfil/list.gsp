<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Perfiles</title>
    <style>
        .nombre-perfil {
            font-weight: 500;
            color: #2c3e50;
        }
        .btn-group-sm .btn {
            margin-right: 2px;
        }
        .btn-group-sm .btn:last-child {
            margin-right: 0;
        }
        #tablaPerfiles td {
            vertical-align: middle;
        }
    </style>
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
    <div class="btn-group">
        <a href="#" class="btn btn-primary btnCrear">
            <i class="fa fa-clipboard-list"></i> Nuevo Perfil
        </a>
    </div>
</div>

<div class="col-md-12 alert alert-warning alert-dismissible fade hidden" role="alert">
    <strong>Se han guardado los datos correctamente.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
</div>

<div class="row" style="margin-bottom: 15px;">
    <div class="col-md-6">
        <div class="input-group">
            <input type="text" class="form-control" id="buscador" placeholder="Buscar por nombre de perfil...">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="button" id="btnBuscar">
                    <i class="fa fa-search"></i> Buscar
                </button>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <small class="text-muted">
            <span id="resultados">Cargando...</span>
        </small>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped table-hover" id="tablaPerfiles">
    <thead>
        <tr>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Código</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <!-- Los datos se cargarán via AJAX -->
    </tbody>
</table>

<script type="text/javascript">
    function submitForm() {
        var $form = $("#frmPerfil");
        $.ajax({
            type: "POST",
            url: $form.attr("action"),
            data: $form.serialize(),
            success: function (msg) {
                if (msg == 'ok') {
                    $('.alert').removeClass("hidden")
                    $('.alert').addClass("show")
                    $('.alert').alert()
                    setTimeout(function () {
                        location.reload(true);
                    }, 1000);
                } else {
                    log("Error al guardar el perfil", "error")
                }
            }
        });
    }

    function deleteRow(itemId) {
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
            "¿Está seguro que desea eliminar el perfil seleccionado? Esta acción no se puede deshacer.</p>",
            closeButton: false,
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {}
                },
                eliminar: {
                    label: "<i class='fa fa-trash'></i> Eliminar",
                    className: "btn-danger",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(controller: 'perfil', action:'delete_ajax')}',
                            data: {id: itemId},
                            success: function (msg) {
                                if (msg == 'ok') {
                                    setTimeout(function () {
                                        location.reload();
                                    }, 300);
                                } else if (msg == 'enUso') {
                                    bootbox.alert("No se puede eliminar el perfil porque está asignado a una o más personas.");
                                } else {
                                    log("Error al borrar el perfil", "error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id: id} : {};
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'perfil', action:'form_ajax')}",
            data: data,
            success: function (msg) {
                var b = bootbox.dialog({
                    title: title + " Perfil",
                    closeButton: false,
                    message: msg,
                    class: "modal-lg",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {}
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitForm();
                            }
                        }
                    }
                });
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            }
        });
    }

    function filtrarTabla() {
        var filtro = $("#buscador").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'perfil', action:'buscar_ajax')}",
            data: {filtro: filtro},
            success: function (html) {
                $("#tablaPerfiles tbody").html(html);
            },
            error: function(xhr, status, error) {
                $("#resultados").text("Error al buscar");
                $("#tablaPerfiles tbody").html('<tr class="danger"><td colspan="4" class="text-center"><i class="fa fa-exclamation-triangle"></i> Error al cargar datos</td></tr>');
            }
        });
    }

    $(function () {
        filtrarTabla();

        $("#btnBuscar").click(function() {
            filtrarTabla();
        });

        $("#buscador").keypress(function(event) {
            if (event.which == 13) {
                filtrarTabla();
            }
        });

        $(".btnCrear").click(function () {
            createEditRow();
            return false;
        });

        $(document).on("click", ".btn-edit", function () {
            var id = $(this).data("id");
            createEditRow(id);
        });

        $(document).on("click", ".btn-borrar", function () {
            var id = $(this).data("id");
            deleteRow(id);
        });

        $(document).on("click", ".btn-show", function () {
            var id = $(this).data("id");
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'perfil', action:'show_ajax')}",
                data: {id: id},
                success: function (msg) {
                    var b = bootbox.dialog({
                        title: "Ver Perfil",
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
