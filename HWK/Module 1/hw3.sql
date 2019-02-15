--Оконные функции
SELECT 
userId, 
movieId,
rating-MIN(rating) over (PARTITION BY userId) / (MAX(rating) over (PARTITION BY userId) - MIN(rating) over (PARTITION BY userId)) as normed_rating,
AVG(rating) over (PARTITION BY userId) as avg_rating
FROM
(
SELECT
        userId, movieId, rating
    FROM ratings
    LIMIT 1000
) as sample
LIMIT 30;

--"ВАША КОМАНДА СОЗДАНИЯ ТАБЛИЦЫ"

psql -c '
CREATE TABLE IF NOT EXISTS keywords_bis(Id bigint, tags text);'
--"ВАША КОМАНДА ЗАЛИВКИ ДАННЫХ"
psql -c "\\copy keywords_bis FROM '/usr/local/share/netology/raw_data/keywords.csv' DELIMITER ','CSV HEADER";


-- ЗАПРОС 1

SELECT 
ratings.movieId, 
AVG(rating) as avg_rating
FROM
ratings
GROUP BY ratings.movieId
HAVING COUNT (userId) > 50
ORDER BY avg_rating DESC, movieId ASC
LIMIT 150;

-- ЗАПРОС 1 + ЗАПРОС 2

WITH top_rated as
	(
	SELECT 
	ratings.movieId, 
	AVG(rating) as avg_rating
	FROM
	ratings
	GROUP BY ratings.movieId
	HAVING COUNT (userId) > 50 -- CHECK
	ORDER BY avg_rating DESC, movieId ASC
	LIMIT 150
	)
SELECT
top_rated.movieId,
avg_rating,
tags
FROM
top_rated
LEFT JOIN keywords_bis
ON top_rated.movieId = keywords_bis.Id LIMIT 150;

-- ЗАПРОС 3

WITH top_rated as
	(
	SELECT 
	ratings.movieId, 
	AVG(rating) as avg_rating
	FROM
	ratings
	GROUP BY ratings.movieId
	HAVING COUNT (userId) > 50 -- CHECK
	ORDER BY avg_rating DESC, movieId ASC
	LIMIT 150
	)
SELECT
top_rated.movieId,
avg_rating,
tags 
INTO top_rated_tags
FROM
top_rated
LEFT JOIN keywords_bis
ON top_rated.movieId = keywords_bis.Id LIMIT 150;

-- Выгрузка таблицы в файл

\copy (SELECT * FROM top_rated_tags) TO '/usr/local/share/netology/raw_data/top_rated_tags.text' WITH DELIMITER E'\t';
