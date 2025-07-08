<g:if test="${!perfilInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró el perfil solicitado
    </div>
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmPerfil"
                controller="perfil" action="save_ajax"
                method="POST" role="form">

            <g:hiddenField name="id" value="${perfilInstance?.id}" />

            <!-- Nombre -->
            <div class="form-group row">
                <label for="nombre" class="col-12 control-label">Nombre</label>
                <div class="col-12">
                    <g:textField name="nombre"
                                 class="form-control input-sm required"
                                 maxlength="50" minlength="3" required=""
                                 value="${perfilInstance?.nombre}" />
                </div>
            </div>

            <!-- Descripción -->
            <div class="form-group row">
                <label for="descripcion" class="col-12 control-label">Descripción</label>
                <div class="col-12">
                    <g:textField name="descripcion"
                                 class="form-control input-sm"
                                 maxlength="255"
                                 value="${perfilInstance?.descripcion}" />
                </div>
            </div>

            <!-- Código -->
            <div class="form-group row">
                <label for="codigo" class="col-12 control-label">Código</label>
                <div class="col-12">
                    <g:textField name="codigo"
                                 class="form-control input-sm"
                                 maxlength="10"
                                 value="${perfilInstance?.codigo}" />
                </div>
            </div>

            <!-- Perfil Padre -->
            <div class="form-group row">
                <label for="padre" class="col-12 control-label">Perfil Padre</label>
                <div class="col-12">
                    <g:select name="padre"
                              from="${perfilesPadre}"
                              optionKey="id"
                              optionValue="nombre"
                              value="${perfilInstance?.padre?.id}"
                              class="form-control input-sm" />
                </div>
            </div>

            <!-- Observaciones -->
            <div class="form-group row">
                <label for="observaciones" class="col-12 control-label">Observaciones</label>
                <div class="col-12">
                    <g:textArea name="observaciones"
                                class="form-control input-sm"
                                maxlength="255"
                                style="resize:none;"
                                value="${perfilInstance?.observaciones}" />
                </div>
            </div>

        </g:form>
    </div>
</g:else>
