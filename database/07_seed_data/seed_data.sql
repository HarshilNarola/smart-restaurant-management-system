-- ============================================================================
-- Project      : Restaurant Management System
-- File         : seed_data.sql
-- Author       : Harshil Narola
-- DBMS         : PostgreSQL
-- Description  : Seed data for master tables.
-- ============================================================================



-- ============================================================================
-- CATEGORY
-- ============================================================================

INSERT INTO Category
(
    category_name
)

VALUES
    ('Indian'),
    ('Chinese'),
    ('Italian'),
    ('South Indian'),
    ('Fast Food'),
    ('Beverages'),
    ('Desserts'),
    ('Soups');



-- ============================================================================
-- RESTAURANT TABLE
-- ============================================================================

INSERT INTO Restaurant_Table
(
    table_number,
    capacity,
    status
)

VALUES
    (1,2,'Available'),
    (2,2,'Available'),
    (3,4,'Available'),
    (4,4,'Available'),
    (5,4,'Available'),
    (6,6,'Available'),
    (7,6,'Available'),
    (8,8,'Available'),
    (9,8,'Available'),
    (10,10,'Available');



-- ============================================================================
-- CUSTOMER
-- ============================================================================

INSERT INTO Customer
(
    name,
    mobile_number
)

VALUES
    ('Rahul Sharma','9876543210'),
    ('Priya Patel','9876543211'),
    ('Amit Verma','9876543212'),
    ('Neha Joshi','9876543213'),
    ('Karan Mehta','9876543214'),
    ('Sneha Shah','9876543215'),
    ('Rohan Desai','9876543216'),
    ('Anjali Singh','9876543217'),
    ('Vivek Kumar','9876543218'),
    ('Pooja Nair','9876543219'),
    ('Arjun Malhotra','9876543220'),
    ('Meera Iyer','9876543221'),
    ('Nikhil Jain','9876543222'),
    ('Simran Kaur','9876543223'),
    ('Yash Patel','9876543224');



-- ============================================================================
-- EMPLOYEE
-- ============================================================================

INSERT INTO Employee
(
    name,
    phone_number,
    role,
    salary,
    hire_date,
    status,
    manager_id
)

VALUES
    ('Rajesh Patel','9123456701','Manager',60000,'2022-01-10','Active',NULL),

    ('Ankit Sharma','9123456702','Cashier',35000,'2023-02-15','Active',1),

    ('Ramesh Yadav','9123456703','Chef',45000,'2022-08-12','Active',1),

    ('Suresh Kumar','9123456704','Chef',42000,'2023-05-20','Active',1),

    ('Vikas Singh','9123456705','Waiter',25000,'2024-01-08','Active',1),

    ('Aman Gupta','9123456706','Waiter',25000,'2024-01-08','Active',1),

    ('Kajal Shah','9123456707','Cashier',32000,'2024-03-10','Active',1),

    ('Nitin Joshi','9123456708','Waiter',24000,'2024-06-01','Active',1);



-- ============================================================================
-- SUPPLIER
-- ============================================================================

INSERT INTO Supplier
(
    supplier_name,
    contact_person,
    phone_number,
    address
)

VALUES
    ('Fresh Farm Suppliers','Mahesh Patel','9011111111','Ahmedabad'),

    ('Green Valley Traders','Amit Shah','9011111112','Surat'),

    ('Dairy Fresh Pvt Ltd','Karan Mehta','9011111113','Vadodara'),

    ('Spice House','Rohit Sharma','9011111114','Rajkot'),

    ('Ocean Foods','Vishal Patel','9011111115','Jamnagar'),

    ('Royal Beverages','Neeraj Gupta','9011111116','Ahmedabad'),

    ('Sweet Delights','Anil Verma','9011111117','Surat'),

    ('Quality Foods','Raj Malhotra','9011111118','Vadodara');



-- ============================================================================
-- RAW MATERIAL
-- ============================================================================

INSERT INTO Raw_Material
(
    material_name,
    current_stock,
    unit,
    minimum_stock
)

VALUES
    ('Rice',100,'kg',20),
    ('Wheat Flour',80,'kg',15),
    ('Paneer',40,'kg',10),
    ('Milk',120,'l',25),
    ('Cheese',30,'kg',8),
    ('Tomato',60,'kg',15),
    ('Onion',70,'kg',20),
    ('Potato',90,'kg',20),
    ('Capsicum',35,'kg',10),
    ('Carrot',40,'kg',10),
    ('Cabbage',45,'kg',10),
    ('Butter',30,'kg',8),
    ('Cooking Oil',100,'l',20),
    ('Salt',50,'kg',10),
    ('Sugar',60,'kg',15),
    ('Tea Powder',25,'kg',5),
    ('Coffee Powder',20,'kg',5),
    ('Soft Drink Syrup',30,'l',8),
    ('Ice Cream',40,'kg',10),
    ('Chocolate Syrup',20,'l',5);



