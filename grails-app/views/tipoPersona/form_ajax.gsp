<g:if test="${!tipoPersonaInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró el tipo de persona solicitado
    </div>
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmTipoPersona" role="form" controller="tipoPersona"
                action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${tipoPersonaInstance?.id}"/>
            <div class="form-group row">
                <label for="descripcion" class="col-md-3 control-label">
                    Tipo de Persona
                </label>
                <div class="col-md-9">
                    <g:textField name="descripcion" maxlength="50" minlength="3"
                                 required="" class="form-control input-sm required"
                                 value="${tipoPersonaInstance?.descripcion}"/>
                </div>
            </div>
        </g:form>
    </div>
</g:else>
