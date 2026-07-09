-- ============================================================================
-- Project      : Restaurant Management System
-- File         : validation_queries.sql
-- Author       : Harshil Narola
-- DBMS         : PostgreSQL
-- Description  : Validation queries to verify all database constraints,
--                triggers, functions and procedures.
--
-- NOTE:
-- Many of these queries are expected to FAIL.
-- That failure confirms the corresponding constraint is working correctly.
-- ============================================================================



-- ============================================================================
-- SECTION 1 : PRIMARY KEY VALIDATION
-- ============================================================================

-- Duplicate Table Number

INSERT INTO Restaurant_Table
(
    table_number,
    capacity,
    status
)

VALUES
(
    1,
    4,
    'Available'
);



-- ============================================================================
-- SECTION 2 : UNIQUE CONSTRAINT VALIDATION
-- ============================================================================

-- Duplicate Customer Mobile Number

INSERT INTO Customer
(
    name,
    mobile_number
)

VALUES
(
    'Duplicate Customer',
    '9876543210'
);



-- Duplicate Employee Phone Number

INSERT INTO Employee
(
    name,
    phone_number,
    role,
    salary,
    hire_date,
    status
)

VALUES
(
    'Duplicate Employee',
    '9123456702',
    'Chef',
    35000,
    CURRENT_DATE,
    'Active'
);



-- Duplicate Supplier Phone Number

INSERT INTO Supplier
(
    supplier_name,
    contact_person,
    phone_number,
    address
)

VALUES
(
    'Duplicate Supplier',
    'ABC',
    '9011111111',
    'Ahmedabad'
);



-- Duplicate Invoice Number

INSERT INTO Purchase
(
    purchase_date_time,
    payment_date_time,
    invoice_number,
    total_amount,
    status,
    supplier_id
)

VALUES
(
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    'INV-1001',
    1000,
    'Delivered',
    1
);



-- ============================================================================
-- SECTION 3 : NOT NULL VALIDATION
-- ============================================================================

INSERT INTO Customer
(
    name,
    mobile_number
)

VALUES
(
    NULL,
    '9999999999'
);



INSERT INTO Dish
(
    dish_name,
    price,
    status,
    category_name
)

VALUES
(
    NULL,
    100,
    'Available',
    'Indian'
);



-- ============================================================================
-- SECTION 4 : CHECK CONSTRAINT VALIDATION
-- ============================================================================

-- Invalid Mobile Number

INSERT INTO Customer
(
    name,
    mobile_number
)

VALUES
(
    'Invalid Mobile',
    '12345'
);



-- Invalid Salary

INSERT INTO Employee
(
    name,
    phone_number,
    role,
    salary,
    hire_date,
    status
)

VALUES
(
    'Invalid Salary',
    '9876500000',
    'Chef',
    -100,
    CURRENT_DATE,
    'Active'
);



-- Invalid Table Capacity

INSERT INTO Restaurant_Table
(
    table_number,
    capacity,
    status
)

VALUES
(
    25,
    0,
    'Available'
);



-- Invalid Dish Price

INSERT INTO Dish
(
    dish_name,
    price,
    status,
    category_name
)

VALUES
(
    'Invalid Dish',
    -250,
    'Available',
    'Indian'
);



-- Invalid Raw Material Stock

INSERT INTO Raw_Material
(
    material_name,
    current_stock,
    unit,
    minimum_stock
)

VALUES
(
    'Invalid Material',
    -10,
    'kg',
    5
);



-- Invalid Order Status

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
    'Cooking',
    1,
    1,
    1
);



-- ============================================================================
-- SECTION 5 : FOREIGN KEY VALIDATION
-- ============================================================================

-- Invalid Customer

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
    999,
    1,
    1
);



-- Invalid Employee

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
    1,
    999,
    1
);



-- Invalid Restaurant Table

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
    1,
    1,
    999
);



-- Invalid Category

INSERT INTO Dish
(
    dish_name,
    price,
    status,
    category_name
)

VALUES
(
    'Test Dish',
    200,
    'Available',
    'Mexican'
);



-- ============================================================================
-- SECTION 6 : COMPOSITE PRIMARY KEY VALIDATION
-- ============================================================================

-- Duplicate Dish Recipe

INSERT INTO Dish_Recipe
(
    dish_id,
    material_id,
    quantity_required
)

VALUES
(
    1,
    3,
    0.25
);



-- Duplicate Order Item

INSERT INTO Order_Item
(
    order_id,
    dish_id,
    quantity
)

VALUES
(
    1,
    1,
    5
);



-- Duplicate Purchase Item

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
    1,
    20,
    40
);



-- ============================================================================
-- SECTION 7 : FUNCTION VALIDATION
-- ============================================================================

SELECT get_today_revenue();

SELECT get_available_table_count();

SELECT get_low_stock_count();

SELECT get_customer_order_count(999);

SELECT get_bill_amount(999);

SELECT get_remaining_quantity(999);

SELECT is_table_available(999);



-- ============================================================================
-- SECTION 8 : STORED PROCEDURE VALIDATION
-- ============================================================================

CALL prepare_daily_dishes
(
    999,
    20
);



CALL complete_order
(
    999
);



CALL cancel_order
(
    999
);



CALL generate_bill
(
    999,
    20,
    5,
    'Cash'
);



CALL record_purchase
(
    999,
    'INV-999999',
    2500
);



-- ============================================================================
-- SECTION 9 : TRIGGER VALIDATION
-- ============================================================================

-- Low Stock Trigger

UPDATE Raw_Material

SET current_stock = 2

WHERE material_id = 3;



-- Inventory Trigger

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
    10,
    300
);



-- Remaining Quantity Trigger

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
    1
);



-- Table Status Trigger

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
    4
);



SELECT *

FROM Restaurant_Table

WHERE table_number = 4;



-- ============================================================================
-- SECTION 10 : BUSINESS RULE VALIDATION
-- ============================================================================

-- Available Tables

SELECT *

FROM vw_available_tables;



-- Low Stock Materials

SELECT *

FROM vw_low_stock_materials;



-- Today's Orders

SELECT *

FROM vw_today_orders;



-- Today's Revenue

SELECT get_today_revenue();



-- Customer Order Count

SELECT

name,
get_customer_order_count(customer_id)

FROM Customer;



-- Popular Dishes

SELECT *

FROM vw_popular_dishes;



-- Purchase Details

SELECT *

FROM vw_purchase_details;