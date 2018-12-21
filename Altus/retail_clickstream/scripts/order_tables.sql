create database if not exists retaildb location 'adl://azureeastus2data.azuredatalakestore.net/altus-retail-demo/db';

use retaildb;

drop table if exists products;
CREATE EXTERNAL TABLE products (product_id int, product_category_id int, product_name string, product_description string, product_price float, product_image string) 
stored as parquet LOCATION 'adl://azureeastus2data.azuredatalakestore.net/altus-retail-demo/data/warehouse/products';

drop table if exists order_items;
CREATE EXTERNAL TABLE order_items (order_item_id int, order_item_order_id int, order_item_product_id int,order_item_quantity int, order_item_subtotal float,order_item_product_price float)
 stored as parquet LOCATION 'adl://azureeastus2data.azuredatalakestore.net/altus-retail-demo/data/warehouse/order_items';

drop table if exists orders;
CREATE EXTERNAL TABLE orders (order_id int, order_date bigint, order_customer_id int, order_status string) stored as parquet LOCATION 'adl://azureeastus2data.azuredatalakestore.net/altus-retail-demo/data/warehouse/orders';

drop table if exists customers;
CREATE EXTERNAL TABLE customers (customer_id int, customer_fname string, customer_lname string, customer_email string, customer_password string, customer_street string, customer_city string, customer_state string, customer_zipcode string)
stored as parquet LOCATION 'adl://azureeastus2data.azuredatalakestore.net/altus-retail-demo/data/warehouse/customers';

drop table if exists categories;
CREATE EXTERNAL TABLE categories (category_id int, category_department_id int, category_name string) stored as parquet
LOCATION 'adl://azureeastus2data.azuredatalakestore.net/altus-retail-demo/data/warehouse/categories';

drop table if exists departments;
CREATE EXTERNAL TABLE departments (department_id int, department_name string) stored as parquet
LOCATION 'adl://azureeastus2data.azuredatalakestore.net/altus-retail-demo/data/warehouse/departments';