-- ============================================================================
-- DISH
-- ============================================================================

INSERT INTO Dish
(
    dish_name,
    price,
    status,
    category_name
)

VALUES
    ('Paneer Butter Masala',280,'Available','Indian'),
    ('Dal Fry',180,'Available','Indian'),
    ('Veg Biryani',250,'Available','Indian'),
    ('Fried Rice',220,'Available','Chinese'),
    ('Hakka Noodles',230,'Available','Chinese'),
    ('Manchurian',210,'Available','Chinese'),
    ('Margherita Pizza',350,'Available','Italian'),
    ('White Sauce Pasta',320,'Available','Italian'),
    ('Masala Dosa',160,'Available','South Indian'),
    ('Idli Sambhar',140,'Available','South Indian'),
    ('Veg Burger',180,'Available','Fast Food'),
    ('French Fries',120,'Available','Fast Food'),
    ('Cold Coffee',150,'Available','Beverages'),
    ('Masala Tea',50,'Available','Beverages'),
    ('Chocolate Brownie',180,'Available','Desserts'),
    ('Ice Cream Sundae',170,'Available','Desserts'),
    ('Tomato Soup',140,'Available','Soups'),
    ('Sweet Corn Soup',150,'Available','Soups');


    -- ============================================================================
-- TRANSACTION TABLES
-- ============================================================================



-- ============================================================================
-- ORDERS
-- ============================================================================

INSERT INTO Orders
(
    order_date_time,
    status,
    customer_id,
    employee_id,
    table_number
)

VALUES
    ('2026-07-06 11:15:00','Completed',1,5,1),
    ('2026-07-06 11:40:00','Completed',2,6,2),
    ('2026-07-06 12:05:00','Preparing',3,5,3),
    ('2026-07-06 12:20:00','Pending',4,6,4),
    ('2026-07-06 12:45:00','Completed',5,8,5),
    ('2026-07-06 13:10:00','Served',6,5,6),
    ('2026-07-06 13:25:00','Completed',7,6,7),
    ('2026-07-06 14:00:00','Preparing',8,5,8),
    ('2026-07-06 14:20:00','Completed',9,8,9),
    ('2026-07-06 14:40:00','Pending',10,6,10);



-- ============================================================================
-- BILL
-- ============================================================================

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
    ('2026-07-06 11:50:00',560.00,28.00,20.00,568.00,'Cash','Paid',1),

    ('2026-07-06 12:00:00',440.00,22.00,10.00,452.00,'UPI','Paid',2),

    ('2026-07-06 13:00:00',730.00,36.50,30.00,736.50,'Card','Paid',5),

    ('2026-07-06 13:40:00',610.00,30.50,0.00,640.50,'UPI','Paid',7),

    ('2026-07-06 14:50:00',520.00,26.00,15.00,531.00,'Cash','Paid',9);



-- ============================================================================
-- PURCHASE
-- ============================================================================

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
    ('2026-07-05 09:00:00',
     '2026-07-05 10:00:00',
     'INV-1001',
     5200.00,
     'Delivered',
     1),

    ('2026-07-05 09:30:00',
     '2026-07-05 10:15:00',
     'INV-1002',
     3400.00,
     'Delivered',
     2),

    ('2026-07-05 10:00:00',
     '2026-07-05 11:00:00',
     'INV-1003',
     2700.00,
     'Delivered',
     3),

    ('2026-07-05 11:00:00',
     NULL,
     'INV-1004',
     1800.00,
     'Ordered',
     4),

    ('2026-07-05 11:30:00',
     NULL,
     'INV-1005',
     4200.00,
     'Ordered',
     5),

    ('2026-07-05 12:00:00',
     '2026-07-05 13:00:00',
     'INV-1006',
     3100.00,
     'Delivered',
     6),

    ('2026-07-05 12:30:00',
     NULL,
     'INV-1007',
     2500.00,
     'Ordered',
     7),

    ('2026-07-05 13:00:00',
     '2026-07-05 14:00:00',
     'INV-1008',
     3900.00,
     'Delivered',
     8);

     -- ============================================================================
-- WEAK ENTITY
-- ============================================================================



-- ============================================================================
-- DAILY_DISH_PREPARATION
-- ============================================================================

