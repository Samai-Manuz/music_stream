-- RENOMBRAMOS TABLAS --

ALTER TABLE ```last fm``` RENAME TO `API last fm`;
alter table spotipy rename to `API Spotify`;
alter table `api last fm` rename to `Last fm`;
alter table `API Spotify` rename to Spotipy;

-- RENOMBRAMOS COLUMNAS -- 

alter table `last fm`rename to last_fm;

alter table last_fm rename column artista to artist;

alter table last_fm rename column genero to genre;

alter table last_fm rename column anio to set_year;

alter table last_fm rename column similares to similars;

-- AÑADIMOS LA COLUMNA DE ARTISTAS DE LAST FM A SPOTIPY, COMO FOREIGN KEY --

ALTER TABLE spotipy
ADD COLUMN last_fm_artist TEXT;

SET SQL_SAFE_UPDATES = 0;

UPDATE spotipy
SET last_fm_artist = artist;

SET SQL_SAFE_UPDATES = 1;


ALTER TABLE last_fm
MODIFY artist VARCHAR(255);

ALTER TABLE spotipy
MODIFY last_fm_artist VARCHAR(255);

ALTER TABLE spotipy
ADD CONSTRAINT fk_spotipy_lastfm
FOREIGN KEY (last_fm_artist)
REFERENCES last_fm(artist);


-- COMPROBACIONES INICIALES Y OTRAS MODIFICACIONES --

SELECT * FROM spotipy;
SELECT * FROM last_fm;

alter table spotipy rename column artists to artist;

SELECT genre, COUNT(artist) Spotipy_artists
FROM spotipy
GROUP BY genre;

SELECT genre, COUNT(artist) Last_fm_artists
FROM last_fm
GROUP BY genre;

-- COMPROBAMOS EL NÚMERO DE ARTISTAS COINCIDENTES POR GÉNERO --

select *
from spotipy;

select *
from last_fm;

SELECT 
  l.genre AS `Género`,
  COUNT(DISTINCT l.artist) AS `Artistas Last.fm`,
  COUNT(DISTINCT s.artist) AS `Artistas Spotipy`
FROM last_fm l
JOIN spotipy s
  ON l.artist = s.artist
GROUP BY l.genre
ORDER BY l.artist DESC, s.artist DESC;

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