# 🛒 Sistema de Gestión de Tienda Online

## 📋 Descripción del Proyecto

Sistema de base de datos relacional diseñado para gestionar las operaciones de una tienda en línea. Permite administrar clientes, productos, pedidos, categorías y métodos de pago de forma eficiente y escalable.

Este proyecto forma parte del portafolio del **Módulo 5: Fundamentos de bases de datos relacionales** y demuestra el dominio de competencias técnicas en modelado, diseño e implementación de bases de datos usando SQL.

---

## 🎯 Objetivos del Proyecto

- Diseñar un modelo de datos normalizado para un sistema de e-commerce
- Implementar la estructura de base de datos usando DDL (Data Definition Language)
- Manipular datos mediante DML (Data Manipulation Language)
- Crear consultas SQL complejas para análisis de información
- Documentar y versionar el proyecto usando Git y GitHub

---

## 🗂️ Estructura del Repositorio

```
Portafolio_BD/
│
├── README.md                          # Documentación principal
│
├── Modelo_ER/                      # Diseño conceptual
│   ├── README.md                      # Explicación del modelo
│   └── diagrama_modelo.png            # Diagrama entidad-relación
│
├── DDL/                            # Definición de datos
│   ├── README.md                      # Guía de ejecución
│   └── crear_tablas.sql               # Script de creación de tablas
│
├── DML/                            # Manipulación de datos
│   ├── README.md                      # Documentación de operaciones
│   └── insertar_datos.sql             # INSERT, UPDATE, DELETE
│
└── Consultas/                      # Consultas y reportes
    ├── README.md                      # Descripción de consultas
    └── consultas.sql                  # Queries de análisis
```

---

## 📊 Modelo de Datos

### Entidades Principales

El sistema está compuesto por **6 entidades principales**:

| Entidad | Descripción | Atributos Clave |
|---------|-------------|-----------------|
| **CLIENTES** | Usuarios registrados en la tienda | id_cliente (PK), nombre, email, dirección |
| **CATEGORIAS** | Clasificación de productos | id_categoria (PK), nombre |
| **PRODUCTOS** | Catálogo de artículos | id_producto (PK), precio, stock, id_categoria (FK) |
| **PEDIDOS** | Órdenes de compra | id_pedido (PK), id_cliente (FK), total, estado |
| **DETALLE_PEDIDOS** | Líneas de cada pedido | id_detalle (PK), id_pedido (FK), id_producto (FK) |
| **METODOS_PAGO** | Formas de pago utilizadas | id_metodo (PK), id_pedido (FK), tipo_pago |

### Relaciones

- 🔗 **CLIENTES** ↔ **PEDIDOS** (1:N) - Un cliente puede realizar múltiples pedidos
- 🔗 **PEDIDOS** ↔ **DETALLE_PEDIDOS** (1:N) - Un pedido contiene varios productos
- 🔗 **PRODUCTOS** ↔ **DETALLE_PEDIDOS** (1:N) - Un producto puede estar en varios pedidos
- 🔗 **CATEGORIAS** ↔ **PRODUCTOS** (1:N) - Una categoría agrupa varios productos
- 🔗 **PEDIDOS** ↔ **METODOS_PAGO** (1:1) - Cada pedido tiene un método de pago

Ver diagrama completo en: [`Modelo_ER/diagrama_modelo.png`](01_Modelo_ER/diagrama_modelo.png)

---

## 🚀 Instalación y Uso

### Requisitos Previos

