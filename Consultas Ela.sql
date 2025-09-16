use`music stream`;

select *
from `spotipy`;
select *
from `last_fm`;

select genre as Género, count(distinct artist) as Artistas_diferentes
from spotipy
group by genre
having count(distinct artist)
union
select genre as Género, count(distinct artist) as Artistas_diferentes
from last_fm
group by genre
having count(distinct artist);

/*Bootcamp Data Analytics - Ejercicio SQL
   Alumna: Ela Ruiz González
   Fecha: 10/09/2025
   Tema: Consultas y Vistas en BBDD Music Stream*/

-- ¿Cuáles son los artistas más escuchados de cada género?
CREATE OR REPLACE VIEW top_artista_por_genero AS
SELECT t.genre genero,               -- género musical
       t.artist artista,             -- nombre del artista
       t.listeners_num oyentes       -- número de oyentes normalizado
FROM last_fm_clean t                 -- tabla base normalizada
INNER JOIN (
    SELECT genre genero,             -- género musical
           MAX(listeners_num) max_oyentes -- máximo de oyentes por género
    FROM last_fm_clean
    GROUP BY genre                   -- agrupación por género
) m
  ON t.genre = m.genero              -- empareja género actual con el máximo
 AND t.listeners_num = m.max_oyentes; -- empareja oyentes con el valor máximo

SELECT * FROM top_artista_por_genero; -- muestra los artistas más escuchados por género

-- Número de álbumes por género y año
CREATE OR REPLACE VIEW albums_por_genero_anio AS
SELECT genre genero,                 -- género musical
       release_year anio,            -- año de publicación
       COUNT(album) total_albumes    -- total de álbumes en ese grupo
FROM spotipy
GROUP BY genre, release_year;        -- agrupación por género y año

SELECT * FROM albums_por_genero_anio; -- muestra los resultados

-- Álbumes más populares por año
CREATE OR REPLACE VIEW album_mas_popular_por_anio AS
SELECT s.release_year anio,          -- año de publicación
       s.album album,                -- nombre del álbum
       s.popularity popularidad      -- popularidad del álbum
FROM spotipy s
WHERE s.popularity = (
    SELECT MAX(s2.popularity)        -- máximo valor de popularidad
    FROM spotipy s2
    WHERE s2.release_year = s.release_year -- compara en el mismo año
);

SELECT * FROM album_mas_popular_por_anio; -- muestra los álbumes más populares por año

-- Canciones más populares de cada artista
CREATE OR REPLACE VIEW cancion_mas_popular_por_artista AS
SELECT s.artist artista,             -- nombre del artista
       s.track cancion,              -- título de la canción
       s.popularity popularidad      -- popularidad de la canción
FROM spotipy s
WHERE s.popularity = (
    SELECT MAX(s2.popularity)        -- máximo de popularidad
    FROM spotipy s2
    WHERE s2.artist = s.artist       -- dentro del mismo artista
);

SELECT * FROM cancion_mas_popular_por_artista; -- muestra la canción más popular por artista

-- ¿Cuáles son los artistas con mayor popularidad media y al menos 3 años de presencia?
CREATE OR REPLACE VIEW artistas_populares_consistentes AS
SELECT artist artista,               -- nombre del artista
       COUNT(DISTINCT release_year) anios_con_datos, -- número de años distintos
       AVG(popularity) popularidad_media -- media de popularidad
FROM spotipy
GROUP BY artist
HAVING COUNT(DISTINCT release_year) >= 3 -- exige mínimo 3 años con datos
ORDER BY popularidad_media DESC;     -- ordena por media descendente

SELECT * FROM artistas_populares_consistentes; -- muestra artistas consistentes

-- ¿Cómo evolucionó el número de oyentes de cada género entre un año y el anterior?
CREATE OR REPLACE VIEW crecimiento_oyentes AS
SELECT
  t.genre,                                   -- género musical
  t.set_year AS anio,                        -- año actual
  SUM(t.listeners_num) AS total_oyentes,     -- total de oyentes ese año
  SUM(p.listeners_num) AS oyentes_previos,   -- total de oyentes en el año anterior
  (SUM(t.listeners_num) - SUM(p.listeners_num)) AS delta_abs,   -- diferencia absoluta de oyentes entre un año y el anterior.te dice cuántos oyentes subieron o bajaron.
  ROUND(
    (SUM(t.listeners_num) - SUM(p.listeners_num)) / SUM(p.listeners_num) * 100,
    2
  ) AS delta_pct                             -- diferencia relativa expresada en porcentaje.te dice qué porcentaje supone ese cambio respecto al año anterior.
FROM last_fm_clean t
JOIN last_fm_clean p
  ON t.genre = p.genre                       -- mismo género
 AND t.set_year = p.set_year + 1             -- año actual emparejado con el anterior
GROUP BY t.genre, t.set_year
ORDER BY anio, genre;

SELECT * FROM crecimiento_oyentes;


/*Fin del script de entrega - Ela Ruiz González - 10/09/2025*/












          