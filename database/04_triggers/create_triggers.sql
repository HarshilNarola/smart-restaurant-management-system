-- ============================================================================
-- Project      : Restaurant Management System
-- File         : create_triggers.sql
-- Author       : Harshil Narola
-- DBMS         : PostgreSQL
-- Description  : Creates database trigger functions and triggers used for
--                inventory management, restaurant table management, and
--                daily dish preparation.
-- ============================================================================



-- ============================================================================
-- TRIGGER 1
-- LOW STOCK WARNING
-- ============================================================================

CREATE OR REPLACE FUNCTION fn_check_low_stock()

RETURNS TRIGGER

AS
$$

BEGIN

    IF NEW.current_stock <= NEW.minimum_stock THEN

        RAISE WARNING
        'LOW STOCK ALERT: % has reached the minimum stock level.',
        NEW.material_name;

    END IF;

    RETURN NEW;

END;

$$ LANGUAGE plpgsql;



CREATE TRIGGER trg_check_low_stock

AFTER UPDATE OF current_stock

ON Raw_Material

FOR EACH ROW

EXECUTE FUNCTION fn_check_low_stock();





-- ============================================================================
-- TRIGGER 2
-- REDUCE REMAINING PREPARED QUANTITY
-- ============================================================================

CREATE OR REPLACE FUNCTION fn_reduce_remaining_quantity()

RETURNS TRIGGER

AS
$$

BEGIN

    UPDATE Daily_Dish_Preparation

    SET remaining_quantity =
        remaining_quantity - NEW.quantity

    WHERE dish_id = NEW.dish_id
    AND preparation_date = CURRENT_DATE;

    RETURN NEW;

END;

$$ LANGUAGE plpgsql;



CREATE TRIGGER trg_reduce_remaining_quantity

AFTER INSERT

ON Order_Item

FOR EACH ROW

EXECUTE FUNCTION fn_reduce_remaining_quantity();





-- ============================================================================
-- TRIGGER 3
-- UPDATE RESTAURANT TABLE STATUS
-- ============================================================================

CREATE OR REPLACE FUNCTION fn_update_table_status()

RETURNS TRIGGER

AS
$$

BEGIN

    IF TG_OP = 'INSERT' THEN

        UPDATE Restaurant_Table

        SET status = 'Occupied'

        WHERE table_number = NEW.table_number;

    ELSIF TG_OP = 'UPDATE' THEN

        IF NEW.status = 'Completed'
        OR NEW.status = 'Cancelled'
        THEN

            UPDATE Restaurant_Table

            SET status = 'Available'

            WHERE table_number = NEW.table_number;

        END IF;

    END IF;

    RETURN NEW;

END;

$$ LANGUAGE plpgsql;



CREATE TRIGGER trg_table_occupied

AFTER INSERT

ON Orders

FOR EACH ROW

EXECUTE FUNCTION fn_update_table_status();



CREATE TRIGGER trg_table_available

AFTER UPDATE OF status

ON Orders

FOR EACH ROW

EXECUTE FUNCTION fn_update_table_status();





-- ============================================================================
-- TRIGGER 4
-- UPDATE RAW MATERIAL STOCK AFTER PURCHASE
-- ============================================================================

CREATE OR REPLACE FUNCTION fn_update_inventory_after_purchase()

RETURNS TRIGGER

AS
$$

BEGIN

    UPDATE Raw_Material

    SET current_stock =
        current_stock + NEW.quantity

    WHERE material_id = NEW.material_id;

    RETURN NEW;

END;

$$ LANGUAGE plpgsql;



CREATE TRIGGER trg_update_inventory_after_purchase

AFTER INSERT

ON Purchase_Item

FOR EACH ROW

EXECUTE FUNCTION fn_update_inventory_after_purchase();