CREATE TABLE
films 	(
	title VARCHAR(50),
	id SERIAL PRIMARY KEY,
	country VARCHAR(25),
	box_office INT,
	release_date TIMESTAMP
	);

INSERT INTO films
	VALUES ('Маленькие секреты', 1, 'Франция',48531470, '2010-09-11'::timestamp),
		('Малышка на миллион', 2, 'США', 216763646, '2004-12-05'::timestamp),
		('Мосты округа Мэдисон', 3, 'США', 182016617, '1994-06-02'::timestamp),
		('Хороший, плохой, злой', 4, 'Италия-Испания-Германия', 25100000, '1966-12-23'::timestamp),
		('Жизнь прекрасна', 5, 'Италия', 229163264, '1997-12-20'::timestamp);

CREATE TABLE
persons (
	id INT PRIMARY KEY,
	fio VARCHAR(50)
	);

INSERT INTO persons
	VALUES (10, 'Гийом Кане'),
		(11,'Хилари Суэнк'),	
		(12,'Мэрил Стрип'),
		(13,'Клинт Иствуд'),
		(14,'Роберто Бениньи');
    
CREATE TABLE
persons2content (
		person_id INT REFERENCES persons(id),
		film_id INT REFERENCES films(id),
		person_type VARCHAR(25)
		);

INSERT INTO persons2content
	VALUES (10,1,'режиссер'),
		(11,2,'актриса'),
		(12,3,'режиссер'),
		(13,4,'актер'),
		(14,1,'режиссер');
