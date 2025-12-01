# 📊 Modelo Entidad-Relación

## Descripción

Este directorio contiene el diseño conceptual de la base de datos mediante el **diagrama entidad-relación (ER)**. El modelo representa gráficamente las entidades, sus atributos y las relaciones entre ellas.

---

## 📁 Archivos

- `diagrama_modelo.png` - Diagrama ER visual del sistema

---

## 🎯 Entidades del Sistema

### 1. **CLIENTES**
Almacena información de los usuarios registrados en la tienda.

**Atributos:**
- `id_cliente` (PK) - Identificador único
- `nombre` - Nombre completo del cliente
- `email` - Correo electrónico (único)
- `direccion` - Dirección de envío
- `telefono` - Número de contacto
- `fecha_registro` - Fecha de alta en el sistema

### 2. **CATEGORIAS**
Clasificación de productos en grupos temáticos.

**Atributos:**
- `id_categoria` (PK) - Identificador único
- `nombre` - Nombre de la categoría
- `descripcion` - Descripción detallada

### 3. **PRODUCTOS**
Catálogo completo de artículos disponibles.

**Atributos:**
- `id_producto` (PK) - Identificador único
- `nombre` - Nombre del producto
- `descripcion` - Descripción detallada
- `precio` - Precio unitario
- `stock` - Cantidad disponible
- `id_categoria` (FK) - Referencia a categoría

### 4. **PEDIDOS**
Órdenes de compra realizadas por los clientes.

**Atributos:**
- `id_pedido` (PK) - Identificador único
- `id_cliente` (FK) - Cliente que realiza el pedido
- `fecha_pedido` - Fecha y hora del pedido
- `total` - Monto total del pedido
- `estado` - Estado actual (Pendiente, Completado, Enviado, Cancelado)

### 5. **DETALLE_PEDIDOS**
Tabla intermedia que relaciona pedidos con productos (líneas del pedido).

**Atributos:**
- `id_detalle` (PK) - Identificador único
- `id_pedido` (FK) - Pedido al que pertenece
- `id_producto` (FK) - Producto solicitado
- `cantidad` - Unidades compradas
- `precio_unitario` - Precio al momento de la compra

### 6. **METODOS_PAGO**
Información sobre el pago de cada pedido.

**Atributos:**
- `id_metodo` (PK) - Identificador único
- `id_pedido` (FK) - Pedido asociado
- `tipo_pago` - Método utilizado (Tarjeta, PayPal, Transferencia)
- `monto` - Cantidad pagada
- `fecha_pago` - Fecha de la transacción

---

## 🔗 Relaciones

### Relación 1:N (Uno a Muchos)

| Entidad Padre | Relación | Entidad Hija | Descripción |
|--------------|----------|--------------|-------------|
| CLIENTES | 1:N | PEDIDOS | Un cliente puede realizar múltiples pedidos |
| CATEGORIAS | 1:N | PRODUCTOS | Una categoría puede contener varios productos |
| PEDIDOS | 1:N | DETALLE_PEDIDOS | Un pedido puede tener múltiples productos |
| PRODUCTOS | 1:N | DETALLE_PEDIDOS | Un producto puede estar en varios pedidos |

### Relación 1:1 (Uno a Uno)

| Entidad 1 | Relación | Entidad 2 | Descripción |
|-----------|----------|-----------|-------------|
| PEDIDOS | 1:1 | METODOS_PAGO | Cada pedido tiene un único método de pago |

---

## 📐 Cardinalidades

```
CLIENTES (1) ----< (N) PEDIDOS
CATEGORIAS (1) ----< (N) PRODUCTOS
PEDIDOS (1) ----< (N) DETALLE_PEDIDOS
PRODUCTOS (1) ----< (N) DETALLE_PEDIDOS
PEDIDOS (1) ---- (1) METODOS_PAGO
```

---

## 🎨 Herramientas Utilizadas

- **dbdiagram.io** - Generación del diagrama

---

## 📝 Notas de Diseño

### Normalización
- El modelo está normalizado hasta **3FN (Tercera Forma Normal)**
- No existen dependencias transitivas
- Cada atributo no clave depende completamente de la clave primaria

### Integridad Referencial
- Todas las claves foráneas tienen restricciones `ON DELETE` apropiadas
- Se previene la eliminación de registros con dependencias

### Decisiones de Diseño
1. **DETALLE_PEDIDOS** como tabla intermedia: Permite que un pedido tenga múltiples productos y viceversa (relación N:M)
2. **precio_unitario en DETALLE_PEDIDOS**: Almacena el precio al momento de la compra (puede diferir del precio actual)
3. **Relación 1:1 PEDIDOS-METODOS_PAGO**: Cada pedido tiene un único pago principal

---

## 🔄 Volver al inicio
[← Regresar al README principal](../README.md)
