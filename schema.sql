-- Criando as tabelas do banco de dados e inserindo dados de exemplo para análise de receita total gerada por pedidos.
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);
SELECT * FROM customers;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
SELECT * FROM products;

CREATE TABLE orders (
  order_id INT IDENTITY(1,1) PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
SELECT * FROM orders;


CREATE TABLE order_items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
SELECT * FROM order_items;
------------------------------------------------------------------------------------------------------------------------------

-- Inserir dados de exemplo nas tabelas
INSERT INTO customers (customer_name, customer_email, country)
VALUES
('Ana Silva', 'ana@email.com', 'Brazil'),
('Carlos Lima', 'carlos@email.com', 'Brazil'),
('John Smith', 'john@email.com', 'USA'),
('Maria Garcia', 'maria@email.com', 'Spain');

INSERT INTO products VALUES
(1, 'Notebook', 'Electronics', 4500.00),
(2, 'Mouse', 'Electronics', 150.00),
(3, 'Cadeira Gamer', 'Furniture', 1200.00);
(4, 'Mesa de Escritório', 'Furniture', 800.00);

INSERT INTO orders VALUES
(12, '2024-01-10'),
(13, '2024-01-15'),
(14, '2024-02-05'),
(15, '2024-04-12');

INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(7, 1, 1),
(8, 2, 2),
(9, 3, 1),
(10, 2, 1);
------------------------------------------------------------------------------------------------------------------------------

-- Calcular a receita total gerada por todos os pedidos, multiplicando o preço de cada produto pela quantidade vendida e somando os resultados.
SELECT 
    SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;
------------------------------------------------------------------------------------------------------------------------------

-- Calcular a receita total gerada por mês, agrupando os resultados por ano e mês, e ordenando-os cronologicamente.
SELECT
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    year, month;
------------------------------------------------------------------------------------------------------------------------------

--Calcular a receita total gerada por cada cliente, agrupando os resultados por cliente e ordenando-os pela receita em ordem decrescente.
WITH customer_revenue AS (
    SELECT 
        c.customer_name,
        SUM(p.price * oi.quantity) AS revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY c.customer_name
)
SELECT *
FROM customer_revenue
ORDER BY revenue DESC;
------------------------------------------------------------------------------------------------------------------------------

-- Calcular o valor médio dos pedidos (ticket médio) para cada pedido, multiplicando o preço de cada produto pela quantidade vendida e dividindo pelo número total de pedidos.
SELECT 
    order_id,
    SUM(p.price * oi.quantity) AS order_value,
    AVG(SUM(p.price * oi.quantity)) OVER () AS avg_ticket
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY order_id;
------------------------------------------------------------------------------------------------------------------------------
