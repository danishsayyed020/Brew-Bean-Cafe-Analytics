
-- =========================================
-- Brew & Bean Cafe Sales & Inventory Analytics
-- Database Creation
-- =========================================

CREATE DATABASE BrewBeanCafe;

USE BrewBeanCafe;

-- =========================================
-- Table Creation
-- =========================================

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    joined_on DATE
);

SHOW TABLES;

DESCRIBE customers;


CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    hire_date DATE,
    salary DECIMAL(10,2)
);


DESCRIBE employees;

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

DESCRIBE categories;

CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50)
);

DESCRIBE suppliers;

CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(8,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);


CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    stock_quantity INT NOT NULL,
    reorder_level INT NOT NULL,

    FOREIGN KEY (item_id)
        REFERENCES menu_items(item_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    order_status VARCHAR(20) DEFAULT 'Completed',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(8,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (item_id)
        REFERENCES menu_items(item_id)
);


CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method VARCHAR(20),
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

SHOW TABLES;


-- =========================================
-- Insert Sample Data
-- =========================================

INSERT INTO categories (category_name)
VALUES
('Coffee'),
('Tea'),
('Cold Beverages'),
('Snacks'),
('Desserts');

SELECT * FROM categories;

INSERT INTO employees
(full_name, role, phone, hire_date, salary)
VALUES
('Neha Joshi','Manager','9876543210','2024-01-15',45000),
('Rahul Shaikh','Barista','9876543211','2024-03-20',25000),
('Priya Patil','Cashier','9876543212','2024-04-10',23000),
('Aman Khan','Barista','9876543213','2024-06-18',25000),
('Sneha Kulkarni','Cashier','9876543214','2025-01-05',24000),
('Rohan Deshmukh','Chef','9876543215','2024-07-22',32000),
('Aditya More','Barista','9876543216','2025-02-14',26000),
('Pooja Sharma','Chef','9876543217','2025-03-10',33000);

SELECT * FROM employees;

INSERT INTO customers
(full_name, phone, email, city, joined_on)
VALUES
('Aarav Sharma','9123456781','aarav@gmail.com','Pune','2025-01-10'),
('Riya Patil','9123456782','riya@gmail.com','Mumbai','2025-01-15'),
('Mohammed Shaikh','9123456783','mohammed@gmail.com','Aurangabad','2025-02-01'),
('Sneha Deshmukh','9123456784','sneha@gmail.com','Nashik','2025-02-12'),
('Aditya Joshi','9123456785','aditya@gmail.com','Nagpur','2025-03-05'),
('Priya Kulkarni','9123456786','priya@gmail.com','Pune','2025-03-25'),
('Rahul More','9123456787','rahul@gmail.com','Mumbai','2025-04-18'),
('Ananya Khan','9123456788','ananya@gmail.com','Hyderabad','2025-05-10'),
('Karan Patil','9123456789','karan@gmail.com','Pune','2025-06-08'),
('Isha Shaikh','9123456790','isha@gmail.com','Aurangabad','2025-06-20');

SELECT * FROM customers;

INSERT INTO suppliers
(supplier_name, contact_person, phone, city)
VALUES
('Fresh Dairy Supplies','Anil Patil','9000000001','Pune'),
('Coffee Bean Traders','Rakesh Sharma','9000000002','Bengaluru'),
('Sweet Treat Distributors','Neha Joshi','9000000003','Mumbai'),
('Bake House Suppliers','Amit Khan','9000000004','Pune'),
('Fresh Farm Produce','Sneha Kulkarni','9000000005','Nashik');

SELECT * FROM suppliers;

INSERT INTO menu_items
(item_name, category_id, price)
VALUES
('Espresso',1,120),
('Americano',1,140),
('Cappuccino',1,180),
('Latte',1,190),
('Mocha',1,210),

('Masala Tea',2,90),
('Green Tea',2,100),
('Lemon Tea',2,110),

('Cold Coffee',3,220),
('Chocolate Shake',3,250),
('Mango Smoothie',3,230),

('Veg Sandwich',4,160),
('Paneer Wrap',4,220),
('French Fries',4,150),
('Garlic Bread',4,170),

('Chocolate Brownie',5,180),
('Blueberry Cheesecake',5,260),
('Chocolate Muffin',5,140);


SELECT * FROM menu_items;

INSERT INTO inventory
(item_id, stock_quantity, reorder_level)
VALUES
(1,50,10),
(2,40,10),
(3,60,15),
(4,55,15),
(5,35,10),
(6,70,20),
(7,45,15),
(8,40,10),
(9,30,10),
(10,25,10),
(11,20,5),
(12,40,10),
(13,25,10),
(14,50,15),
(15,35,10),
(16,30,10),
(17,15,5),
(18,25,10);

SELECT * FROM inventory;

INSERT INTO orders
(customer_id, employee_id, order_date, order_status)
VALUES
(1,3,'2026-07-01 09:15:00','Completed'),
(2,2,'2026-07-01 10:20:00','Completed'),
(3,4,'2026-07-01 11:05:00','Completed'),
(4,1,'2026-07-02 09:45:00','Completed'),
(5,5,'2026-07-02 12:10:00','Completed'),
(6,3,'2026-07-03 15:20:00','Completed'),
(7,2,'2026-07-03 17:30:00','Completed'),
(8,4,'2026-07-04 11:00:00','Completed'),
(9,6,'2026-07-04 18:15:00','Completed'),
(10,7,'2026-07-05 14:45:00','Completed');

SELECT * FROM orders;

INSERT INTO order_details
(order_id, item_id, quantity, unit_price)
VALUES
(1,3,2,180),
(1,16,1,180),

(2,4,1,190),
(2,12,2,160),

(3,1,1,120),
(3,14,1,150),

(4,9,2,220),

(5,5,1,210),
(5,17,1,260),

(6,6,2,90),

(7,13,1,220),
(7,15,1,170),

(8,10,1,250),
(8,18,2,140),

(9,2,2,140),

(10,11,1,230),
(10,16,1,180);

SELECT * FROM order_details;

INSERT INTO payments
(order_id, payment_method, amount, payment_date)
VALUES
(1,'UPI',540,'2026-07-01 09:20:00'),
(2,'Card',510,'2026-07-01 10:25:00'),
(3,'Cash',270,'2026-07-01 11:10:00'),
(4,'UPI',440,'2026-07-02 09:50:00'),
(5,'Card',470,'2026-07-02 12:15:00'),
(6,'Cash',180,'2026-07-03 15:25:00'),
(7,'UPI',390,'2026-07-03 17:35:00'),
(8,'Card',530,'2026-07-04 11:05:00'),
(9,'Cash',280,'2026-07-04 18:20:00'),
(10,'UPI',410,'2026-07-05 14:50:00');




