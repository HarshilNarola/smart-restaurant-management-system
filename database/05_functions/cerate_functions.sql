-- ============================================================================
-- Project      : Restaurant Management System
-- File         : create_functions.sql
-- Author       : Harshil Narola
-- DBMS         : PostgreSQL
-- Description  : Creates reusable database functions used by the dashboard,
--                billing system, customer management and inventory module.
-- ============================================================================



-- ============================================================================
-- FUNCTION: get_today_revenue()
--
-- Purpose:
-- Returns today's total revenue from all paid bills.
--
-- Used In:
-- • Dashboard
-- • Sales Reports
-- ============================================================================

CREATE OR REPLACE FUNCTION get_today_revenue()

RETURNS DECIMAL(10,2)

AS
$$

DECLARE

    total_revenue DECIMAL(10,2);

BEGIN

    SELECT
        COALESCE(SUM(total_amount),0)

    INTO total_revenue

    FROM Bill

    WHERE DATE(bill_date_time)=CURRENT_DATE
    AND payment_status='Paid';

    RETURN total_revenue;

END;

$$ LANGUAGE plpgsql;





-- ============================================================================
-- FUNCTION: get_available_table_count()
--
-- Purpose:
-- Returns the number of available tables.
--
-- Used In:
-- • Dashboard
-- ============================================================================

CREATE OR REPLACE FUNCTION get_available_table_count()

RETURNS INTEGER

AS
$$

DECLARE

    available_tables INTEGER;

BEGIN

    SELECT
        COUNT(*)

    INTO available_tables

    FROM Restaurant_Table

    WHERE status='Available';

    RETURN available_tables;

END;

$$ LANGUAGE plpgsql;





-- ============================================================================
-- FUNCTION: get_low_stock_count()
--
-- Purpose:
-- Returns the number of raw materials that are at or below
-- the minimum stock level.
--
-- Used In:
-- • Dashboard
-- • Inventory Page
-- ============================================================================

CREATE OR REPLACE FUNCTION get_low_stock_count()

RETURNS INTEGER

AS
$$

DECLARE

    low_stock_count INTEGER;

BEGIN

    SELECT
        COUNT(*)

    INTO low_stock_count

    FROM Raw_Material

    WHERE current_stock <= minimum_stock;

    RETURN low_stock_count;

END;

$$ LANGUAGE plpgsql;





-- ============================================================================
-- FUNCTION: get_customer_order_count()
--
-- Purpose:
-- Returns the total number of orders placed by a customer.
--
-- Parameters:
-- p_customer_id
--
-- Used In:
-- • Customer History
-- ============================================================================

CREATE OR REPLACE FUNCTION get_customer_order_count
(
    p_customer_id INT
)

RETURNS INTEGER

AS
$$

DECLARE

    total_orders INTEGER;

BEGIN

    SELECT
        COUNT(*)

    INTO total_orders

    FROM Orders

    WHERE customer_id = p_customer_id;

    RETURN total_orders;

END;

$$ LANGUAGE plpgsql;





-- ============================================================================
-- FUNCTION: get_bill_amount()
--
-- Purpose:
-- Returns the bill amount for a given order.
--
-- Parameters:
-- p_order_id
--
-- Used In:
-- • Billing
-- • Order Details
-- ============================================================================

CREATE OR REPLACE FUNCTION get_bill_amount
(
    p_order_id BIGINT
)

RETURNS DECIMAL(10,2)

AS
$$

DECLARE

    bill_amount DECIMAL(10,2);

BEGIN

    SELECT
        total_amount

    INTO bill_amount

    FROM Bill

    WHERE order_id = p_order_id;

    RETURN COALESCE(bill_amount,0);

END;

$$ LANGUAGE plpgsql;





-- ============================================================================
-- FUNCTION: get_remaining_quantity()
--
-- Purpose:
-- Returns today's remaining prepared quantity of a dish.
--
-- Parameters:
-- p_dish_id
--
-- Used In:
-- • Kitchen
-- • Order Validation
-- ============================================================================

CREATE OR REPLACE FUNCTION get_remaining_quantity
(
    p_dish_id INT
)

RETURNS INTEGER

AS
$$

DECLARE

    remaining_qty INTEGER;

BEGIN

    SELECT
        remaining_quantity

    INTO remaining_qty

    FROM Daily_Dish_Preparation

    WHERE dish_id = p_dish_id
    AND preparation_date = CURRENT_DATE;

    RETURN COALESCE(remaining_qty,0);

END;

$$ LANGUAGE plpgsql;

-- ============================================================================
-- FUNCTION: is_table_available()
--
-- Purpose:
-- Checks whether a given restaurant table is available for seating customers.
--
-- Parameters:
-- p_table_number
--
-- Returns:
-- TRUE  - If the table status is 'Available'.
-- FALSE - Otherwise.
--
-- Used In:
-- • New Order Page
-- • Table Management
-- • Order Validation
-- ============================================================================

CREATE OR REPLACE FUNCTION is_table_available
(
    p_table_number INT
)

RETURNS BOOLEAN

AS
$$

DECLARE

    table_status VARCHAR(20);

BEGIN

    SELECT
        status

    INTO table_status

    FROM Restaurant_Table

    WHERE table_number = p_table_number;

    RETURN table_status = 'Available';

END;

$$ LANGUAGE plpgsql;