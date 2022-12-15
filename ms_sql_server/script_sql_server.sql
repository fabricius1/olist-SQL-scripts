USE master
GO

DROP DATABASE IF EXISTS olistdb
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'olistdb')
BEGIN
    CREATE DATABASE olistdb
END
GO

USE olistdb
GO

CREATE SCHEMA olist
GO

IF EXISTS(SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'geolocation')  
    DROP TABLE [olist].[geolocation];  
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'geolocation')
    CREATE TABLE [olist].[geolocation] (
        geolocation_zip_code_prefix INT
        ,geolocation_lat FLOAT
        ,geolocation_lng FLOAT
        ,geolocation_city NVARCHAR (50)
        ,geolocation_state CHAR(2)
    )
GO

BULK INSERT [olist].[geolocation]
FROM 'D:\myCourses\stack_academy\azure_engenheiro_de_dados\database_olist\geolocation.csv'
WITH (
FORMAT = 'CSV'
    ,FIRSTROW = 2
    ,FIELDQUOTE = '"'
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR = '0x0a'
    )
GO

IF EXISTS(SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'sellers')  
    DROP TABLE [olist].[sellers];  
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'sellers')
    CREATE TABLE [olist].[sellers] (
        seller_id CHAR(32) NOT NULL
        ,seller_zip_code_prefix INT NOT NULL 
        ,seller_city VARCHAR(50) NOT NULL
        ,seller_state CHAR(2) NOT NULL
        ,CONSTRAINT pk_olist_seller_id PRIMARY KEY (seller_id)
        ,
    )
GO

BULK INSERT [olist].[sellers]
FROM 'D:\myCourses\stack_academy\azure_engenheiro_de_dados\database_olist\sellers.csv'
WITH (
    FORMAT = 'CSV'
    ,FIRSTROW = 2
    ,FIELDQUOTE = '"'
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR = '0x0a'
)
GO

IF EXISTS(SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'products')  
    DROP TABLE [olist].[products];  
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'products')
    CREATE TABLE [olist].[products] (
        product_id CHAR(32) NOT NULL
        ,product_category_name VARCHAR(50) NOT NULL 
        ,product_name_length SMALLINT
        ,product_description_length INT
        ,product_phots_qty SMALLINT
        ,product_weight_g INT
        ,product_length_cm SMALLINT
        ,product_height_cm SMALLINT
        ,product_width_cm SMALLINT
        ,CONSTRAINT pk_olist_product_id PRIMARY KEY (product_id)
    )
GO

BULK INSERT [olist].[products]
FROM 'D:\myCourses\stack_academy\azure_engenheiro_de_dados\database_olist\products.csv'
WITH (
FORMAT = 'CSV'
    ,FIRSTROW = 2
    ,FIELDQUOTE = '"'
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR = '0x0a'
    )
GO

IF EXISTS(SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'customers')  
    DROP TABLE [olist].[customers];  
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'customers')
    CREATE TABLE [olist].[customers] (
        customer_id CHAR(32) NOT NULL
        ,customer_unique_id CHAR(32) NOT NULL
        ,customer_zip_code_prefix INT NOT NULL
        ,customer_city VARCHAR(40) NOT NULL
        ,customer_state CHAR(2) NOT NULL
        ,CONSTRAINT pk_olist_customer_id PRIMARY KEY (customer_id)
    )
GO

BULK INSERT [olist].[customers]
FROM 'D:\myCourses\stack_academy\azure_engenheiro_de_dados\database_olist\customers.csv'
WITH (
    FORMAT = 'CSV'
    ,FIRSTROW = 2
    ,FIELDQUOTE = '"'
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR = '0x0a'
)
GO

