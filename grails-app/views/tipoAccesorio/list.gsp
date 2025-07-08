<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Tipos de Accesorio</title>
    <style>
        .nombre-tipo {
            font-weight: 500;
            color: #2c3e50;
        }
        .btn-group-sm .btn {
            margin-right: 2px;
        }
        .btn-group-sm .btn:last-child {
            margin-right: 0;
        }
        #tablaTipoAccesorio td {
            vertical-align: middle;
        }
        .label {
            display: inline-block;
            padding: 4px 8px;
            font-size: 11px;
            font-weight: bold;
            border-radius: 3px;
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
            <i class="fa fa-clipboard-list"></i> Nuevo Tipo de Accesorio
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
            <input type="text" class="form-control" id="buscador" placeholder="Buscar por tipo de accesorio...">
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

<table class="table table-condensed table-bordered table-striped table-hover" id="tablaTipoAccesorio">
    <thead>
        <tr>
            <th>Tipo de Accesorio</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <!-- Los datos se cargarán via AJAX -->
    </tbody>
</table>

<script type="text/javascript">
    function submitForm() {
        var $form = $("#frmTipoAccesorio");
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
                    mostrarToast("Error al guardar el tipo de accesorio", "error");
                }
            },
            error: function(xhr, status, error) {
                mostrarToast("Error al procesar la solicitud", "error");
            }
        });
    }

    function deleteRow(itemId) {
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
            "¿Está seguro que desea eliminar el tipo de accesorio seleccionado? Esta acción no se puede deshacer.</p>",
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
                            url: '${createLink(controller: 'tipoAccesorio', action:'delete_ajax')}',
                            data: {id: itemId},
                            success: function (msg) {
                                if (msg == 'ok') {
                                    // Mostrar mensaje de éxito
                                    mostrarToast("Tipo de accesorio eliminado correctamente", "success");
                                    setTimeout(function () {
                                        location.reload();
                                    }, 1000);
                                } else if (msg == 'referenced') {
                                    // Error de clave foránea - tipo siendo usado por artículos
                                    mostrarToast("No se puede eliminar el tipo de accesorio porque está siendo usado por artículos", "error");
                                } else if (msg == 'not_found') {
                                    mostrarToast("No se encontró el tipo de accesorio a eliminar", "error");
                                } else {
                                    mostrarToast("Error al borrar el tipo de accesorio, esta asociado a un articulo", "error");
                                }
                            },
                            error: function(xhr, status, error) {
                                mostrarToast("Error al procesar la solicitud de eliminación", "error");
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
            url: "${createLink(controller: 'tipoAccesorio', action:'form_ajax')}",
            data: data,
            success: function (msg) {
                var b = bootbox.dialog({
                    title: title + " Tipo de Accesorio",
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
            url: "${createLink(controller: 'tipoAccesorio', action:'buscar_ajax')}",
            data: {filtro: filtro},
            success: function (html) {
                $("#tablaTipoAccesorio tbody").html(html);
            },
            error: function(xhr, status, error) {
                $("#resultados").text("Error al buscar");
                $("#tablaTipoAccesorio tbody").html('<tr class="danger"><td colspan="2" class="text-center"><i class="fa fa-exclamation-triangle"></i> Error al cargar datos</td></tr>');
            }
        });
    }

    // Función para mostrar mensajes toast
    function mostrarToast(mensaje, tipo) {
        var iconClass = tipo === 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle';
        var alertClass = tipo === 'success' ? 'alert-success' : 'alert-danger';
        
        var toast = $('<div class="alert ' + alertClass + ' alert-dismissible fade show toast-custom" role="alert" style="position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px;">' +
            '<i class="fa ' + iconClass + '"></i> ' + mensaje +
            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                '<span aria-hidden="true">&times;</span>' +
            '</button>' +
        '</div>');
        
        $('body').append(toast);
        
        // Auto-ocultar después de 5 segundos
        setTimeout(function() {
            toast.alert('close');
        }, 5000);
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
                url: "${createLink(controller: 'tipoAccesorio', action:'show_ajax')}",
                data: {id: id},
                success: function (msg) {
                    var b = bootbox.dialog({
                        title: "Ver Tipo de Accesorio",
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
