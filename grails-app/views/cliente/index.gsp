<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Área Cliente</title>
    <meta name="layout" content="main">
    <style>
        .fondo-oscuro {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            z-index: 0;
            background: 
                linear-gradient(rgba(0,0,0,0.45), rgba(0,0,0,0.45)),
                url('${resource(dir: "images", file: "fondo.webp")}') no-repeat center center fixed;
            background-size: cover;
        }
        body, html {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        .contenido-bienvenida, nav {
            position: relative;
            z-index: 1;
        }
    </style>
</head>
<body>
    <div class="fondo-oscuro"></div>
    <nav style="background: #f8f9fa; padding: 10px; border-bottom: 1px solid #ddd; display: flex; align-items: center; justify-content: space-between;">
        <span style="font-weight: bold;">Sistema de Venta Motos</span>
        <div style="display: flex; gap: 6px;">
            <a href="${createLink(controller: 'cliente', action: 'index')}" class="btn btn-secondary">Inicio</a>
            <a href="${createLink(controller: 'cliente', action: 'pedidos')}" class="btn btn-info">Mis Pedidos</a>
            <a href="${createLink(controller: 'cliente', action: 'facturas')}" class="btn btn-warning">Mis Facturas</a>
            <a href="${createLink(controller: 'cliente', action: 'nuevoPedido')}" class="btn btn-success">Comprar</a>
            <a href="${createLink(controller: 'cliente', action: 'logout')}" class="btn btn-danger">Cerrar sesión</a>
        </div>
    </nav>
    <div class="contenido-bienvenida" style="display: flex; justify-content: center; align-items: center; min-height: 60vh;">
        <div style="
            background: rgba(255,255,255,0.85);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.18);
            padding: 36px 48px;
            text-align: center;
            max-width: 400px;
            backdrop-filter: blur(4px);
            -webkit-backdrop-filter: blur(4px);
        ">
            <div style="font-size: 54px; color: #17a2b8; margin-bottom: 16px;">
                <i class="fa fa-user-circle"></i>
            </div>
            <h2 style="margin-bottom: 10px;">¡Bienvenido, ${usuario?.nombre} ${usuario?.apellido}!</h2>
            <p style="color: #555;">Nos alegra tenerte aquí.<br>Explora tus pedidos, facturas o realiza una nueva compra desde tu área de cliente.</p>
        </div>
    </div>
</body>
</html>
