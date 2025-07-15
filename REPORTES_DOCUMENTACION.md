# Documentación de Reportes - Sistema de Gestión de Motos

## Introducción

Este documento describe los reportes y salidas disponibles en el sistema de gestión de motos, organizados por tipo de usuario. La aplicación gestiona artículos, pedidos, facturas y usuarios con diferentes niveles de acceso.

## Reportes Disponibles por Perfil de Usuario

### 1. Reportes para Administradores (ADM)

#### 1.1 Listado de Personas
**Descripción**: Reporte completo de usuarios registrados en el sistema
**Salida**: Archivo Excel (.xlsx)
**Contenido**:
- Cédula de identidad
- Login de usuario
- Nombre completo
- Apellido
- Correo electrónico
- Teléfono
- Dirección
- Sexo
- Fecha de inicio
- Fecha de finalización
- Tipo de persona
- Perfil asignado
- Estado (Activo/Inactivo)

#### 1.2 Listado de Facturas
**Descripción**: Consulta de facturas emitidas con filtros de fecha
**Salida**: Tabla en pantalla con opción de vista detallada
**Contenido**:
- ID de factura
- Número de pedido asociado
- Fecha de emisión
- Total facturado
- Acciones (Ver detalle, Eliminar)
**Filtros disponibles**:
- Fecha de inicio
- Fecha de fin

#### 1.3 Detalle de Factura Individual
**Descripción**: Vista completa de una factura específica
**Salida**: Modal en pantalla
**Contenido**:
- ID de factura
- Pedido asociado
- Fecha de emisión
- Total de la factura
- Detalle de artículos:
  - Nombre del artículo
  - Cantidad
  - Precio unitario
  - Subtotal por línea

#### 1.4 Listado de Pedidos
**Descripción**: Consulta de pedidos realizados con filtros de fecha
**Salida**: Tabla en pantalla con opción de vista detallada
**Contenido**:
- ID de pedido
- Cliente (nombre y apellido)
- Fecha del pedido
- Estado (PENDIENTE, CONFIRMADO, ENVIADO, ENTREGADO, CANCELADO)
- Acciones (Ver detalle)
**Filtros disponibles**:
- Fecha de inicio
- Fecha de fin

#### 1.5 Detalle de Pedido Individual
**Descripción**: Vista completa de un pedido específico
**Salida**: Modal en pantalla
**Contenido**:
- ID de pedido
- Cliente (nombre y apellido)
- Fecha del pedido
- Estado actual
- Detalle de artículos solicitados:
  - Nombre del artículo
  - Cantidad
  - Precio unitario
  - Subtotal por línea

#### 1.6 Listado de Artículos
**Descripción**: Inventario completo de productos disponibles
**Salida**: Tabla en pantalla con búsqueda
**Contenido**:
- Nombre del artículo
- Tipo de accesorio
- Precio base
- Stock disponible
- Acciones (Editar, Eliminar, Ver detalle)
**Filtros disponibles**:
- Búsqueda por nombre

#### 1.7 Listado de Perfiles
**Descripción**: Roles y permisos definidos en el sistema
**Salida**: Tabla en pantalla con búsqueda
**Contenido**:
- Nombre del perfil
- Descripción
- Código identificador
- Acciones (Editar, Eliminar, Ver detalle)
**Filtros disponibles**:
- Búsqueda por nombre

#### 1.8 Listado de Tipos de Persona
**Descripción**: Categorías de usuarios del sistema
**Salida**: Tabla en pantalla con búsqueda
**Contenido**:
- Descripción del tipo
- Acciones (Editar, Eliminar, Ver detalle)
**Filtros disponibles**:
- Búsqueda por descripción

#### 1.9 Listado de Tipos de Accesorio
**Descripción**: Categorías de productos disponibles
**Salida**: Tabla en pantalla con búsqueda
**Contenido**:
- Tipo de accesorio
- Acciones (Editar, Eliminar, Ver detalle)
**Filtros disponibles**:
- Búsqueda por tipo

#### 1.10 Historial de Sesiones
**Descripción**: Registro de accesos al sistema
**Salida**: Tabla en pantalla con filtros
**Contenido**:
- ID de sesión
- Usuario (nombre y apellido)
- Perfil utilizado
- Fecha y hora de inicio
- Fecha y hora de fin
**Filtros disponibles**:
- Filtro por perfil

### 2. Reportes para Clientes (CLI)

#### 2.1 Mis Facturas
**Descripción**: Historial personal de facturas del cliente
**Salida**: Tabla en pantalla con filtros de fecha
**Contenido**:
- ID de factura
- Fecha de emisión
- Total facturado
- Pedido asociado
- Enlace para ver detalle completo
**Filtros disponibles**:
- Fecha de inicio
- Fecha de fin

#### 2.2 Detalle de Mi Factura
**Descripción**: Vista completa de una factura personal
**Salida**: Página individual
**Contenido**:
- Número de factura
- Fecha de emisión
- Total de la compra
- Detalle de artículos:
  - Nombre del artículo
  - Cantidad
  - Precio unitario
  - Subtotal

#### 2.3 Mis Pedidos
**Descripción**: Historial personal de pedidos realizados
**Salida**: Tabla en pantalla con filtros
**Contenido**:
- ID de pedido
- Fecha de solicitud
- Estado actual
- Detalle de artículos solicitados:
  - Cantidad y nombre del artículo
  - Precio unitario
  - Stock actual disponible
  - Tipo de accesorio
- Acciones disponibles según estado:
  - Confirmar pedido (si está PENDIENTE)
  - Ver factura (si está CONFIRMADO)
**Filtros disponibles**:
- Estado del pedido (Todos, PENDIENTE, CONFIRMADO)

#### 2.4 Catálogo de Artículos para Pedido
**Descripción**: Vista de productos disponibles para realizar compras
**Salida**: Tabla filtrable para selección
**Contenido**:
- Nombre del artículo
- Precio base
- Stock disponible
- Tipo de accesorio
- Campo de cantidad para pedido
**Filtros disponibles**:
- Tipo de accesorio
- Búsqueda por nombre

## Características Técnicas de los Reportes

### Formato de Exportación Disponible
- **Excel (.xlsx)**: Únicamente para el reporte de personas (administradores)

### Funcionalidades de Filtrado
- **Búsqueda por texto**: En listados de artículos, perfiles, tipos
- **Filtros por fecha**: En facturas y pedidos
- **Filtros por estado**: En pedidos
- **Filtros por categoría**: En sesiones y catálogos

### Visualización de Datos
- **Tablas dinámicas**: Carga por AJAX
- **Modales informativos**: Para detalles de registros
- **Contadores en tiempo real**: Número de resultados mostrados
- **Paginación automática**: Para grandes volúmenes de datos

### Estados de Información
- **Pedidos**: PENDIENTE, CONFIRMADO, ENVIADO, ENTREGADO, CANCELADO
- **Usuarios**: Activo/Inactivo
- **Stock**: Cantidad numérica disponible
- **Sesiones**: Con fecha de inicio y fin (si aplica)

## Acceso y Seguridad

### Control por Perfil
- **Administradores (ADM)**: Acceso completo a todos los reportes del sistema
- **Clientes (CLI)**: Acceso únicamente a sus datos personales y catálogo de productos

### Restricciones de Datos
- Los clientes solo ven sus propias facturas y pedidos
- Los administradores tienen visibilidad completa del sistema
- Cada usuario solo puede acceder a reportes según su perfil asignado
