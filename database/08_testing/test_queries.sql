-- ============================================================================
-- Project      : Restaurant Management System
-- File         : test_queries.sql
-- Author       : Harshil Narola
-- DBMS         : PostgreSQL
-- Description  : Test queries for verifying the Restaurant Management System.
-- ============================================================================



-- ============================================================================
-- SECTION 1 : VERIFY TABLE DATA
-- ============================================================================

SELECT * FROM Customer;

SELECT * FROM Employee;

SELECT * FROM Restaurant_Table;

SELECT * FROM Category;

SELECT * FROM Dish;

SELECT * FROM Raw_Material;

SELECT * FROM Supplier;

SELECT * FROM Orders;

SELECT * FROM Bill;

SELECT * FROM Purchase;

SELECT * FROM Daily_Dish_Preparation;

SELECT * FROM Dish_Recipe;

SELECT * FROM Supplier_Raw_Material;

SELECT * FROM Order_Item;

SELECT * FROM Purchase_Item;



-- ============================================================================
-- SECTION 2 : VERIFY RELATIONSHIPS
-- ============================================================================

-- Customer Orders

SELECT
    c.customer_id,
    c.name,
    o.order_id,
    o.status
FROM Customer c
JOIN Orders o
ON c.customer_id = o.customer_id;



-- Employee handled Orders

SELECT
    e.employee_id,
    e.name,
    o.order_id
FROM Employee e
JOIN Orders o
ON e.employee_id = o.employee_id;



-- Order Details

SELECT
    o.order_id,
    c.name,
    d.dish_name,
    oi.quantity
FROM Orders o
JOIN Customer c
ON o.customer_id = c.customer_id
JOIN Order_Item oi
ON o.order_id = oi.order_id
JOIN Dish d
ON oi.dish_id = d.dish_id;



-- Purchase Details

SELECT
    s.supplier_name,
    rm.material_name,
    pi.quantity
FROM Purchase p
JOIN Supplier s
ON p.supplier_id=s.supplier_id
JOIN Purchase_Item pi
ON p.purchase_id=pi.purchase_id
JOIN Raw_Material rm
ON pi.material_id=rm.material_id;



-- ============================================================================
-- SECTION 3 : TEST VIEWS
-- ============================================================================

SELECT * FROM vw_available_tables;

SELECT * FROM vw_low_stock_materials;

SELECT * FROM vw_today_preparation;

SELECT * FROM vw_today_orders;

SELECT * FROM vw_today_sales;

SELECT * FROM vw_order_details;

SELECT * FROM vw_purchase_details;

SELECT * FROM vw_dish_recipe;

SELECT * FROM vw_supplier_materials;

SELECT * FROM vw_popular_dishes;



-- ============================================================================
-- SECTION 4 : TEST FUNCTIONS
-- ============================================================================

SELECT get_today_revenue();

SELECT get_available_table_count();

SELECT get_low_stock_count();

SELECT get_customer_order_count(1);

SELECT get_bill_amount(1);

SELECT get_remaining_quantity(1);

SELECT is_table_available(1);



-- ============================================================================
-- SECTION 5 : TEST STORED PROCEDURES
-- ============================================================================

-- Prepare Daily Dish

CALL prepare_daily_dishes
(
    2,
    15
);

SELECT *
FROM Daily_Dish_Preparation
WHERE dish_id = 2
AND preparation_date = CURRENT_DATE;



-- Complete Order

CALL complete_order(3);

SELECT
order_id,
status
FROM Orders
WHERE order_id = 3;



-- Generate Bill

CALL generate_bill
(
    3,
    20,
    10,
    'Cash'
);

SELECT *
FROM Bill
WHERE order_id = 3;



-- Record Purchase

CALL record_purchase
(
    2,
    'INV-9999',
    2500
);

SELECT *
FROM Purchase
WHERE invoice_number='INV-9999';



-- Cancel Order

CALL cancel_order(4);

SELECT
order_id,
status
FROM Orders
WHERE order_id=4;



-- ============================================================================
-- SECTION 6 : TEST TRIGGERS
-- ============================================================================

-- Trigger : Low Stock Warning

UPDATE Raw_Material

SET current_stock = 5

WHERE material_id = 3;



-- Trigger : Inventory Update

INSERT INTO Purchase_Item
(
purchase_id,
material_id,
quantity,
unit_price
)

VALUES
(
1,
5,
5,
250
);

SELECT
material_name,
current_stock
FROM Raw_Material
WHERE material_id = 5;



-- Trigger : Table Status

INSERT INTO Orders
(
order_date_time,
status,
customer_id,
employee_id,
table_number
)

VALUES
(
CURRENT_TIMESTAMP,
'Pending',
2,
5,
2
);

SELECT
table_number,
status
FROM Restaurant_Table
WHERE table_number = 2;



-- Trigger : Remaining Quantity

INSERT INTO Order_Item
(
order_id,
dish_id,
quantity
)

VALUES
(
2,
2,
2
);

SELECT
dish_id,
remaining_quantity
FROM Daily_Dish_Preparation
WHERE dish_id=2
AND preparation_date=CURRENT_DATE;



-- ============================================================================
-- SECTION 7 : TEST INDEXES
-- ============================================================================

EXPLAIN ANALYZE

SELECT *

FROM Orders

WHERE customer_id = 5;



EXPLAIN ANALYZE

SELECT *

FROM Purchase

WHERE supplier_id = 2;



EXPLAIN ANALYZE

SELECT *

FROM Dish

WHERE category_name='Indian';



EXPLAIN ANALYZE

SELECT *

FROM Order_Item

WHERE dish_id=5;



-- ============================================================================
-- SECTION 8 : REPORT QUERIES
-- ============================================================================

-- Revenue

SELECT
SUM(total_amount)
AS Total_Revenue
FROM Bill;



-- Best Selling Dish

SELECT
d.dish_name,
SUM(oi.quantity) AS Total_Sold
FROM Dish d
JOIN Order_Item oi
ON d.dish_id=oi.dish_id
GROUP BY d.dish_name
ORDER BY Total_Sold DESC;



-- Customer Order Count

SELECT
c.name,
COUNT(o.order_id) AS Orders_Placed
FROM Customer c
LEFT JOIN Orders o
ON c.customer_id=o.customer_id
GROUP BY c.name
ORDER BY Orders_Placed DESC;



-- Current Low Stock Materials

SELECT *
FROM vw_low_stock_materials;



-- Available Tables

SELECT *
FROM vw_available_tables;



-- Today's Revenue

SELECT get_today_revenue();



-- Dashboard Summary

SELECT

get_today_revenue()                  AS Revenue,

get_available_table_count()          AS Available_Tables,

get_low_stock_count()                AS Low_Stock_Items;