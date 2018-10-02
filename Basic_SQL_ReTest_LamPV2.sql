CREATE DATABASE Basic_SQL_ReTest_LamPV2
GO

USE Basic_SQL_ReTest_LamPV2
GO

CREATE TABLE actor
(
	actor_id INT PRIMARY KEY IDENTITY,
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	last_update DATE DEFAULT GETDATE(),
)

CREATE TABLE category
(
	category_id INT PRIMARY KEY IDENTITY,
	name NVARCHAR(50) NOT NULL UNIQUE,
	last_update DATE DEFAULT GETDATE()
)

CREATE TABLE film
(
	film_id INT PRIMARY KEY IDENTITY,
	title NVARCHAR(50) NOT NULL UNIQUE,
	description_ NVARCHAR(50),
	release_year DATE DEFAULT GETDATE(),
	leng_ INT,
	rating INT,
	special_features NVARCHAR(50),
	last_update DATE DEFAULT GETDATE()
)

CREATE TABLE film_category
(
	film_id INT FOREIGN KEY(film_id) REFERENCES film(film_id),
	category_id INT FOREIGN KEY(category_id) REFERENCES category(category_id),
	last_update DATE DEFAULT GETDATE(),
	PRIMARY KEY(film_id, category_id)
)

CREATE TABLE film_actor
(
	actor_id INT FOREIGN KEY(actor_id) REFERENCES actor(actor_id),
	film_id INT FOREIGN KEY(film_id) REFERENCES film(film_id),
	last_update DATE DEFAULT GETDATE(),
	PRIMARY KEY(actor_id, film_id)
)

INSERT INTO film(title) VALUES(N'Lady Bird')
INSERT INTO film(title) VALUES(N'Get Out')
INSERT INTO film(title) VALUES(N'Coco')
INSERT INTO film(title) VALUES(N'Wonder Woman')

INSERT INTO category(name) VALUES(N'Animation')
INSERT INTO category(name) VALUES(N'Comedy')
INSERT INTO category(name) VALUES(N'Drama')
INSERT INTO category(name) VALUES(N'Kids')

INSERT INTO actor(first_name, last_name) VALUES('Angelina', 'Jolie')
INSERT INTO actor(first_name, last_name) VALUES('Jennifer', 'Lawrence')
INSERT INTO actor(first_name, last_name) VALUES('Alain', 'Delon')
INSERT INTO actor(first_name, last_name) VALUES('Megan', 'Fox')

INSERT INTO film_actor(actor_id, film_id) VALUES(1, 3)
INSERT INTO film_actor(actor_id, film_id) VALUES(2, 3)
INSERT INTO film_actor(actor_id, film_id) VALUES(4, 3)
INSERT INTO film_actor(actor_id, film_id) VALUES(1, 1)
INSERT INTO film_actor(actor_id, film_id) VALUES(3, 2)

INSERT INTO film_category(film_id, category_id) VALUES(1, 1)
INSERT INTO film_category(film_id, category_id) VALUES(1, 2)
INSERT INTO film_category(film_id, category_id) VALUES(3, 3)
INSERT INTO film_category(film_id, category_id) VALUES(4, 2)
INSERT INTO film_category(film_id, category_id) VALUES(2, 2)

--2.Write an query list all actor first name and last name acting in the film title. 
--Example, input film title ‘Coco’ return list actors ‘Angelina Jolie’, ‘Jennifer Lawrence’, ‘Megan Fox’ 
--Nhập tiêu đề phim in ra diễn viên phim đó
SELECT CONCAT(actor.first_name,' ' ,actor.last_name) 
FROM film INNER JOIN film_actor
ON film.film_id = film_actor.film_id INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE film.title = 'Coco'


--3.Write:  
-- A query which given a category name parameter that returns total film for a specific 
--category name. Example input category name ‘Comedy’ return 3 films. 
--Nhập vào loại phim và in ra số phim của loại đó
SELECT film.title 
FROM film INNER JOIN film_category
ON film.film_id = film_category.film_id INNER JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy'

--4.Add constraint for Rating field is not a number in range [1-5] or Length field is negative number. 
-- Thay đổi dữ liệu cho rating từ 1-5 và leng không âm
ALTER TABLE film ADD CONSTRAINT rating CHECK(rating >= 1 AND rating <= 5)
ALTER TABLE film ADD CONSTRAINT leng_ CHECK(leng_ > 0)

--5.Write an query find films with the most actors.
--Tìm phim nhiều diễn viên nhất
SELECT * FROM film
WHERE film.film_id = (
SELECT TOP 1 WITH TIES film_actor.film_id FROM film_actor
GROUP BY film_actor.film_id
ORDER BY COUNT(film_actor.actor_id) DESC)