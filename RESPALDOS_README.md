# Respaldos de Base de Datos - Sistema Tienda Motos

## Archivos de Respaldo Generados

### tiendamotos_backup.dump
- **Formato**: Custom (binario comprimido)
- **Contenido**: Estructura completa + datos
- **Tamaño**: 29,094 bytes
- **Uso**: Respaldo principal para restauración completa
- **Restauración**: 
  ```
  pg_restore -h 127.0.0.1 -p 5432 -U postgres -d tiendamotos_nueva tiendamotos_backup.dump
  ```

### tiendamotos_backup.sql
- **Formato**: SQL plano (texto)
- **Contenido**: Estructura completa + datos
- **Tamaño**: 29,019 bytes
- **Uso**: Respaldo compatible con cualquier herramienta SQL
- **Restauración**: 
  ```
  psql -h 127.0.0.1 -p 5432 -U postgres -d tiendamotos_nueva -f tiendamotos_backup.sql
  ```

### tiendamotos_estructura.sql
- **Formato**: SQL plano (texto)
- **Contenido**: Solo estructura (sin datos)
- **Tamaño**: 15,169 bytes
- **Uso**: Para crear base de datos vacía con la estructura
- **Restauración**: 
  ```
  psql -h 127.0.0.1 -p 5432 -U postgres -d tiendamotos_nueva -f tiendamotos_estructura.sql
  ```

## Información de la Base de Datos

- **Nombre**: tiendamotos
- **Motor**: PostgreSQL
- **Host**: 127.0.0.1
- **Puerto**: 5432
- **Usuario**: postgres

## Tablas Incluidas

- **artc**: Artículos/Productos
- **dtft**: Detalles de factura
- **dtpd**: Detalles de pedido
- **fact**: Facturas
- **pedd**: Pedidos
- **prfl**: Perfiles de usuario
- **prsn**: Personas/Usuarios
- **sesn**: Sesiones
- **tpac**: Tipos de accesorio
- **tppr**: Tipos de persona

## Fecha de Respaldo
7 de julio de 2025

## Comandos Utilizados

```bash
# Respaldo completo en formato custom
pg_dump -h 127.0.0.1 -p 5432 -U postgres -d tiendamotos --verbose --format=custom --file=tiendamotos_backup.dump

# Respaldo completo en formato SQL
pg_dump -h 127.0.0.1 -p 5432 -U postgres -d tiendamotos --verbose --format=plain --file=tiendamotos_backup.sql

# Solo estructura
pg_dump -h 127.0.0.1 -p 5432 -U postgres -d tiendamotos --schema-only --format=plain --file=tiendamotos_estructura.sql
```
