<%@ page contentType="text/html;charset=UTF-8" %>

<style>
.modal-contenido .form-group {
    margin-bottom: 15px;
    border-bottom: 1px solid #eee;
    padding-bottom: 10px;
}
.modal-contenido .control-label {
    font-weight: bold;
    color: #2c3e50;
    text-align: left;
    margin-bottom: 5px;
}
.modal-contenido .form-control-static {
    padding: 5px 0;
    margin-bottom: 0;
    color: #555;
}
</style>

<g:if test="${!personaInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró la persona solicitada
    </div>
</g:if>
<g:else>
    <div class="modal-contenido">
        <div class="form-horizontal">
            
            <!-- FILA 1: Nombre / Apellido / Cédula -->
            <div class="row">
                <div class="form-group col-md-4">
                    <label class="control-label"><strong>Nombre:</strong></label>
                    <p class="form-control-static">${personaInstance?.nombre ?: 'N/A'}</p>
                </div>
                <div class="form-group col-md-4">
                    <label class="control-label"><strong>Apellido:</strong></label>
                    <p class="form-control-static">${personaInstance?.apellido ?: 'N/A'}</p>
                </div>
                <div class="form-group col-md-4">
                    <label class="control-label"><strong>Cédula:</strong></label>
                    <p class="form-control-static">${personaInstance?.cedula ?: 'N/A'}</p>
                </div>
            </div>

            <!-- FILA 2: Sexo / E-mail / Teléfono -->
            <div class="row">
                <div class="form-group col-md-4">
                    <label class="control-label"><strong>Sexo:</strong></label>
                    <p class="form-control-static">
                        ${personaInstance?.sexo == 'M' ? 'Masculino' : 'Femenino'}
                    </p>
                </div>
                <div class="form-group col-md-4">
                    <label class="control-label"><strong>E-mail:</strong></label>
                    <p class="form-control-static">${personaInstance?.mail ?: 'N/A'}</p>
                </div>
                <div class="form-group col-md-4">
                    <label class="control-label"><strong>Teléfono:</strong></label>
                    <p class="form-control-static">${personaInstance?.telefono ?: 'N/A'}</p>
                </div>
            </div>

            <!-- FILA 3: Dirección / Usuario / Estado -->
            <div class="row">
                <div class="form-group col-md-4">
                    <label class="control-label"><strong>Dirección:</strong></label>
                    <p class="form-control-static">${personaInstance?.direccion ?: 'N/A'}</p>
                </div>
                <div class="form-group col-md-4">
                    <label class="control-label"><strong>Usuario:</strong></label>
                    <p class="form-control-static">${personaInstance?.login ?: 'N/A'}</p>
                </div>
                <div class="form-group col-md-4">
                    <label class="control-label"><strong>Estado:</strong></label>
                    <p class="form-control-static">
                        <span class="label ${personaInstance?.activo ? 'label-success' : 'label-danger'}">
                            ${personaInstance?.activo ? 'Activo' : 'Inactivo'}
                        </span>
                    </p>
                </div>
            </div>

        </div>
    </div>
</g:else>
