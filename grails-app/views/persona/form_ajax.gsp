<%@ page import="geos.Perfil; geos.Persona" %>

<style type="text/css">
option[selected] { background-color: yellow; }
</style>

<g:if test="${!personaInstance}">
    <elm:notFound elem="Persona" genero="o"/>
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmPersona"
                controller="persona" action="save_ajax"
                method="POST" role="form">

            <g:hiddenField name="id" value="${personaInstance?.id}" />

            <!-- FILA 1: Nombre, Apellido, Cédula -->
            <div class="row">
                <div class="form-group col-md-4">
                    <label for="nombre" class="form-label">Nombre</label>
                    <g:textField name="nombre" id="nombre"
                                 class="form-control input-sm required"
                                 maxlength="40" minlength="3" required=""
                                 value="${personaInstance?.nombre}" />
                </div>
                <div class="form-group col-md-4">
                    <label for="apellido" class="form-label">Apellido</label>
                    <g:textField name="apellido" id="apellido"
                                 class="form-control input-sm required"
                                 maxlength="40" minlength="3" required=""
                                 value="${personaInstance?.apellido}" />
                </div>
                <div class="form-group col-md-4">
                    <label for="cedula" class="form-label">Cédula</label>
                    <g:textField name="cedula" id="cedula"
                                 class="form-control input-sm required digits"
                                 maxlength="10" minlength="10"
                                 value="${personaInstance?.cedula}" />
                </div>
            </div>

            <!-- FILA 2: Sexo, Perfil, Teléfono -->
            <div class="row">
                <div class="form-group col-md-4">
                    <label for="sexo" class="form-label">Sexo</label>
                    <g:select name="sexo" id="sexo"
                              from="${['F':'Femenino','M':'Masculino']}"
                              optionKey="key" optionValue="value"
                              class="form-control input-sm required"
                              required="" value="${personaInstance?.sexo}" />
                </div>
                <div class="form-group col-md-4">
                    <label for="perfil" class="form-label">Perfil</label>
                    <g:select name="perfil" id="perfil"
                              from="${perfiles}"
                              optionKey="id" optionValue="nombre"
                              class="form-control input-sm"
                              value="${personaInstance?.perfil?.id}" />
                </div>
                <div class="form-group col-md-4">
                    <label for="telefono" class="form-label">Teléfono</label>
                    <g:textField name="telefono" id="telefono"
                                 class="form-control input-sm digits"
                                 maxlength="31"
                                 value="${personaInstance?.telefono}" />
                </div>
            </div>

            <!-- FILA 3: Dirección, Tipo de Persona, Activo -->
            <div class="row">
                <div class="form-group col-md-4">
                    <label for="direccion" class="form-label">Dirección</label>
                    <g:textArea name="direccion" id="direccion"
                                class="form-control input-sm"
                                cols="30" rows="2" maxlength="255"
                                style="resize:none;"
                                value="${personaInstance?.direccion}" />
                </div>
                <div class="form-group col-md-4">
                    <label for="tipoPersona" class="form-label">Tipo de Persona</label>
                    <g:select name="tipoPersona" id="tipoPersona"
                              from="${tiposPersona}"
                              optionKey="id" optionValue="descripcion"
                              class="form-control input-sm required"
                              required=""
                              value="${personaInstance?.tipoPersona?.id}" />
                </div>
                <div class="form-group col-md-4">
                    <label for="activo" class="form-label">Activo</label>
                    <g:select name="activo" id="activo"
                              from="${[1:'Sí',0:'No']}"
                              optionKey="key" optionValue="value"
                              class="form-control input-sm required"
                              required=""
                              value="${personaInstance?.activo}" />
                </div>
            </div>

            <!-- FILA 4: Usuario, Password, E-mail -->
            <div class="row">
                <div class="form-group col-md-4">
                    <label for="login" class="form-label">Usuario</label>
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon"><i class="fa fa-user"></i></span>
                        <g:field type="login" name="login" id="login"
                                 class="form-control input-sm noEspacios required"
                                 maxlength="15" minlength="4"
                                 value="${personaInstance?.login ?: ''}" />
                    </div>
                </div>
                <div class="form-group col-md-4">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon"><i class="fa fa-key"></i></span>
                        <g:field type="password" name="password" id="password"
                                 class="form-control input-sm noEspacios required"
                                 maxlength="63"
                                 value="${personaInstance?.password ?: ''}" />
                    </div>
                </div>
                <div class="form-group col-md-4">
                    <label for="mail" class="form-label">E-mail</label>
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                        <g:field type="email" name="mail" id="mail"
                                 class="form-control input-sm required noEspacios unique"
                                 maxlength="63"
                                 value="${personaInstance?.mail ?: '@empresa.com'}" />
                    </div>
                </div>
            </div>

        </g:form>
    </div>
</g:else>
