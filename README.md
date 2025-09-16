# 🎧🔥 Proyecto SQL: Music Stream en Clave Urbana

**Bootcamp Data Analytics – Módulo 2**  
**Equipo:** Samai · Ela · Siuzanna · Ángela  
**Tecnologías:** 🖥️ MySQL Workbench · 🐍 Python · 💻 VS Code · 🎨 Canva  

---

## 🎯 Objetivo
Explorar las bases de datos musicales de Last.fm y Spotify para descubrir:  
quién manda en los géneros, qué artistas revientan el conteo y cómo evoluciona la música con el tiempo.  

👉 Todo con un flow urbano: datos que suenan como rimas y consultas que pintan un mural de tendencias.  

---

## 🗺️ Preguntas que nos hicimos
1️⃣ ¿Cuáles son los artistas más escuchados de cada género?  
2️⃣ Número de oyentes únicos por género  
3️⃣ Reproducciones totales por artista y género  
4️⃣ Álbumes más populares por año  
5️⃣ Artistas con más popularidad global 
6️⃣ Artistas con mayor popularidad media y al menos 3 años de presencia  
7️⃣ Metal -VS- Rap. Comparativa de sus artistas top  
8️⃣ Las 3 canciones más populares en total

---

## 🛠️ Metodología
- 🎶 **Géneros analizados:** Rap, Metal, Jazz y Blues.  
- 📂 **Conjuntos de datos:** `spotipy` (Spotify) y `last_fm` (Last.fm).  
- 🧹 **Procesamiento:** normalización de campos, creación de vistas SQL y consultas agregadas.  
- ⚙️ **Herramientas:** MySQL Workbench, Python, VS Code y Canva para la presentación.  

---

## 📊 Resultados destacados
- 🎤 Rap se lleva el 46% de oyentes, dejando claro quién manda en la calle.  
- 🎸 2021 que fue el año dorado para Metallica.  
- 🔝 Kanye West lidera en oyentes, pero en reproducciones BTS da el golpe.  
- 🥁 Linkin Park se cuela en el top 10, representando al Metal en un mundo dominado por el Rap.  
- 📀 El Blues y el Jazz se reivindican como clásicos del underground en términos de popularidad global.  
- ⭐ Consistencia: *Bring Me The Horizon* y *Falling in Reverse* mantienen el ritmo estable durante al menos 3 años.  
- 🔇La oscura sospecha del silenciamiento del Rap en Spotify, se confirma.  

---

## ⚡ Retos enfrentados
- 🔌 **API:** dificultad al entender qué datos extraer y cómo estructurarlos.  
- 🗄️ **BBDD:** errores de codificación en el volcado inicial.  
- 🔢 **Formato:** números cargados como texto → se normalizó con `CAST` y `REPLACE`.  
- 🤝 **Consultas en equipo:** decidir qué preguntas eran las más relevantes.  
- 📉 **Datos vacíos:** el Rap sin índice de popularidad en Spotify → sesgo visible.  
- 🕒 **Trabajo en equipo:** distintas formas de organización y gestión del tiempo nos obligaron a adaptarnos.  

---

## 🚀 Conclusiones
- El Rap domina en oyentes, pero está subrepresentado en métricas de popularidad → sesgo en plataformas.  
- El Metal aparece fuerte en canciones, artistas y álbumes icónicos, allí donde se silencia al Rap.  
- Contrastar Spotify + Last.fm permitió reducir la dependencia de una sola fuente.  
- Los datos reflejan que la industria legitima ciertos géneros (Metal/Jazz) mientras otros (Rap) quedan invisibilizados.  

---

## 🔮 Próximos pasos
- ⏳ Ampliar la línea temporal para ver tendencias a largo plazo.  
- 📊 Crear paneles dinámicos (Power BI o Tableau).  
- 🤖 Automatizar la extracción de pipelines en Python.  
- 🎼 Analizar más géneros (ej. reguetón, pop latino) para ver si el sesgo se repite.  

---

## ✍️ Autoras
👩‍💻 Samai · 👩‍💻 Ela · 👩‍💻 Siuzanna · 👩‍💻 Ángela  
Bootcamp Data Analytics – Adalab · Septiembre 2025  

---

> 🎵 “Los datos son barras, las consultas son beats,  
> pintamos la música en la pared del SQL street.” 🎵


