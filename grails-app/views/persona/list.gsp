<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Personas</title>

    <!-- ── Estilos propios ─────────────────────────────────────────────── -->
    <style>
        .nombre-completo { font-weight: 500; color: #2c3e50; }
        .btn-group-sm .btn { margin-right: 2px; }
        .btn-group-sm .btn:last-child { margin-right: 0; }
        #tablaPersonas td { vertical-align: middle; }
        .label { display: inline-block; padding: 4px 8px; font-size: 11px;
                 font-weight: bold; border-radius: 3px; }
        .label-success { background:#5cb85c; color:#fff; }
        .label-danger  { background:#d9534f; color:#fff; }
    </style>
</head>

<body>

<!-- ── Mensajes flash ──────────────────────────────────────────────────── -->
<g:if test="${flash.message}">
    <div class="alert alert-info" role="status">${flash.message}</div>
</g:if>

<!-- ── Barra de acciones ──────────────────────────────────────────────── -->
<div class="btn-toolbar toolbar mb-3">
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

    <!-- Botón exportar Excel -->
    <div class="btn-group">
        <g:link controller="persona" action="reporteExcel" class="btn btn-success">
            <i class="fa fa-file-excel"></i> Exportar a Excel
        </g:link>
    </div>
</div>

<!-- ── Alert de guardado ──────────────────────────────────────────────── -->
<div class="col-md-12 alert alert-warning alert-dismissible fade hidden" role="alert">
    <strong>Se han guardado los datos correctamente.</strong>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<!-- ── Buscador ────────────────────────────────────────────────────────── -->
<div class="row mb-3">
    <div class="col-md-6">
        <div class="input-group">
            <input type="text" class="form-control" id="buscador"
                   placeholder="Buscar por nombre, apellido, login o email..."/>
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" id="btnBuscar">
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

<!-- ── Tabla ───────────────────────────────────────────────────────────── -->
<table class="table table-condensed table-bordered table-striped table-hover" id="tablaPersonas">
    <thead>
        <tr>
            <th>Login</th>
            <th>Nombre Completo</th>
            <th>Mail</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <!-- contenido dinámico vía AJAX -->
    </tbody>
</table>

<!-- ── Scripts ─────────────────────────────────────────────────────────── -->
<script type="text/javascript">
/* global $ bootbox */

// DateTimePicker (si se usa en el modal)
$('#fecha').datetimepicker({
    locale : 'es',
    format : 'DD-MM-YYYY',
    sideBySide : true
});

/* ---------- CRUD helpers ---------- */
function submitForm () {
    const $form = $('#frmPersona');
    $.post($form.attr('action'), $form.serialize(), function (msg) {
        if (msg === 'ok') {
            $('.alert').removeClass('hidden').addClass('show').alert();
            setTimeout(() => location.reload(true), 800);
        } else {
            log('Error al guardar la persona', 'error');
        }
    });
}

function deleteRow (itemId) {
    bootbox.dialog({
        title   : 'Alerta',
        message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i>"+
                  "<p>¿Está seguro que desea eliminar la persona seleccionada? "+
                  "Esta acción no se puede deshacer.</p>",
        closeButton : false,
        buttons : {
            cancelar : {
                label : 'Cancelar',
                className : 'btn-primary'
            },
            eliminar : {
                label : "<i class='fa fa-trash'></i> Eliminar",
                className : 'btn-danger',
                callback () {
                    $.post('${createLink(controller:"persona",action:"delete_ajax")}',
                           {id: itemId}, function (msg) {
                        if (msg === 'ok') setTimeout(() => location.reload(), 300);
                        else log('Error al borrar la persona', 'error');
                    });
                }
            }
        }
    });
}

function createEditRow (id) {
    const title = id ? 'Editar' : 'Crear';
    $.post("${createLink(controller:'persona', action:'form_ajax')}", {id: id}, function (html) {
        const dlg = bootbox.dialog({
            title : `${title} Persona`,
            closeButton : false,
            message : html,
            class : 'modal-lg',
            buttons : {
                cancelar : {
                    label     : 'Cancelar',
                    className : 'btn-primary'
                },
                guardar : {
                    id        : 'btnSave',
                    label     : "<i class='fa fa-save'></i> Guardar",
                    className : 'btn-success',
                    callback  : submitForm
                }
            }
        });
        setTimeout(() => dlg.find('.form-control').first().focus(), 400);
    });
}

/* ---------- Tabla y buscador ---------- */
function filtrarTabla () {
    const filtro = $('#buscador').val();
    $.post("${createLink(controller:'persona', action:'buscar_ajax')}", {filtro: filtro}, function (html) {
        $('#tablaPersonas tbody').html(html);
    }).fail(function (xhr) {
        console.error(xhr.responseText);
        $('#resultados').text('Error al buscar');
        $('#tablaPersonas tbody').html(
          '<tr class="danger"><td colspan="5" class="text-center">'+
          '<i class="fa fa-exclamation-triangle"></i> Error al cargar datos</td></tr>');
    });
}

$(function () {
    // Cargar inicial
    filtrarTabla();

    // Eventos
    $('#btnBuscar').click(filtrarTabla);
    $('#buscador').keypress(e => { if (e.which === 13) filtrarTabla(); });

    $('.btnCrear').click(() => { createEditRow(); return false; });

    // Delegación a botones dinámicos
    $(document).on('click', '.btn-edit',   e => createEditRow($(e.currentTarget).data('id')));
    $(document).on('click', '.btn-borrar', e => deleteRow($(e.currentTarget).data('id')));
    $(document).on('click', '.btn-show',   function () {
        const id = $(this).data('id');
        $.post("${createLink(controller:'persona', action:'show_ajax')}", {id: id}, function (html) {
            bootbox.dialog({
                title : 'Ver Persona',
                closeButton : false,
                message : html,
                buttons : { aceptar : { label : 'Aceptar', className : 'btn-primary' } }
            });
        });
    });
});
</script>

<!-- ── Modal placeholder (contenido se carga por AJAX) ─────────────────── -->
<div class="modal fade" id="personaModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg"><div class="modal-content"></div></div>
</div>

</body>
</html>