IF EXISTS(SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'orders')  
    DROP TABLE [olist].[orders];  
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'orders')
    CREATE TABLE [olist].[orders] (
        order_id CHAR(32) NOT NULL
        ,customer_id CHAR(32) NOT NULL
        ,order_status VARCHAR(15) NOT NULL
        ,order_purchase_timestamp DATETIME NOT NULL
        ,order_approved_at DATETIME
        ,order_delivered_carrier_date DATETIME
        ,order_delivered_customer_date DATETIME
        ,order_estimated_delivery_date DATETIME
        ,CONSTRAINT pk_olist_order_id PRIMARY KEY (order_id)
        ,CONSTRAINT fk_olist_customer_id FOREIGN KEY (customer_id)
        REFERENCES olist.customers (customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    )
GO

BULK INSERT [olist].[orders]
FROM 'D:\myCourses\stack_academy\azure_engenheiro_de_dados\database_olist\orders.csv'
WITH (
    FORMAT = 'CSV'
    ,FIRSTROW = 2
    ,FIELDQUOTE = '"'
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR = '0x0a'
)
GO

IF EXISTS(SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'order_items')  
    DROP TABLE [olist].[order_items];  
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'order_items')
    CREATE TABLE [olist].[order_items] (
        order_id CHAR(32) NOT NULL,
        order_item_id CHAR(32) NOT NULL,
        product_id CHAR(32) NOT NULL,
        seller_id CHAR(32) NOT NULL,
        shipping_limit_date DATETIME NOT NULL,
        price FLOAT NOT NULL,
        freight_value FLOAT NOT NULL
        ,CONSTRAINT pk_olist_order_item_id PRIMARY KEY (order_id, order_item_id)

        ,CONSTRAINT fk_olist_product_id FOREIGN KEY (product_id)
        REFERENCES olist.products (product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE

        ,CONSTRAINT fk_olist_seller_id FOREIGN KEY (seller_id)
        REFERENCES olist.sellers (seller_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    )
GO

BULK INSERT [olist].[order_items]
FROM 'D:\myCourses\stack_academy\azure_engenheiro_de_dados\database_olist\order_items.csv'
WITH (
    FORMAT = 'CSV'
    ,FIRSTROW = 2
    ,FIELDQUOTE = '"'
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR = '0x0a'
)
GO

IF EXISTS(SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'order_payments')  
    DROP TABLE [olist].[order_payments]; 
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'order_payments')
    CREATE TABLE [olist].[order_payments] (
        order_id CHAR(32) NOT NULL 
        ,payment_sequential INT NOT NULL 
        ,payment_type VARCHAR(50) NOT NULL 
        ,payment_installments INT NOT NULL 
        ,payment_value FLOAT NOT NULL
        ,CONSTRAINT pk_olist_order_payment_id PRIMARY KEY (order_id, payment_sequential)
    )
GO

BULK INSERT [olist].[order_payments]
FROM 'D:\myCourses\stack_academy\azure_engenheiro_de_dados\database_olist\order_payments.csv'
WITH (
    FORMAT = 'CSV'
    ,FIRSTROW = 2
    ,FIELDQUOTE = '"'
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR = '0x0a'
)
GO

IF EXISTS(SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'order_reviews')  
    DROP TABLE [olist].[order_reviews];  
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'order_reviews')
    CREATE TABLE [olist].[order_reviews] (
        review_id CHAR(32) NOT NULL
        ,order_id CHAR(32) NOT NULL 
        ,review_score INT  
        ,review_comment_title VARCHAR(100)  
        ,review_comment_message VARCHAR(1000)  
        ,review_creation_date DATE  
        ,review_answer_timestamp DATETIME 
        ,CONSTRAINT pk_olist_review_id PRIMARY KEY (review_id, order_id)
    )
GO

BULK INSERT [olist].[order_reviews]
FROM 'D:\myCourses\stack_academy\azure_engenheiro_de_dados\database_olist\order_reviews.csv'
WITH (
    FORMAT = 'CSV'
    ,FIRSTROW = 2
    ,FIELDQUOTE = '"'
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR = '\n'
)
GO

IF EXISTS(SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'product_category_name_translation')  
    DROP TABLE [olist].[product_category_name_translation];  
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE SCHEMA_NAME(schema_id) LIKE 'olist' AND name like 'product_category_name_translation')
    CREATE TABLE [olist].[product_category_name_translation] (
        product_category_name VARCHAR(50),
        product_category_name_english VARCHAR(70)
    )
GO

BULK INSERT [olist].[product_category_name_translation]
FROM 'D:\myCourses\stack_academy\azure_engenheiro_de_dados\database_olist\product_category_name_translation.csv'
WITH (
    FORMAT = 'CSV'
    ,FIRSTROW = 2
    ,FIELDQUOTE = '"'
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR = '\n'
)
GO
