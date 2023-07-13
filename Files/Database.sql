create database OSC_MS
use OSC_MS

-- Create the table for categories
CREATE TABLE categories (
  category_id INT PRIMARY KEY IDENTITY,
  category_name VARCHAR(255)
);

-- Create the table for products
CREATE TABLE products (
  product_id INT PRIMARY KEY IDENTITY,
  category_id INT,
  product_code CHAR(2),
  product_number CHAR(5),
  price DECIMAL(10, 2),
  description VARCHAR(255),
  image_url VARCHAR(255),
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create the table for registered users
CREATE TABLE users (
  user_id INT PRIMARY KEY IDENTITY,
  username VARCHAR(255),
  password VARCHAR(255),
  email VARCHAR(255),
  created_at DATETIME DEFAULT GETDATE()
);

-- Create the table for roles
CREATE TABLE roles (
  role_id INT PRIMARY KEY IDENTITY,
  role_name VARCHAR(255)
);

-- Create the table for user roles
CREATE TABLE user_roles (
  user_role_id INT PRIMARY KEY IDENTITY,
  user_id INT,
  role_id INT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- Create the table for claims
CREATE TABLE claims (
  claim_id INT PRIMARY KEY IDENTITY,
  claim_name VARCHAR(255)
);

-- Create the table for user claims
CREATE TABLE user_claims (
  user_claim_id INT PRIMARY KEY IDENTITY,
  user_id INT,
  claim_id INT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (claim_id) REFERENCES claims(claim_id)
);

-- Create the table for products in the cart
CREATE TABLE cart_items (
  cart_item_id INT PRIMARY KEY IDENTITY,
  user_id INT,
  product_id INT,
  quantity INT,
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create the table for orders
CREATE TABLE orders (
  order_id INT PRIMARY KEY IDENTITY,
  order_number CHAR(16),
  user_id INT,
  delivery_type INT,
  payment_status INT,
  status INT,
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create the table for order items
CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY IDENTITY,
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10, 2),
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create the table for payment methods
CREATE TABLE payment_methods (
  payment_method_id INT PRIMARY KEY IDENTITY,
  payment_method_name VARCHAR(255)
);

-- Create the table for payments
CREATE TABLE payments (
  payment_id INT PRIMARY KEY IDENTITY,
  order_id INT,
  payment_method_id INT,
  amount DECIMAL(10, 2),
  payment_date DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (payment_method_id) REFERENCES payment_methods(payment_method_id)
);

-- Create the table for delivery types
CREATE TABLE delivery_types (
  delivery_type_id INT PRIMARY KEY IDENTITY,
  delivery_type_name VARCHAR(255)
);

-- Create the table for replacements
CREATE TABLE replacements (
  replacement_id INT PRIMARY KEY IDENTITY,
  order_id INT,
  product_id INT,
  replacement_reason VARCHAR(255),
  replacement_date DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create the table for returns
CREATE TABLE tblreturns (
  return_id INT PRIMARY KEY IDENTITY,
  order_id INT,
  product_id INT,
  return_reason VARCHAR(255),
  return_date DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE feedbacks (
  feedback_id INT PRIMARY KEY identity,
  feedback_text VARCHAR(255),
  created_at datetime DEFAULT getdate(),
);
-- Create the table for feedback ratings
CREATE TABLE feedback_ratings (
  rating_id INT PRIMARY KEY IDENTITY,
  feedback_id INT,
  user_id INT,
  rating INT,
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (feedback_id) REFERENCES feedbacks(feedback_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create the table for image uploads
CREATE TABLE image_uploads (
  image_id INT PRIMARY KEY IDENTITY,
  product_id INT,
  image_url VARCHAR(255),
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create the table for warehouses
CREATE TABLE warehouses (
  warehouse_id INT PRIMARY KEY IDENTITY,
  warehouse_name VARCHAR(255),
  created_at DATETIME DEFAULT GETDATE()
);

-- Create the table for inventory
CREATE TABLE inventory (
  inventory_id INT PRIMARY KEY IDENTITY,
  product_id INT,
  warehouse_id INT,
  quantity INT,
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

-- Create the table for purchase orders
CREATE TABLE purchase_orders (
  purchase_order_id INT PRIMARY KEY IDENTITY,
  order_number CHAR(16),
  supplier_id INT,
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Create the table for purchase order items
CREATE TABLE purchase_order_items (
  purchase_order_item_id INT PRIMARY KEY IDENTITY,
  purchase_order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10, 2),
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(purchase_order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create the table for suppliers
CREATE TABLE suppliers (
  supplier_id INT PRIMARY KEY IDENTITY,
  supplier_name VARCHAR(255),
  created_at DATETIME DEFAULT GETDATE()
);

-- Create the table for supplier products
CREATE TABLE supplier_products (
  supplier_product_id INT PRIMARY KEY IDENTITY,
  supplier_id INT,
  product_id INT,
  price DECIMAL(10, 2),
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create the table for top selling products
CREATE TABLE top_selling_products (
  id INT PRIMARY KEY IDENTITY,
  product_id INT,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create the table for featured products
CREATE TABLE featured_products (
  featured_id INT PRIMARY KEY IDENTITY,
  product_id INT,
  created_at DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create the table for system settings
CREATE TABLE system_settings (
  setting_id INT PRIMARY KEY IDENTITY,
  setting_key VARCHAR(255),
  setting_value VARCHAR(255),
  created_at DATETIME DEFAULT GETDATE()
);

-- Create the table for coupons
CREATE TABLE coupons (
  coupon_id INT PRIMARY KEY IDENTITY,
  coupon_code VARCHAR(255),
  discount DECIMAL(10, 2),
  start_date DATE,
  end_date DATE
);

-- Create the table for coupon usage
CREATE TABLE coupon_usage (
  coupon_usage_id INT PRIMARY KEY IDENTITY,
  user_id INT,
  coupon_id INT,
  product_id INT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (coupon_id) REFERENCES coupons(coupon_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create the table for shipments
CREATE TABLE shipments (
  shipment_id INT PRIMARY KEY IDENTITY,
  order_id INT,
  warehouse_id INT,
  shipment_date DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);
