-- ============================================================================
-- Project      : Restaurant Management System
-- File         : create_views.sql
-- Author       : Harshil Narola
-- DBMS         : PostgreSQL
-- Description  : Creates database views used by the dashboard, reports,
--                inventory management, order management, and billing system.
--
-- NOTE:
-- These views simplify frequently used queries and improve code readability
-- in the backend application.
-- ============================================================================



-- ============================================================================
-- VIEW: vw_available_tables
-- Purpose:
-- Displays all restaurant tables that are currently available.
-- Used in:
--   • Dashboard
--   • New Order Page
-- ============================================================================

CREATE OR REPLACE VIEW vw_available_tables AS

SELECT
    table_number,
    capacity,
    status
FROM Restaurant_Table
WHERE status = 'Available';



-- ============================================================================
-- VIEW: vw_low_stock_materials
-- Purpose:
-- Displays all raw materials whose current stock has reached or fallen below
-- the minimum stock level.
-- Used in:
--   • Dashboard
--   • Inventory Management Page
-- ============================================================================

CREATE OR REPLACE VIEW vw_low_stock_materials AS

SELECT
    material_id,
    material_name,
    current_stock,
    minimum_stock,
    unit
FROM Raw_Material
WHERE current_stock <= minimum_stock;



-- ============================================================================
-- VIEW: vw_today_preparation
-- Purpose:
-- Displays today's prepared dishes along with prepared and remaining quantities.
-- Used in:
--   • Dashboard
--   • Kitchen Preparation Page
-- ============================================================================

CREATE OR REPLACE VIEW vw_today_preparation AS

SELECT
    d.dish_id,
    d.dish_name,
    ddp.prepared_quantity,
    ddp.remaining_quantity
FROM Daily_Dish_Preparation AS ddp
INNER JOIN Dish AS d
        ON ddp.dish_id = d.dish_id
WHERE ddp.preparation_date = CURRENT_DATE;



-- ============================================================================
-- VIEW: vw_today_orders
-- Purpose:
-- Displays all orders placed today.
-- Used in:
--   • Dashboard
--   • Order Management Page
-- ============================================================================

CREATE OR REPLACE VIEW vw_today_orders AS

SELECT
    o.order_id,
    c.customer_id,
    c.name AS customer_name,
    rt.table_number,
    e.employee_id,
    e.name AS employee_name,
    o.status,
    o.order_date_time
FROM Orders AS o
INNER JOIN Customer AS c
        ON o.customer_id = c.customer_id
INNER JOIN Employee AS e
        ON o.employee_id = e.employee_id
INNER JOIN Restaurant_Table AS rt
        ON o.table_number = rt.table_number
WHERE DATE(o.order_date_time) = CURRENT_DATE;



-- ============================================================================
-- VIEW: vw_today_sales
-- Purpose:
-- Displays today's sales summary.
-- Used in:
--   • Dashboard
--   • Reports Page
-- ============================================================================

CREATE OR REPLACE VIEW vw_today_sales AS

SELECT
    COUNT(*) AS total_orders,
    COALESCE(SUM(total_amount), 0) AS total_revenue
FROM Bill
WHERE DATE(bill_date_time) = CURRENT_DATE
  AND payment_status = 'Paid';



-- ============================================================================
-- VIEW: vw_order_details
-- Purpose:
-- Displays complete details of every order including customer, table,
-- ordered dishes and quantities.
-- Used in:
--   • Order Details Page
--   • Billing Page
-- ============================================================================

CREATE OR REPLACE VIEW vw_order_details AS

SELECT
    o.order_id,
    c.name AS customer_name,
    rt.table_number,
    d.dish_name,
    oi.quantity,
    o.status,
    o.order_date_time
FROM Orders AS o
INNER JOIN Customer AS c
        ON o.customer_id = c.customer_id
INNER JOIN Restaurant_Table AS rt
        ON o.table_number = rt.table_number
INNER JOIN Order_Item AS oi
        ON o.order_id = oi.order_id
INNER JOIN Dish AS d
        ON oi.dish_id = d.dish_id;



-- ============================================================================
-- VIEW: vw_purchase_details
-- Purpose:
-- Displays complete purchase history including supplier, raw material,
-- quantity purchased and unit price.
-- Used in:
--   • Purchase Management Page
--   • Purchase Reports
-- ============================================================================

CREATE OR REPLACE VIEW vw_purchase_details AS

SELECT
    p.purchase_id,
    p.purchase_date_time,
    s.supplier_name,
    rm.material_name,
    pi.quantity,
    pi.unit_price,
    p.total_amount,
    p.status
FROM Purchase AS p
INNER JOIN Supplier AS s
        ON p.supplier_id = s.supplier_id
INNER JOIN Purchase_Item AS pi
        ON p.purchase_id = pi.purchase_id
INNER JOIN Raw_Material AS rm
        ON pi.material_id = rm.material_id;



-- ============================================================================
-- VIEW: vw_dish_recipe
-- Purpose:
-- Displays the recipe of every dish along with the quantity of each raw
-- material required.
-- Used in:
--   • Dish Management
--   • Recipe Management
-- ============================================================================

CREATE OR REPLACE VIEW vw_dish_recipe AS

SELECT
    d.dish_name,
    rm.material_name,
    dr.quantity_required,
    rm.unit
FROM Dish_Recipe AS dr
INNER JOIN Dish AS d
        ON dr.dish_id = d.dish_id
INNER JOIN Raw_Material AS rm
        ON dr.material_id = rm.material_id;



-- ============================================================================
-- VIEW: vw_supplier_materials
-- Purpose:
-- Displays which suppliers supply which raw materials.
-- Used in:
--   • Purchase Page
--   • Supplier Management
-- ============================================================================

CREATE OR REPLACE VIEW vw_supplier_materials AS

SELECT
    s.supplier_name,
    rm.material_name
FROM Supplier_Raw_Material AS srm
INNER JOIN Supplier AS s
        ON srm.supplier_id = s.supplier_id
INNER JOIN Raw_Material AS rm
        ON srm.material_id = rm.material_id;



-- ============================================================================
-- VIEW: vw_popular_dishes
-- Purpose:
-- Displays the total quantity sold for every dish.
-- Used in:
--   • Reports Page
--   • Dashboard Analytics
-- ============================================================================

CREATE OR REPLACE VIEW vw_popular_dishes AS

SELECT
    d.dish_id,
    d.dish_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM Order_Item AS oi
INNER JOIN Dish AS d
        ON oi.dish_id = d.dish_id
GROUP BY
    d.dish_id,
    d.dish_name;