SELECT 'ФИО: Коссу Антуан';

--Запрос 1.1

SELECT * FROM public.ratings LIMIT 10 OFFSET 0;

--Запрос 1.2

SELECT * FROM public.links
WHERE
imdbid LIKE '%42'and movieid BETWEEN 100 AND 1000;

--Запрос 2

SELECT public.links.imdbid, public.ratings.rating
FROM public.links
INNER JOIN ratings ON public.links.movieid = public.ratings.movieid
WHERE public.ratings.rating = 5;

--Запрос 3.1

SELECT COUNT(public.links.movieid) as non_rated
FROM public.links
LEFT JOIN public.ratings
ON public.links.movieId = public.ratings.movieid
WHERE public.ratings.movieId IS NULL;

--Запрос 3.2

SELECT public.ratings.userId, AVG(rating) as avg_rating
FROM public.ratings
GROUP BY userId
HAVING AVG(rating)  > 3.5
ORDER BY avg_rating DESC 
LIMIT 10;

--Запрос 4.1

SELECT public.links.imdbid, public.links.movieid
FROM public.links
WHERE public.links.movieid in 
    (SELECT public.ratings.movieid 
        FROM public.ratings 
        GROUP BY public.ratings.movieid 
        HAVING AVG(rating) > 3.5 
        LIMIT 10);

--Запрос 4.2

WITH tmp_table
AS (
SELECT public.ratings.userId, COUNT(public.ratings.rating) as Activity
FROM public.ratings
GROUP BY public.ratings.userId
HAVING COUNT(rating) > 10
)
SELECT AVG(rating)
FROM public.ratings
LEFT JOIN tmp_table
ON tmp_table.userId = public.ratings.userId;
