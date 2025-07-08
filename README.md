# Sistema de Gestión de Tienda de Motos - Guido Anthony

## Descripción

Sistema web desarrollado con Grails Framework para la gestión integral de una tienda de accesorios y repuestos para motocicletas.

## Funcionalidades

### Autenticación
- Login seguro con encriptación MD5
- **Administrador**: Acceso completo al sistema
- **Cliente**: Funciones de compra únicamente

### Gestión de Usuarios
- CRUD de usuarios con datos personales completos
- Búsqueda y filtrado con AJAX

### Gestión de Productos
- Administración de catálogo: nombre, precio, stock, imagen
- Clasificación por tipos de accesorios
- Control de inventario

### Procesamiento de Pedidos
- Carrito de compras con validación de stock
- Estados: PENDIENTE → CONFIRMADO → ENVIADO → ENTREGADO
- Seguimiento de pedidos

### Facturación
- Generación automática al confirmar pedidos
- Historial por cliente

## Tecnologías

- **Backend**: Grails Framework, PostgreSQL
- **Frontend**: GSP, Bootstrap, jQuery, AJAX
- **Arquitectura**: MVC con diseño responsivo

## Base de Datos

PostgreSQL con entidades principales:
- **prsn**: Usuarios
- **artc**: Productos  
- **pedd**: Pedidos
- **fact**: Facturas


Sistema completo para gestión de tienda de accesorios para motocicletas con funcionalidades de administración e-commerce.
