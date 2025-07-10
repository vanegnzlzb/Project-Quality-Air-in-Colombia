-- CREAMOS TABLA ANTIOQUIA
USE calidad_aire_en_colombia;
CREATE TABLE calidad_aire_antioquia AS
SELECT * FROM calidad_aire_en_colombia.calidad_aire_completos
WHERE `Nombre del departamento` = 'ANTIOQUIA';

-- CUANTOS DATOS TIENE MI TABLA
SELECT COUNT(*) FROM calidad_aire_en_colombia.calidad_aire_antioquia;

-- ¿Qué contaminantes ha tenido Antioquia a lo largo de 2011 a 2022?
SELECT DISTINCT `Variable`
FROM calidad_aire_en_colombia.calidad_aire_antioquia
WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO', 'NO2', 'SO2', 'SO2_TR', 'O3', 'CO');
/* Antioquia solo ha presentado 8 de 9 contaminantes en esos años. 
La unica que no ha tenido es SO2_TR */

-- ¿Qué variables metereologicas ha tenido Antioquia a lo largo de 2011 a 2022?
SELECT DISTINCT `Variable`
FROM calidad_aire_en_colombia.calidad_aire_antioquia
WHERE `Variable` IN ('VViento', 'DViento', 'Taire', 'Taire2', 'Taire10', 'Pliquida', 'P', 
'HAire', 'HAire2', 'HAire10', 'RGlobal', 'RUVb');
/* Antioquia solo ha presentado 11 de 12 variables metereologicas en esos años. 
La unica que no ha tenido es RUVb*/

-- ¿CÓMO HA EVELUCIONADO EL PROMEDIO DE PM10 EN EL DEPARTAMENTO DE ANTIOQUIA (2011-2022)?
WITH contaminantes_antioquia AS (
	SELECT * FROM calidad_aire_en_colombia.calidad_aire_antioquia
    WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO2', 'SO2')
    /* Solo se trabajara con los contaminantes que estan regulados anualmente dado la ley 2254/2017 */
) 
SELECT `Year`, AVG(Promedio) AS Promedio_Anual_PM10
FROM contaminantes_antioquia
WHERE `Variable`= 'PM10'
GROUP BY `Year`
ORDER BY Promedio_Anual_PM10 DESC;
/* Aunque el pico mas alto de PM10 en Antioquia fue en 2012 con un promedio anual de 44.9 
sigue estando dentro de los rangos establecidos por el gobierno dado que desde 2011 se estableció 
que el maximo anual era de 50 ug/m^3 */

-- ¿CÓMO HA EVELUCIONADO EL PROMEDIO DE PM2.5 EN EL DEPARTAMENTO DE ANTIOQUIA (2011-2022)?
WITH contaminantes_antioquia AS (
	SELECT * FROM calidad_aire_en_colombia.calidad_aire_antioquia
    WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO2', 'SO2')
    /* Solo se trabajara con los contaminantes que estan regulados anualmente dado la ley 2254/2017 */
) 
SELECT `Year`, AVG(Promedio) AS `Promedio_Anual_PM2.5`
FROM contaminantes_antioquia
WHERE `Variable`= 'PM2.5' 
GROUP BY `Year`
HAVING AVG(Promedio) > 25
ORDER BY `Year` DESC;
/* El pico mas alto de PM2.5 en Antioquia fue en 2016 con un promedio anual de 32.9 
Sin embargo el promedio anual establecido por el gobierno es de 25 ug/m^3 
por ende se ha excedido desde el 2011 a 2016 */

-- ¿CÓMO HA EVELUCIONADO EL PROMEDIO DE PST EN EL DEPARTAMENTO DE ANTIOQUIA (2011-2022)?
WITH contaminantes_antioquia AS (
	SELECT * FROM calidad_aire_en_colombia.calidad_aire_antioquia
    WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO2', 'SO2')
    /* Solo se trabajara con los contaminantes que estan regulados anualmente dado la ley 2254/2017 */
) 
SELECT `Year`, AVG(Promedio) AS `Promedio_Anual_PST`
FROM contaminantes_antioquia
WHERE `Variable`= 'PST' 
GROUP BY `Year`
ORDER BY `Promedio_Anual_PSTcalidad_aire_completos` DESC;
/* Aunque el pico más alto de PST en Colombia fue de 79.6 en el 2012 ha estado dentro del rango
permitido por el gobierno que es de 100 ug/m^3 */

-- ¿CÓMO HA EVELUCIONADO EL PROMEDIO DE NO2 EN EL DEPARTAMENTO DE ANTIOQUIA (2011-2022)?
WITH contaminantes_antioquia AS (
	SELECT * FROM calidad_aire_en_colombia.calidad_aire_antioquia
    WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO2', 'SO2')
    /* Solo se trabajara con los contaminantes que estan regulados anualmente dado la ley 2254/2017 */
) 
SELECT `Year`, AVG(Promedio) AS `Promedio_Anual_NO2`
FROM contaminantes_antioquia
WHERE `Variable`= 'NO2' 
GROUP BY `Year`
ORDER BY `Promedio_Anual_NO2` DESC;
/* Aunque el pico más alto de NO2 en Colombia fue de 37.2 en el 2011 ha estado dentro del rango
permitido por el gobierno que es de 60 ug/m^3 */

-- ¿CÓMO HA EVELUCIONADO EL PROMEDIO DE SO2 EN EL DEPARTAMENTO DE ANTIOQUIA (2011-2022)?
WITH contaminantes_antioquia AS (
	SELECT * FROM calidad_aire_en_colombia.calidad_aire_antioquia
    WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO2', 'SO2')
    /* Solo se trabajara con los contaminantes que estan regulados anualmente dado la ley 2254/2017 */
) 
SELECT `Year`, AVG(Promedio) AS `Promedio_Anual_SO2`
FROM contaminantes_antioquia
WHERE `Variable`= 'SO2' 
GROUP BY `Year`
ORDER BY `Promedio_Anual_SO2` DESC;
/* Aunque el pico más alto de NO2 en Colombia fue de 23.8 en el 2018 ha estado dentro del rango
permitido por el gobierno que es de 80 ug/m^3 */

/* Se notó que el contaminante PM2.5 se ha excedido varias veces desde el año 2011 a 2016 en Antioquia.
Esto se ha dado debido al crecimiento de vehiculos en ese departamento que usan diesel y entre otras cosas.
Pero ¿Qué municipios tienen los mayores percentiles 98 de PM2.5? */
SELECT `Nombre del Municipio`, `Variable`, AVG(`Percentil 98`) AS `Promedio_Percentil_98`
FROM calidad_aire_en_colombia.calidad_aire_antioquia
WHERE `Variable`='PM2.5'
GROUP BY `Nombre del Municipio`
HAVING AVG(`Percentil 98`) > 25
ORDER BY `Promedio_Percentil_98` DESC;
/* Sabaneta es el municipio de antioquia que mayor percentil de 98 tiene. 
Es decir, que el 2% de las veces se registran valores superiores a 54.6 ugm^3. 
Significa que en algunos momentos del año los niveles de contaminación están excediendo lo recomendado, 
lo que puede incrementar riesgos respiratorios y cardiovasculares. */

-- ¿EL PORCENTAJE DE EXCEDENCIAS HA MEJORADO EN ANTIOQUIA?}
SELECT `Year`, `Variable`, AVG(`Porcentaje excedencias limite actual`) AS `Promedio_Porcentaje_Excedencia`
FROM calidad_aire_en_colombia.calidad_aire_antioquia
WHERE `Variable` = 'PM10'
GROUP BY `Year`, `Variable`
ORDER BY `Year` DESC;

