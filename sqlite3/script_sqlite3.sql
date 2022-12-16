DROP TABLE IF EXISTS geolocation;  

CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city NVARCHAR (50),
    geolocation_state CHAR(2)
);

DROP TABLE IF EXISTS sellers;  

CREATE TABLE sellers (
    seller_id CHAR(32) NOT NULL PRIMARY KEY,
    seller_zip_code_prefix INT NOT NULL,
    seller_city VARCHAR(50) NOT NULL,
    seller_state CHAR(2) NOT NULL
);

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id CHAR(32) NOT NULL PRIMARY KEY,
    product_category_name VARCHAR(50) NOT NULL,
    product_name_length SMALLINT,
    product_description_length INT,
    product_phots_qty SMALLINT,
    product_weight_g INT,
    product_length_cm SMALLINT,
    product_height_cm SMALLINT,
    product_width_cm SMALLINT
);

DROP TABLE IF EXISTS customers;  

CREATE TABLE customers (
    customer_id CHAR(32) NOT NULL PRIMARY KEY,
    customer_unique_id CHAR(32) NOT NULL,
    customer_zip_code_prefix INT NOT NULL,
    customer_city VARCHAR(40) NOT NULL,
    customer_state CHAR(2) NOT NULL
);

DROP TABLE IF EXISTS orders;  

CREATE TABLE orders (
    order_id CHAR(32) NOT NULL PRIMARY KEY,
    customer_id CHAR(32) NOT NULL,
    order_status VARCHAR(15) NOT NULL,
    order_purchase_timestamp DATETIME NOT NULL,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS order_items;  

CREATE TABLE order_items (
    order_id CHAR(32) NOT NULL,
    order_item_id CHAR(32) NOT NULL,
    product_id CHAR(32) NOT NULL,
    seller_id CHAR(32) NOT NULL,
    shipping_limit_date DATETIME NOT NULL,
    price FLOAT NOT NULL,
    freight_value FLOAT NOT NULL,
    PRIMARY KEY(order_id, order_item_id),

    CONSTRAINT fk_product_id FOREIGN KEY (product_id)
    REFERENCES products(product_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fk_seller_id FOREIGN KEY (seller_id)
    REFERENCES sellers(seller_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS order_payments; 

CREATE TABLE order_payments (
    order_id CHAR(32) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(50) NOT NULL,
    payment_installments INT NOT NULL,
    payment_value FLOAT NOT NULL,
    PRIMARY KEY (order_id, payment_sequential)
);

DROP TABLE IF EXISTS order_reviews;  

CREATE TABLE order_reviews (
    review_id CHAR(32) NOT NULL,
    order_id CHAR(32) NOT NULL,
    review_score INT,
    review_comment_title VARCHAR(100),
    review_comment_message VARCHAR(1000),
    review_creation_date DATE,
    review_answer_timestamp DATETIME,
    PRIMARY KEY (review_id, order_id)
);

DROP TABLE IF EXISTS product_category_name_translation;  

CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(50),
    product_category_name_english VARCHAR(70)
);