INSERT INTO Daily_Dish_Preparation
(
    dish_id,
    preparation_date,
    prepared_quantity,
    remaining_quantity
)

VALUES
    (1,CURRENT_DATE,40,35),
    (2,CURRENT_DATE,35,32),
    (3,CURRENT_DATE,30,27),
    (4,CURRENT_DATE,30,26),
    (5,CURRENT_DATE,25,22),
    (6,CURRENT_DATE,25,23),
    (7,CURRENT_DATE,20,18),
    (8,CURRENT_DATE,20,18),
    (9,CURRENT_DATE,40,38),
    (10,CURRENT_DATE,35,34),
    (11,CURRENT_DATE,30,28),
    (12,CURRENT_DATE,40,39),
    (13,CURRENT_DATE,25,22),
    (14,CURRENT_DATE,60,56),
    (15,CURRENT_DATE,20,18),
    (16,CURRENT_DATE,20,19),
    (17,CURRENT_DATE,25,23),
    (18,CURRENT_DATE,25,24);



-- ============================================================================
-- JUNCTION TABLES
-- ============================================================================



-- ============================================================================
-- DISH_RECIPE
-- ============================================================================

INSERT INTO Dish_Recipe
(
    dish_id,
    material_id,
    quantity_required
)

VALUES

-- Paneer Butter Masala
(1,3,0.25),
(1,6,0.15),
(1,12,0.05),
(1,14,0.01),

-- Dal Fry
(2,6,0.10),
(2,7,0.08),
(2,12,0.03),
(2,14,0.01),

-- Veg Biryani
(3,1,0.30),
(3,6,0.10),
(3,7,0.08),
(3,13,0.05),

-- Fried Rice
(4,1,0.25),
(4,6,0.08),
(4,9,0.05),

-- Hakka Noodles
(5,7,0.05),
(5,9,0.05),
(5,10,0.05),
(5,13,0.04),

-- Manchurian
(6,6,0.05),
(6,7,0.05),
(6,11,0.08),

-- Margherita Pizza
(7,2,0.20),
(7,5,0.15),
(7,6,0.08),

-- White Sauce Pasta
(8,2,0.18),
(8,5,0.12),
(8,4,0.15),

-- Masala Dosa
(9,1,0.15),
(9,7,0.05),
(9,13,0.03),

-- Idli Sambhar
(10,1,0.12),
(10,7,0.05),

-- Veg Burger
(11,2,0.12),
(11,6,0.05),
(11,5,0.04),

-- French Fries
(12,8,0.20),
(12,13,0.05),

-- Cold Coffee
(13,4,0.20),
(13,17,0.02),
(13,15,0.02),

-- Masala Tea
(14,4,0.15),
(14,16,0.01),
(14,15,0.01),

-- Chocolate Brownie
(15,2,0.12),
(15,15,0.04),
(15,20,0.03),

-- Ice Cream Sundae
(16,19,0.20),
(16,20,0.03),

-- Tomato Soup
(17,6,0.15),
(17,12,0.02),

-- Sweet Corn Soup
(18,10,0.08),
(18,12,0.02);



-- ============================================================================
-- SUPPLIER_RAW_MATERIAL
-- ============================================================================

INSERT INTO Supplier_Raw_Material
(
    supplier_id,
    material_id
)

VALUES

(1,1),
(1,2),
(1,8),

(2,6),
(2,7),
(2,9),
(2,10),
(2,11),

(3,3),
(3,4),
(3,5),
(3,12),

(4,13),
(4,14),
(4,15),

(5,16),
(5,17),

(6,18),

(7,19),
(7,20),

(8,1),
(8,6),
(8,13);



-- ============================================================================
-- ORDER_ITEM
-- ============================================================================

INSERT INTO Order_Item
(
    order_id,
    dish_id,
    quantity
)

VALUES

(1,1,2),
(1,14,2),

(2,4,2),

(3,5,2),
(3,13,2),

(4,11,3),

(5,3,2),
(5,15,2),

(6,9,2),
(6,14,2),

(7,7,1),
(7,8,1),

(8,18,2),

(9,12,3),
(9,13,2),

(10,2,2);



-- ============================================================================
-- PURCHASE_ITEM
-- ============================================================================

INSERT INTO Purchase_Item
(
    purchase_id,
    material_id,
    quantity,
    unit_price
)

VALUES

(1,1,50,55),
(1,2,40,40),

(2,6,30,25),
(2,7,40,22),

(3,3,20,320),
(3,4,50,60),

(4,13,40,120),

(5,16,15,450),
(5,17,10,650),

(6,18,20,180),

(7,19,25,280),

(8,20,15,350);