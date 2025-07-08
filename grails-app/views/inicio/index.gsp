<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="layout" content="main">
    <title>Pantalla de inicio</title>
    <link rel="preload" as="image" href="${resource(dir: 'images', file: 'fondo.webp')}">
    <style>
        body {
            background: url("${resource(dir: 'images', file: 'fondo.webp')}") no-repeat center center fixed;
            background-size: cover;
        }
        .center-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 80vh;
        }
        .btn-group {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
            margin-bottom: 30px;
        }
        h1 {
            color: #fff;
            text-shadow: 2px 2px 8px #000;
            margin-bottom: 40px;
        }
    </style>
</head>
<body>
    <div class="center-content">
        <h1>Gestión del Sistema de Motos</h1>
        <g:if test="${session?.perfil?.codigo == 'ADM'}">
            <div class="btn-group">
                <a href="${createLink(controller: 'persona', action: 'list')}" type="button" class="btn btn-warning">Persona</a>
                <a href="${createLink(controller: 'articulo', action: 'list')}" type="button" class="btn btn-primary">Artículo</a>
                <a href="${createLink(controller: 'tipoAccesorio', action: 'list')}" type="button" class="btn btn-success">Tipo de Accesorio</a>
                <a href="${createLink(controller: 'tipoPersona', action: 'list')}" type="button" class="btn btn-info">Tipo de Persona</a>
                <a href="${createLink(controller: 'perfil', action: 'list')}" type="button" class="btn btn-dark">Perfil</a>
                <a href="${createLink(controller: 'pedido', action: 'list')}" type="button" class="btn btn-secondary">Pedido</a>
                <a href="${createLink(controller: 'factura', action: 'list')}" type="button" class="btn btn-danger">Factura</a>
                <a href="${createLink(controller: 'sesion', action: 'list')}" type="button" class="btn btn-info">Sesión</a>
            </div>
        </g:if>
        <a href="${createLink(controller: 'login', action: 'logout')}" type="button" class="btn btn-secondary">Salir del Sistema</a>
    </div>
</body>
</html>