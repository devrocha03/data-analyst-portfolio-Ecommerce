-- Inserindo Dados 

INSERT INTO customers VALUES
(1, 'Ana Silva', 'ana@email.com', 'Brazil'),
(2, 'Carlos Lima', 'carlos@email.com', 'Brazil'),
(3, 'John Smith', 'john@email.com', 'USA');

INSERT INTO products VALUES
(1, 'Notebook', 'Electronics', 4500.00),
(2, 'Mouse', 'Electronics', 150.00),
(3, 'Cadeira Gamer', 'Furniture', 1200.00);

INSERT INTO orders VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-01-15'),
(3, 1, '2024-02-05');

INSERT INTO order_items VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 3, 2, 1);
