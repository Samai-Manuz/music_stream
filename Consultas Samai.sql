-- CONSULTAS SAMAI --

use `music stream`;
select * from spotipy;
select * from last_fm;

-- MODIFICO LAS COLUMNAS 'LISTENERS' Y 'PLAYCOUNT' (TABLA LAST_FM) PORQUE VIENEN EN FORMATO TEXTO Y LAS NECESITAMOS EN FORMATO NUMÉRICO --

ALTER TABLE last_fm
MODIFY playcount BIGINT;

ALTER TABLE last_fm
MODIFY listeners BIGINT;

ALTER TABLE spotipy
MODIFY release_year BIGINT;

-- 1. ¿Cuántas canciones hay por género? - Spotipy

select genre as Género, count(track) as Canciones
from spotipy
group by genre;

-- --> 1.1. Como es muy simple, porque ya sabemos que son 500 por género (lo extrajimos directamente así), lo voy a complicar un poco metiendo un filtro de las canciones más populares:
-- -------> Primero veo los distintos índices de popularidad de mayor calificación a menos, para que me ayude a establecer un rango de "las más populares":

select distinct popularity
from spotipy
order by popularity desc; 
-- -------> Como la máxima calificación es de 83, establezco el rango de "las más populares" a partir de 73

-- --> 1.2. Entonces ahora puedo replantear la pregunta cómo ¿cuántas canciones populares hay por género? 

SELECT genre as Genre, 
SUM(CASE WHEN popularity >= 73 THEN 1 ELSE 0 END) AS Total_Popular_Tracks /* meto un sum (case...) para que en el caso de que no cumpla, siga apareciendo el género con resultado a 0 */
FROM spotipy
GROUP BY genre
ORDER BY Total_Popular_Tracks DESC;

/* Respuesta: 
metal - 14 
blues - 1
jazz - 1
rap - 0
*/

-- 2. ¿Cuál es el género con más canciones? - Spotipy >>> Como estamos en las mismas que en la pregunta 1, con el planteamiento anterior resolveríamos:
-- --> 2.1. ¿cuál es género con mayor índice/número de canciones populares?

/* Respuesta: metal, con 14
* ¡¡¡Cuidado!!! Porque en la siguiente consulta observamos un duplicado, por lo que en total son 13 y no 14 */

-- --> 2.1. ¿Y si quisiéramos ver cuáles son esas canciones, incluyendo el nombre de la canción, el album, artista y género al que pertenecen?

SELECT genre as Genre,
track as Track,
album as Album,
artist as Artist,
popularity as Popularity_Rate
FROM spotipy
WHERE popularity >= 73
ORDER BY genre, popularity DESC, track;

/* Importante, tener en cuenta que, tal y como pasa aquí, puede haber canciones duplicadas 
Por ejemplo, "Hit the Road Jack", de Ray Charles, aparece dos veces, pero en este caso es porque el artista pertenece tanto al género blues, como al de jazz
Pero también aparece dos veces "The Emptiness Machine", de Linkin Park, y en este caso sólo está en metal, el motivo de la duplicidad aquí es porque aparece en 2 albums diferentes y cada registro tiene un índice
de popularidad diferente también (78 y 80).
Por lo que tendríamos que tener en cuenta esto último, de cara a la presentación de datos, para no incluirlo 2 veces y, en lo que respecta a la pregunta anterior, que entonces son 13 y no 14 canciones */

-- 3. ¿Cuáles son las tres canciones más populares en total y por género? - Spotipy
/* Como ya sé que tenemos el problema del duplicado en metal, que justo afecta a los índices más altos, le meto un limit 5 para seguir viendo 3, tras descartar ese duplicado */

-- Top 5 de jazz
SELECT 'jazz' AS genre, track, artist, album, popularity
FROM spotipy
WHERE genre = 'jazz'
ORDER BY popularity DESC, track ASC
LIMIT 5;  /* Aquí veo que "Hit the Road Jack", de Ray Charles, también aparece dos veces en jazz (y supongo que pasará igual en blues) 
porque está en 2 albums diferentes, con dos registros de popularidad (73 y 68) diferentes */

-- Top 5 de blues
SELECT 'blues' AS genre, track, artist, album, popularity
FROM spotipy
WHERE genre = 'blues'
ORDER BY popularity DESC, track ASC
LIMIT 5;

-- Top 5 de metal
SELECT 'metal' AS genre, track, artist, album, popularity
FROM spotipy
WHERE genre = 'metal'
ORDER BY popularity DESC, track ASC
LIMIT 5;

-- Top 5 de rap
SELECT 'rap' AS genre, track, artist, album, popularity
FROM spotipy
WHERE genre = 'rap'
ORDER BY popularity DESC, track ASC
LIMIT 5; /* Veo que el género rap no tiene cargado el índice de popularidad en la API, por lo que va a ser un reto contrastarlo con los demás géneros */

-- 4. Número total de reproducciones por artista y género - Last fm
/* Separo la consulta porque veo un poco absurdo el consultar por artista, habiendo 500 por género, sin acotar el resultado con algún limit */
-- Por artista:

SELECT
    artist,
    SUM(playcount) AS total_reproducciones, genre
FROM last_fm
GROUP BY artist
ORDER BY total_reproducciones DESC
limit 10;

-- Por género:

SELECT
    genre,
    SUM(playcount) AS total_reproducciones
FROM last_fm
GROUP BY genre
ORDER BY total_reproducciones DESC;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTAS EXTRA --




