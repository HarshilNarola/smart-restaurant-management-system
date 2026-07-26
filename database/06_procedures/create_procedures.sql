-- ============================================================================
-- Project      : Restaurant Management System
-- File         : create_procedures.sql
-- Author       : Harshil Narola
-- DBMS         : PostgreSQL
-- Description  : Creates stored procedures used for restaurant operations.
-- ============================================================================



-- ============================================================================
-- PROCEDURE: prepare_daily_dishes()
--
-- Purpose:
-- Adds today's prepared quantity for a dish and automatically
-- deducts the required raw materials from inventory.
--
-- Parameters:
-- p_dish_id
-- p_prepared_quantity
--
-- Used In:
-- • Daily Preparation Page
-- ============================================================================

CREATE OR REPLACE PROCEDURE prepare_daily_dishes
(
    IN p_dish_id INT,
    IN p_prepared_quantity INT
)

LANGUAGE plpgsql

AS
$$

BEGIN

    ---------------------------------------------------------------------------
    -- Step 1 : Insert today's preparation
    ---------------------------------------------------------------------------

    INSERT INTO Daily_Dish_Preparation
    (
        dish_id,
        preparation_date,
        prepared_quantity,
        remaining_quantity
    )

    VALUES
    (
        p_dish_id,
        CURRENT_DATE,
        p_prepared_quantity,
        p_prepared_quantity
    );



    ---------------------------------------------------------------------------
    -- Step 2 : Deduct raw materials according to the recipe
    ---------------------------------------------------------------------------

    UPDATE Raw_Material rm

    SET current_stock =
        rm.current_stock -
        (
            dr.quantity_required * p_prepared_quantity
        )

    FROM Dish_Recipe dr

    WHERE dr.material_id = rm.material_id
      AND dr.dish_id = p_dish_id;

END;

$$;





-- ============================================================================
-- PROCEDURE: generate_bill()
--
-- Purpose:
-- Generates a bill for a completed order.
--
-- Parameters:
-- p_order_id
-- p_tax
-- p_discount
-- p_payment_mode
--
-- Used In:
-- • Billing Page
-- ============================================================================

CREATE OR REPLACE PROCEDURE generate_bill
(
    IN p_order_id BIGINT,
    IN p_tax DECIMAL(10,2),
    IN p_discount DECIMAL(10,2),
    IN p_payment_mode VARCHAR(20)
)

LANGUAGE plpgsql

AS
$$

DECLARE

    v_subtotal DECIMAL(10,2);

BEGIN

    SELECT
        SUM(d.price * oi.quantity)

    INTO v_subtotal

    FROM Order_Item oi

    INNER JOIN Dish d
        ON oi.dish_id = d.dish_id

    WHERE oi.order_id = p_order_id;

    INSERT INTO Bill
    (
        bill_date_time,
        subtotal,
        tax,
        discount,
        total_amount,
        payment_mode,
        payment_status,
        order_id
    )

    VALUES
    (
        CURRENT_TIMESTAMP,
        COALESCE(v_subtotal,0),
        p_tax,
        p_discount,
        COALESCE(v_subtotal,0) + p_tax - p_discount,
        p_payment_mode,
        'Paid',
        p_order_id
    );

END;

$$;





-- ============================================================================
-- PROCEDURE: record_purchase()
--
-- Purpose:
-- Creates a purchase record.
--
-- Note:
-- Purchase items are inserted separately.
-- Inventory will be updated automatically by triggers.
--
-- Parameters:
-- p_supplier_id
-- p_invoice_number
-- p_total_amount
--
-- Used In:
-- • Purchase Page
-- ============================================================================

CREATE OR REPLACE PROCEDURE record_purchase
(
    IN p_supplier_id INT,
    IN p_invoice_number VARCHAR(50),
    IN p_total_amount DECIMAL(10,2)
)

LANGUAGE plpgsql

AS
$$

BEGIN

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
        NULL,
        p_invoice_number,
        p_total_amount,
        'Ordered',
        p_supplier_id
    );

END;

$$;





-- ============================================================================
-- PROCEDURE: complete_order()
--
-- Purpose:
-- Marks an order as completed.
--
-- The trigger automatically marks the table as Available.
--
-- Parameters:
-- p_order_id
--
-- Used In:
-- • Order Management
-- ============================================================================

CREATE OR REPLACE PROCEDURE complete_order
(
    IN p_order_id BIGINT
)

LANGUAGE plpgsql

AS
$$

BEGIN

    -- Mark the order as completed
    UPDATE Orders
    SET status = 'Completed'
    WHERE order_id = p_order_id;

END;

$$;





-- ============================================================================
-- PROCEDURE: cancel_order()
--
-- Purpose:
-- Cancels an order.
--
-- Restores the prepared quantity of every ordered dish.
-- The trigger automatically marks the table as Available.
--
-- Parameters:
-- p_order_id
--
-- Used In:
-- • Order Management
-- ============================================================================

CREATE OR REPLACE PROCEDURE cancel_order
(
    IN p_order_id BIGINT
)

LANGUAGE plpgsql

AS
$$

BEGIN

    UPDATE Daily_Dish_Preparation ddp

    SET remaining_quantity =
        remaining_quantity + oi.quantity

    FROM Order_Item oi

    WHERE oi.order_id = p_order_id
      AND oi.dish_id = ddp.dish_id
      AND ddp.preparation_date = CURRENT_DATE;

    UPDATE Orders

    SET status = 'Cancelled'

    WHERE order_id = p_order_id;

END;

$$;