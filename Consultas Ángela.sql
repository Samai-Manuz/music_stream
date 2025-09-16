USE `music stream`;

SELECT *
FROM `last_fm`;

SELECT *
FROM `spotipy`;


-- CONSULTA PARA COMPROBAR SI TODO ESTÁ EN ORDEN --
use `music stream`;
select genre as Género, count(distinct artist) as Artistas_diferentes
from spotipy
group by genre
having count(distinct artist)
union
select genre as Género, count(distinct artist) as Artistas_diferentes
from last_fm
group by genre
having count(distinct artist);




-- CONSULTAS -- 
 
-- 1. ¿Cuáles son los artistas con biografía más extensa? - Last fm
-- 2. ¿Cuál es el álbum más reciente lanzado? - Spotipy
-- 3. ¿Qué artista ha lanzado más álbumes? - Spotipy
-- 4. Selecciona el nombre y el año de lanzamiento de los álbumes en cada año elegido – Spotipy

--  MOSTRAR LAS TABLAS --
SELECT *
FROM `last_fm`;

SELECT *
FROM `spotipy`;


-- 1. ¿Cuáles son los artistas con biografía más extensa? - Last fm 
SELECT artist AS artista, LENGTH(bio) AS biografía_más_extensa
FROM last_fm
ORDER BY biografía_más_extensa DESC;



-- 2. ¿Cuál es el álbum más reciente lanzado? - Spotipy 
SELECT album, release_year AS año_de_lanzamiento, artist AS artista
FROM spotipy
ORDER BY año_de_lanzamiento DESC
LIMIT 1;


-- 3. ¿Qué artista ha lanzado más álbumes? - Spotipy
SELECT artist AS artista, COUNT(DISTINCT album) AS albumes_totales
FROM spotipy
GROUP BY artist
ORDER BY albumes_totales DESC
LIMIT 1;


-- 4. Selecciona el nombre y el año de lanzamiento de los álbumes en cada año elegido – Spotipy ( ES decir, elige un año y muestrame el nombre y albumes)
SELECT album, release_year AS año_de_lanzamiento
FROM spotipy
WHERE release_year = 2021;



-- CONSULTAS NUEVAS --
-- 5. Número de álbumes por artista y año de lanzamiento --
SELECT COUNT(DISTINCT album) AS albumes_totales, s.artist AS artista, s.release_year AS año_de_lanzamiento
FROM spotipy s
INNER JOIN last_fm l
ON s.artist = l.artist
GROUP BY s.artist, s.release_year
ORDER BY año_de_lanzamiento DESC, albumes_totales DESC;



-- 6.  Artistas con más álbumes pero menos oyentes
SELECT  s.artist AS artista, COUNT(DISTINCT s.album) AS total_albumes, l.playcount AS total_escuchas
FROM spotipy s
INNER JOIN last_fm l 
ON s.artist = l.artist
ORDER BY total_albumes DESC, total_escuchas ASC;










 
