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

SELECT genre as Género, SUM(listeners) as Oyentes_únicos 
FROM last_fm 
GROUP BY genre
order by Oyentes_únicos;

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

-- Samai: necesitamos el dato máximo de popularidad por artista, así que meto distinct, max, agrupo y amplío el límite a top 5:
SELECT distinct artist, max(popularity)
FROM spotipy
group by artist
ORDER BY popularity DESC
LIMIT 5;

-- Samai: Ahora Linkin Park no aparece porque puede estar agrupado con otros artistas, así que le meto una normalización:
-- También veo que lo suyo es hacer una media de la popularidad de todas las canciones de cada artista, porque dar el dato de popularidad de una sóla canción (por mucho que sea la más popular) es sesgar el resultado
-- También le meto el género, que siempre nos interesa para nuestras pesquisas
SELECT
  genre     AS Género,
  artist    AS Artista,
  ROUND(AVG(pop), 2) AS Popularidad
FROM (
  SELECT
    genre,
    TRIM(LOWER(SUBSTRING_INDEX(artist, ',', 1))) AS artist,
    CAST(popularity AS UNSIGNED)                 AS pop
  FROM spotipy
) t
GROUP BY genre, artist
ORDER BY Popularidad DESC
LIMIT 5;

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

-- Samai: meto género y agrupo

SELECT 
    genre AS Género,
    artist AS Artista,
    ROUND(AVG(popularity)) AS Popularidad_media
FROM spotipy
GROUP BY artist
ORDER BY Popularidad_media DESC
LIMIT 5;

SELECT 
    artist AS Artista,
    MIN(genre) AS Género,                     -- toma un género representativo
    ROUND(AVG(popularity), 2) AS Popularidad_media
FROM spotipy
GROUP BY artist
ORDER BY Popularidad_media DESC
LIMIT 5;last_fm


-- Álbum con más canciones registradas en la tabla -- Spotipy
SELECT album, artist, COUNT(track) AS total_canciones
FROM spotipy
GROUP BY album, artist
ORDER BY total_canciones DESC
LIMIT 1;












