# 🗃️ Scripts DDL (Data Definition Language)

## Descripción

Este directorio contiene los **scripts de definición de datos** necesarios para crear la estructura completa de la base de datos. Los scripts DDL permiten crear, modificar y eliminar objetos de la base de datos como tablas, índices y restricciones.

---

## 📁 Archivos

- `tienda_online.sql` - Script principal para crear todas las tablas del sistema

---

## 🚀 Instrucciones de Ejecución

### Opción 1: Línea de Comandos (MySQL)

```bash
# Conectar a MySQL
mysql -u root -p

# Ejecutar el script
source DDL/tienda_online.sql

# O directamente desde terminal
mysql -u root -p < DDL/tienda_online.sql
```

### Opción 2: MySQL Workbench

1. Abrir MySQL Workbench
2. Conectar a tu servidor
3. **File → Open SQL Script**
4. Seleccionar `tienda_online.sql`
5. Ejecutar con el botón ⚡ (Execute)

### Opción 3: phpMyAdmin

1. Acceder a phpMyAdmin
2. Ir a la pestaña **SQL**
3. Copiar y pegar el contenido de `tienda_online.sql`
4. Clic en **Continuar**

---

## 📋 Contenido del Script

### 1. Creación de la Base de Datos

```sql
CREATE DATABASE IF NOT EXISTS tienda_online_db;
USE tienda_online_db;
```

### 2. Orden de Creación de Tablas

**Importante:** Las tablas deben crearse en este orden debido a las dependencias de claves foráneas:

1. `categorias` (sin dependencias)
2. `clientes` (sin dependencias)
3. `productos` (depende de categorias)
4. `pedidos` (depende de clientes)
5. `detalle_pedidos` (depende de pedidos y productos)
6. `metodos_pago` (depende de pedidos)

---

## 🔧 Características Implementadas

### Tipos de Datos Utilizados

| Tipo de Dato | Uso | Ejemplo |
|--------------|-----|---------|
| `INT` | Identificadores, cantidades | id_cliente, stock |
| `VARCHAR(n)` | Textos cortos | nombre, email |
| `TEXT` | Textos largos | descripcion |
| `DECIMAL(10,2)` | Valores monetarios | precio, total |
| `DATE` | Fechas | fecha_registro |
| `DATETIME` | Fecha y hora | fecha_pedido |

### Restricciones de Integridad

#### Primary Keys (PK)
- Cada tabla tiene su clave primaria
- Generadas automáticamente con `AUTO_INCREMENT`

#### Foreign Keys (FK)
```sql
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
```

#### NOT NULL
- Campos obligatorios que no pueden estar vacíos
- Ejemplo: nombre, email, precio

#### UNIQUE
- Garantiza valores únicos
- Ejemplo: email de clientes

#### DEFAULT
- Valores por defecto
- Ejemplo: `estado VARCHAR(20) DEFAULT 'Pendiente'`

---

## 📊 Diagrama de Dependencias

```
categorias (independiente)
    ↓
productos
    ↓
detalle_pedidos ← pedidos ← clientes (independiente)
    ↑                ↓
    └─────────→ metodos_pago
```

---

## 🛡️ Validaciones Implementadas

1. **Integridad Referencial:** No se pueden insertar registros con FKs inexistentes
2. **Valores Únicos:** Los emails no se pueden duplicar
3. **Valores Obligatorios:** Campos críticos no pueden ser NULL
4. **Valores por Defecto:** Estados y fechas se asignan automáticamente

---

## ⚠️ Consideraciones Importantes

### Eliminación en Cascada

Si se necesita eliminar registros relacionados automáticamente, se pueden modificar las FK:

```sql
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
```

### Re-ejecución del Script

El script incluye `IF NOT EXISTS` para evitar errores si la base de datos ya existe. Para reiniciar completamente:

```sql
DROP DATABASE IF EXISTS tienda_online_db;
```

---

## 🔄 Modificaciones Futuras

Si se necesita modificar la estructura después de crearla:

```sql
-- Agregar una columna
ALTER TABLE clientes ADD COLUMN fecha_nacimiento DATE;

-- Modificar una columna
ALTER TABLE productos MODIFY COLUMN descripcion VARCHAR(500);

-- Eliminar una columna
ALTER TABLE clientes DROP COLUMN telefono;

-- Agregar un índice
CREATE INDEX idx_email ON clientes(email);
```

---

## ✅ Verificación

Después de ejecutar el script, verificar que las tablas se crearon correctamente:

```sql
-- Ver todas las tablas
SHOW TABLES;

-- Ver estructura de una tabla
DESCRIBE clientes;

-- Ver las claves foráneas
SHOW CREATE TABLE productos;
```

---

## 🔄 Volver al inicio
[← Regresar al README principal](../README.md)

