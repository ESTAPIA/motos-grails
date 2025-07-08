<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Personas</title>
    <style>
        .nombre-completo {
            font-weight: 500;
            color: #2c3e50;
        }
        .btn-group-sm .btn {
            margin-right: 2px;
        }
        .btn-group-sm .btn:last-child {
            margin-right: 0;
        }
        #tablaPersonas td {
            vertical-align: middle;
        }
        .label {
            display: inline-block;
            padding: 4px 8px;
            font-size: 11px;
            font-weight: bold;
            border-radius: 3px;
        }
        .label-success {
            background-color: #5cb85c;
            color: white;
        }
        .label-danger {
            background-color: #d9534f;
            color: white;
        }
    </style>
</head>

<body>

<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="inicio" action="index" class="btn btn-secondary">
            <i class="fa fa-arrow-left"></i> Regresar
        </g:link>
    </div>

    <div class="btn-group">
        <a href="#" class="btn btn-primary btnCrear">
            <i class="fa fa-clipboard-list"></i> Nueva Persona
        </a>
    </div>
</div>

<div class="col-md-12 alert alert-warning alert-dismissible fade hidden" role="alert">
    <strong>Se han guardado los datos correctamente.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
</div>

<!-- Buscador -->
<div class="row" style="margin-bottom: 15px;">
    <div class="col-md-6">
        <div class="input-group">
            <input type="text" class="form-control" id="buscador" placeholder="Buscar por nombre, apellido, login o email...">
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

<table class="table table-condensed table-bordered table-striped table-hover" id="tablaPersonas">    <thead>
    <tr>
        <th>Login</th>
        <th>Nombre Completo</th>
        <th>Mail</th>
        <th>Estado</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
        <!-- Los datos se cargarán via AJAX -->
    </tbody>
</table>

<script type="text/javascript">
    var id = null;

    $('#fecha').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    });

    function submitForm() {
        var $form = $("#frmPersona");
        $.ajax({
            type: "POST",
            url: $form.attr("action"),
            data: $form.serialize(),
            success: function (msg) {
                if (msg == 'ok') {
//                    log("Persona guardada orrectamente", "success");

                    $('.alert').removeClass("hidden")
                    $('.alert').addClass("show")
                    $('.alert').alert()

                    setTimeout(function () {
                        location.reload(true);
                    }, 1000);
                } else {
                    log("Error al guardar la persona", "error")
                }
            }
        });
    }


    function deleteRow(itemId) {
        console.log("borra",itemId)
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
            "¿Está seguro que desea eliminar la persona seleccionada? Esta acción no se puede deshacer.</p>",
            closeButton: false,
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-trash'></i> Eliminar",
                    className: "btn-danger",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(controller: 'persona', action:'delete_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                if (msg == 'ok') {
                                    setTimeout(function () {
                                        location.reload();
                                    }, 300);
                                } else {
                                    log("Error al borrar la persona", "error")
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
            url: "${createLink(controller: 'persona', action:'form_ajax')}",
            data: data,
            success: function (msg) {
                var b = bootbox.dialog({
                    title: title + " Persona" ,
                    closeButton: false,
                    message: msg,
                    class: "modal-lg",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitForm();
                            } //callback
                        } //guardar
                    } //button
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //successJava
        });
        //location.reload()//ajax
    }

    //createEdit

    // Buscador con AJAX - versión con template HTML
    function filtrarTabla() {
        console.log("=== INICIO BUSCAR CON AJAX ===");
        
        var filtro = $("#buscador").val();
        console.log("🔍 Filtro aplicado:", filtro);
        
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'persona', action:'buscar_ajax')}",
            data: {filtro: filtro},            success: function (html) {
                console.log("✅ AJAX exitoso - HTML recibido");
                console.log("📊 HTML length:", html.length);
                
                // Limpiar y actualizar tabla con el HTML recibido
                $("#tablaPersonas tbody").html(html);
                
                console.log("🏁 Tabla actualizada correctamente");
            },
            error: function(xhr, status, error) {
                console.log("❌ ERROR EN AJAX:");
                console.log("Status:", status);
                console.log("Error:", error);                console.log("Response:", xhr.responseText);
                $("#resultados").text("Error al buscar");
                $("#tablaPersonas tbody").html('<tr class="danger"><td colspan="5" class="text-center"><i class="fa fa-exclamation-triangle"></i> Error al cargar datos</td></tr>');
            }
        });
        
        console.log("=== FIN BUSCAR CON AJAX ===\n");
    }

    $(function () {
        console.log("🚀 INICIALIZANDO PÁGINA DE PERSONAS CON AJAX");

        // Cargar datos iniciales
        filtrarTabla();

        // Evento del botón buscar y tecla Enter
        $("#btnBuscar").click(function() {
            console.log("🔘 BOTÓN BUSCAR PRESIONADO");
            filtrarTabla();
        });

        $("#buscador").keypress(function(event) {
            if (event.which == 13) { // Enter key
                console.log("⏎ ENTER PRESIONADO");
                filtrarTabla();
            }
        });

        console.log("✅ Event listeners del buscador configurados");

        $(".btnCrear").click(function () {
            createEditRow();
            return false;
        });

        // Usar event delegation para botones dinámicos
        $(document).on("click", ".btn-edit", function () {
            var id = $(this).data("id");
            console.log("✏️ Editar persona ID:", id);
            createEditRow(id);
        });

        $(document).on("click", ".btn-borrar", function () {
            var id = $(this).data("id");
            console.log("🗑️ Eliminar persona ID:", id);
            deleteRow(id);
        });

        $(document).on("click", ".btn-show", function () {
            var title = "Ver Persona";
            var id = $(this).data("id");
            console.log("👁️ Ver persona ID:", id);
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'persona', action:'show_ajax')}",
                data: {id: id},
                success: function (msg) {
                    var b = bootbox.dialog({
                        title: title,
                        closeButton: false,
                        message: msg,
                        buttons: {
                            aceptar: {
                                label: "Aceptar",
                                className: "btn-primary",
                                callback: function () {
                                }
                            }                        },
                    }); //dialog
                    setTimeout(function () {
                        b.find(".form-control").first().focus()
                    }, 500);
                } //successJava
            });
            //location.reload()//ajax
        });
    });
</script>

<!-- Modal para mostrar detalles de persona -->
<div class="modal fade" id="personaModal" tabindex="-1" role="dialog" aria-labelledby="personaModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="personaModalLabel">Detalles de la Persona</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Aquí se cargará el contenido AJAX -->
                <div id="resultados"></div>
            </div>
        </div>
    </div>

</body>
</html>
