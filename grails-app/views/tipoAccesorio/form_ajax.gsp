<g:if test="${!tipoAccesorioInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró el tipo de accesorio solicitado
    </div>
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmTipoAccesorio"
                controller="tipoAccesorio" action="save_ajax"
                method="POST" role="form">

            <g:hiddenField name="id" value="${tipoAccesorioInstance?.id}" />

            <!-- Tipo de Accesorio -->
            <div class="form-group row">
                <label for="tipoDeAccesorio" class="col-12 control-label">
                    Tipo de Accesorio
                </label>
                <div class="col-12">
                    <g:textField name="tipoDeAccesorio"
                                 class="form-control input-sm required"
                                 maxlength="50" minlength="3" required=""
                                 value="${tipoAccesorioInstance?.tipoDeAccesorio}" />
                </div>
            </div>

        </g:form>
    </div>
</g:else>