- MySQL 8.0+ o PostgreSQL 12+
- Cliente SQL (MySQL Workbench, pgAdmin, DBeaver, etc.)
- Git (opcional, para clonar el repositorio)

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/too0oori/M5_EvaluacionPortafolio
   cd M5_EVALUACIONPORTAFOLIO
   ```

2. **Crear la base de datos**
   ```bash
   mysql -u root -p < DDL/tienda_online.sql
   ```

3. **Insertar datos de prueba**
   ```bash
   mysql -u root -p tienda_online < DML/insertar_datos.sql
   ```

4. **Ejecutar consultas de ejemplo**
   ```bash
   mysql -u root -p tienda_online < Consultas/consultas.sql
   ```

---

## 📈 Funcionalidades Implementadas

### ✅ Requerimiento 1: Modelo Relacional
- [x] Diseño de 6 tablas normalizadas (3FN)
- [x] Definición de claves primarias y foráneas
- [x] Diagrama ER con cardinalidades

### ✅ Requerimiento 2: Consultas SQL (DQL)
- [x] Consultas básicas con SELECT y WHERE
- [x] JOINs múltiples (INNER, LEFT)
- [x] Subconsultas
- [x] Funciones de agregación (COUNT, SUM, AVG)
- [x] Agrupamiento con GROUP BY y HAVING

### ✅ Requerimiento 3: Manipulación de Datos (DML)
- [x] INSERT de datos en todas las tablas
- [x] UPDATE para modificar registros
- [x] DELETE para eliminar datos

### ✅ Requerimiento 4: Definición de Datos (DDL)
- [x] CREATE TABLE con tipos de datos apropiados
- [x] Restricciones de integridad (NOT NULL, UNIQUE)
- [x] Claves foráneas con integridad referencial

### ✅ Requerimiento 5: Modelado de Datos
- [x] Modelo entidad-relación completo
- [x] Normalización de tablas
- [x] Documentación del diseño

---

## 💡 Ejemplos de Consultas

### Consulta 1: Pedidos de un Cliente Específico
```sql
SELECT * FROM pedidos WHERE id_cliente = 1;
```

### Consulta 2: Detalle Completo de Pedidos (JOIN Múltiple)
```sql
SELECT 
    p.id_pedido,
    c.nombre AS cliente,
    pr.nombre AS producto,
    dp.cantidad,
    dp.precio_unitario
FROM detalle_pedidos dp
INNER JOIN pedidos p ON dp.id_pedido = p.id_pedido
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
INNER JOIN productos pr ON dp.id_producto = pr.id_producto;
```

### Consulta 3: Total de Ventas por Cliente (GROUP BY)
```sql
SELECT 
    c.nombre,
    COUNT(p.id_pedido) AS total_pedidos,
    SUM(p.total) AS monto_total
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre;
```

Ver más consultas en: [`Consultas/consultas.sql`](Consultas/consultas.sql)

---

## 🛠️ Tecnologías Utilizadas

- **Motor de Base de Datos:** MySQL 8.0 / PostgreSQL
- **Lenguaje:** SQL (DDL, DML, DQL)
- **Herramientas de Modelado:** dbdiagram.io 
- **Control de Versiones:** Git & GitHub
- **Editor:** Visual Studio Code / MySQL Workbench

---

## 📚 Aprendizajes Clave

Durante el desarrollo de este proyecto se aplicaron los siguientes conceptos:

- ✅ Normalización de bases de datos hasta 3FN
- ✅ Diseño de relaciones uno a muchos (1:N) y uno a uno (1:1)
- ✅ Uso de claves primarias y foráneas para integridad referencial
- ✅ Consultas complejas con múltiples JOINs
- ✅ Funciones de agregación y agrupamiento
- ✅ Subconsultas correlacionadas
- ✅ Transacciones y operaciones CRUD

---

## 🔄 Historial de Cambios

### Versión 1.0.0 (30/11/2025)
- ✨ Commit inicial: Estructura del proyecto y modelo ER
- 🗃️ Agregado: Scripts DDL para creación de tablas
- 📝 Agregado: Scripts DML y consultas SQL completas

---

## 👤 Autor

**[Sofía Lagos]**
- GitHub: [@too0oori](https://github.com/too0oori)
- Email: sofia.lagos.cesped@gmail.com
- LinkedIn: [Mi Perfil](https://www.linkedin.com/in/sofia-lagos-cesped/)

---

## 📄 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

---

## 🙏 Agradecimientos

- Bootcamp/Institución: Desarrollo Full Stack Python Skillnest - Talento Digital
- Instructor: Cristian Iglesias y Mauricio Casanova

---

⭐ **Si este proyecto te fue útil, considera darle una estrella en GitHub** ⭐