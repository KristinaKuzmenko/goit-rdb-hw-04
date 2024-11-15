CREATE SCHEMA LibraryManagement;

USE LibraryManagement;

CREATE TABLE authors(
author_id INT AUTO_INCREMENT PRIMARY KEY,
author_name VARCHAR(255));

CREATE TABLE genres(
genre_id INT AUTO_INCREMENT PRIMARY KEY,
genre_name VARCHAR(50));

CREATE TABLE books(
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255),
publication_year YEAR,
author_id INT,
FOREIGN KEY (author_id) REFERENCES authors(author_id),
genre_id INT,
FOREIGN KEY (genre_id) REFERENCES genres(genre_id));

CREATE TABLE users(
user_id INT AUTO_INCREMENT PRIMARY KEY,
user_name VARCHAR(255),
email VARCHAR(100));

CREATE TABLE borrowed_books(
borrow_id INT AUTO_INCREMENT PRIMARY KEY,
book_id INT,
FOREIGN KEY (book_id) REFERENCES books(book_id),
user_id INT,
FOREIGN KEY (user_id) REFERENCES users(user_id),
borrow_date DATE,
return_date DATE);


INSERT INTO authors (author_name)
VALUES ('J.K. Rowling'),
	   ('Agatha Christie'), 
	   ('George Orwell');
       
INSERT INTO genres (genre_name)
VALUES ('Fantasy'),
       ('Dystopian'),
       ('Adventure'),
	   ('Crime Fiction');
       
INSERT INTO books (title, publication_year, author_id, genre_id)
VALUES ('Harry Potter and the Philosopher''s Stone', 1997, 1, 1),
       ('Murder on the Orient Express', 1934, 2, 4),
       ('1984', 1949, 3, 2);
       
INSERT INTO users (user_name, email)
VALUES ('Johnny Depp', 'jacksparrow@gamil.com'),
       ('Keanu Reeves', 'neo2024@ukr.net'),
       ('Brad Pitt', 'mrSmith@icloude.com');
       
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date)
VALUES (1, 3, '2024-03-10', '2024-07-01'),
       (1, 1, '2024-08-23', '2024-10-15'),
       (3, 2, '2024-01-29', '2024-10-31');
       


USE mydb;

SELECT * FROM orders o
INNER JOIN employees e ON(o.employee_id = e.employee_id)
INNER JOIN customers c ON (o.customer_id = c.id)
INNER JOIN shippers sh ON (o.shipper_id = sh.id)
INNER JOIN order_details od ON (o.id = od.order_id)
INNER JOIN products p ON (od.product_id = p.id)
INNER JOIN suppliers sp ON (p.supplier_id = sp.id)
INNER JOIN categories cat ON (p.category_id = cat.id);

SELECT COUNT(*) FROM orders o
RIGHT JOIN employees e ON(o.employee_id = e.employee_id)
RIGHT JOIN customers c ON (o.customer_id = c.id)
RIGHT JOIN shippers sh ON (o.shipper_id = sh.id)
RIGHT JOIN order_details od ON (o.id = od.order_id)
RIGHT JOIN products p ON (od.product_id = p.id)
RIGHT JOIN suppliers sp ON (p.supplier_id = sp.id)
RIGHT JOIN categories cat ON (p.category_id = cat.id);

SELECT COUNT(*) FROM orders o
LEFT JOIN employees e ON(o.employee_id = e.employee_id)
LEFT JOIN customers c ON (o.customer_id = c.id)
LEFT JOIN shippers sh ON (o.shipper_id = sh.id)
LEFT JOIN order_details od ON (o.id = od.order_id)
LEFT JOIN products p ON (od.product_id = p.id)
LEFT JOIN suppliers sp ON (p.supplier_id = sp.id)
LEFT JOIN categories cat ON (p.category_id = cat.id);

-- При зміні INNER JOIN на LEFT JOIN чи RIGHT JOIN кількість рядків не змінюється, що означає: 
-- в таблицях всі рядки задовольняють умовам, тобто відсутні робітники без замовлень, клієнти без замовлень, постачальники, що не мають замовлень, 
-- продукти чи категорії продуктів, для яких не існує замовлень, а також всі замовлення мають повну інформацію по заданим атрибутам (відсутні null)

SELECT * FROM orders o
INNER JOIN employees e ON(o.employee_id = e.employee_id)
INNER JOIN customers c ON (o.customer_id = c.id)
INNER JOIN shippers sh ON (o.shipper_id = sh.id)
INNER JOIN order_details od ON (o.id = od.order_id)
INNER JOIN products p ON (od.product_id = p.id)
INNER JOIN suppliers sp ON (p.supplier_id = sp.id)
INNER JOIN categories cat ON (p.category_id = cat.id)
WHERE e.employee_id BETWEEN 3 AND 10;

SELECT cat.name, COUNT(*), AVG(od.quantity) FROM orders o
INNER JOIN employees e ON(o.employee_id = e.employee_id)
INNER JOIN customers c ON (o.customer_id = c.id)
INNER JOIN shippers sh ON (o.shipper_id = sh.id)
INNER JOIN order_details od ON (o.id = od.order_id)
INNER JOIN products p ON (od.product_id = p.id)
INNER JOIN suppliers sp ON (p.supplier_id = sp.id)
INNER JOIN categories cat ON (p.category_id = cat.id)
WHERE e.employee_id BETWEEN 3 AND 10
GROUP BY cat.name;

SELECT cat.name, COUNT(*), AVG(od.quantity) FROM orders o
INNER JOIN employees e ON(o.employee_id = e.employee_id)
INNER JOIN customers c ON (o.customer_id = c.id)
INNER JOIN shippers sh ON (o.shipper_id = sh.id)
INNER JOIN order_details od ON (o.id = od.order_id)
INNER JOIN products p ON (od.product_id = p.id)
INNER JOIN suppliers sp ON (p.supplier_id = sp.id)
INNER JOIN categories cat ON (p.category_id = cat.id)
WHERE e.employee_id BETWEEN 3 AND 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21;

SELECT cat.name, COUNT(*), AVG(od.quantity) FROM orders o
INNER JOIN employees e ON(o.employee_id = e.employee_id)
INNER JOIN customers c ON (o.customer_id = c.id)
INNER JOIN shippers sh ON (o.shipper_id = sh.id)
INNER JOIN order_details od ON (o.id = od.order_id)
INNER JOIN products p ON (od.product_id = p.id)
INNER JOIN suppliers sp ON (p.supplier_id = sp.id)
INNER JOIN categories cat ON (p.category_id = cat.id)
WHERE e.employee_id BETWEEN 3 AND 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY COUNT(*) DESC;

SELECT cat.name, COUNT(*), AVG(od.quantity) FROM orders o
INNER JOIN employees e ON(o.employee_id = e.employee_id)
INNER JOIN customers c ON (o.customer_id = c.id)
INNER JOIN shippers sh ON (o.shipper_id = sh.id)
INNER JOIN order_details od ON (o.id = od.order_id)
INNER JOIN products p ON (od.product_id = p.id)
INNER JOIN suppliers sp ON (p.supplier_id = sp.id)
INNER JOIN categories cat ON (p.category_id = cat.id)
WHERE e.employee_id BETWEEN 3 AND 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY COUNT(*) DESC
LIMIT 4 OFFSET 1;
