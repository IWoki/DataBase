CREATE OR REPLACE FUNCTION prevent_price_change_for_ordered_items()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_order_count INT;
BEGIN
    SELECT COUNT(*) INTO v_order_count
    FROM order_items
    WHERE product_id = NEW.product_id;
    
    IF v_order_count > 0 AND NEW.price != OLD.price THEN
        RAISE EXCEPTION 'Cannot change price for product % with existing orders', NEW.product_id;
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_prevent_price_change_for_ordered_items
BEFORE UPDATE OF price ON products
FOR EACH ROW
EXECUTE FUNCTION prevent_price_change_for_ordered_items();