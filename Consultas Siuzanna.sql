SELECT * FROM `music stream`.spotipy;

select genre as Género, count(distinct artist) as Artistas_diferentes
from spotipy
group by genre
having count(distinct artist)
union
select genre as Género, count(distinct artist) as Artistas_diferentes
from last_fm
group by genre
having count(distinct artist);


USE `music stream`;

SELECT *
FROM last_fm;

select *
from spotipy;


-- Número de oyentes por género - Last fm --

SELECT genre, SUM(listeners) 
FROM last_fm 
GROUP BY genre;

-- Artistas similares con más seguidores - Last fm --

SELECT similars, 
       MAX(CAST(listeners AS UNSIGNED)) AS max_oyentes
FROM last_fm
GROUP BY similars
ORDER BY max_oyentes DESC
LIMIT 1;

-- Artistas con más popularidad - Spotipy --

SELECT artist, popularity
FROM spotipy
ORDER BY popularity DESC
LIMIT 1;

-- ¿Qué artista tiene más oyentes? - Last fm --
SELECT artist, 
       CAST(listeners AS UNSIGNED) AS oyentes
FROM last_fm
ORDER BY oyentes DESC
LIMIT 1;

-- Qué género tiene la mayor coincidencia de artistas entre Spotipy y Last fm? -

SELECT l.genre, COUNT(*) AS total_artistas
FROM last_fm l
JOIN spotipy s ON l.artist = s.artist
GROUP BY l.genre
ORDER BY total_artistas DESC
LIMIT 1;



-- Artista con el mayor número de canciones en la base de datos
SELECT artist, COUNT(*) AS total_canciones
FROM spotipy
GROUP BY artist
ORDER BY total_canciones DESC
LIMIT 1;

select*
from spotipy
WHERE artist LIKE '%The Black Keys%'

-- Top 5 artistas más populares en promedio- Spotipy

SELECT artist, AVG(popularity) AS popularidad_media
FROM spotipy
GROUP BY artist
ORDER BY popularidad_media DESC
LIMIT 5;

-- Álbum con más canciones registradas en la tabla -- Spotipy
SELECT album, artist, COUNT(track) AS total_canciones
FROM spotipy
GROUP BY album, artist
ORDER BY total_canciones DESC
LIMIT 1;












