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

-- COMPROBACIONES INICIALES Y OTRAS MODIFICACIONES --

SELECT * FROM spotipy;
SELECT * FROM last_fm;

alter table spotipy rename column artists to artist;

SELECT genre, COUNT(artist)
FROM spotipy
GROUP BY genre;

SELECT genre, COUNT(artist)
FROM last_fm
GROUP BY genre;

-- COMPROBAMOS EL NÚMERO DE ARTISTAS COINCIDENTES POR GÉNERO --

SELECT 
  l.genre AS `Género`,
  COUNT(DISTINCT l.artist) AS `Artistas Last.fm`,
  COUNT(DISTINCT s.artist) AS `Artistas Spotipy`
FROM last_fm l
JOIN spotipy s
  ON l.artist = s.artist
GROUP BY l.genre
ORDER BY l.artist DESC, s.artist DESC;