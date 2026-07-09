-- ============================================================================
-- Project      : Restaurant Management System
-- File         : create_indexes.sql
-- Author       : Harshil Narola
-- DBMS         : PostgreSQL
-- Description  : Creates additional indexes to improve query performance.
--
-- NOTE:
-- Primary Key and UNIQUE constraints automatically create indexes.
-- This file contains only manually created indexes for frequently
-- searched, joined, and sorted columns.
-- ============================================================================



-- ============================================================================
-- EMPLOYEE
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_employee_manager
ON Employee(manager_id);



-- ============================================================================
-- DISH
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_dish_category
ON Dish(category_name);



-- ============================================================================
-- ORDERS
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_orders_customer
ON Orders(customer_id);

CREATE INDEX IF NOT EXISTS idx_orders_employee
ON Orders(employee_id);

CREATE INDEX IF NOT EXISTS idx_orders_table
ON Orders(table_number);

CREATE INDEX IF NOT EXISTS idx_orders_datetime
ON Orders(order_date_time);



-- ============================================================================
-- PURCHASE
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_purchase_supplier
ON Purchase(supplier_id);

CREATE INDEX IF NOT EXISTS idx_purchase_date
ON Purchase(purchase_date_time);



-- ============================================================================
-- DAILY DISH PREPARATION
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_preparation_date
ON Daily_Dish_Preparation(preparation_date);



-- ============================================================================
-- DISH RECIPE
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_recipe_material
ON Dish_Recipe(material_id);



-- ============================================================================
-- SUPPLIER RAW MATERIAL
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_supplier_material
ON Supplier_Raw_Material(material_id);



-- ============================================================================
-- ORDER ITEM
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_order_item_dish
ON Order_Item(dish_id);



-- ============================================================================
-- PURCHASE ITEM
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_purchase_item_material
ON Purchase_Item(material_id);
