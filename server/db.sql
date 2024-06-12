CREATE DATABASE IF NOT EXISTS sales_db;
USE sales_db;

CREATE TABLE IF NOT EXISTS items (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE IF NOT EXISTS transactions (
    id VARCHAR(255) PRIMARY KEY,
    itemId VARCHAR(255),
    quantity INT NOT NULL,
    transactionDate DATETIME NOT NULL,
    FOREIGN KEY (itemId) REFERENCES items(id)
);

INSERT INTO items (id, name, type, stock) VALUES
('1', 'Kopi', 'Konsumsi', 100),
('2', 'Teh', 'Konsumsi', 100),
('3', 'Pasta Gigi', 'Pembersih', 100),
('4', 'Sabun Mandi', 'Pembersih', 100),
('5', 'Sampo', 'Pembersih', 100);

INSERT INTO transactions (id, itemId, quantity, transactionDate) VALUES
('1', '1', 10, '2021-05-01 00:00:00'),
('2', '2', 19, '2021-05-05 00:00:00'),
('3', '1', 15, '2021-05-10 00:00:00'),
('4', '3', 20, '2021-05-11 00:00:00'),
('5', '4', 30, '2021-05-11 00:00:00'),
('6', '5', 25, '2021-05-12 00:00:00'),
('7', '2', 5, '2021-05-12 00:00:00');
