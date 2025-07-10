-- REVISAMOS NUESTROS DATOS HAYAN CARGADO DE MANERA CORRECTA
SELECT * FROM calidad_aire_en_colombia.calidad_aire;

-- REVISAMOS DE QUE AÑOS ES NUESTRA DATA
SELECT DISTINCT `Year` FROM calidad_aire_en_colombia.calidad_aire;
/* Notamos que en nuestros datos tenemos información desde el 2011 hasta el 2022*/

-- REVISAMOS CUANTOS DEPARTAMENTOS HAY EN NUESTRA DATA
SELECT COUNT(DISTINCT `Nombre del Departamento`) FROM calidad_aire_en_colombia.calidad_aire;
/* En nuestro dataset hay 24 departamentos de los 32 departamentos de Colombia */

-- REVISAMOS LOS NOMBRES DE LOS 24 DEPARTAMENTOS DE NUESTRA DATA
SELECT DISTINCT `Nombre del Departamento`
FROM calidad_aire_en_colombia.calidad_aire 
ORDER BY `Nombre del Departamento` ASC;
/* Hemos notado que uno de los departamentos que aparece es BOGOTA, pero este pertenece a CUNDINAMARCA*/

-- REEMPLAZAMOS BOGOTA A CUNDINAMARCA EN NUESTRA COLUMNA DE DEPARTAMENTOS
UPDATE calidad_aire_en_colombia.calidad_aire
SET `Nombre del Departamento` = REPLACE(`Nombre del Departamento`, 'BOGOTA', 'CUNDINAMARCA')
WHERE `Nombre del Departamento` LIKE '%BOGOTA%';

-- NUEVAMENTE REVISAMOS LOS NOMBRES DE LOS DEPARTAMENTOS PARA REVISAR QUE SE HAYA CORREGIDO
SELECT DISTINCT `Nombre del Departamento`
FROM calidad_aire_en_colombia.calidad_aire 
ORDER BY `Nombre del Departamento` ASC;
/* Al corregir en nuestro dataset hay 23 departamentos de los 32 departamentos de Colombia */

-- REVISAMOS QUE DEPARTAMENTOS TIENEN LA DATA COMPLETA DESDE 2011 A 2022
WITH Departamentos_Completos AS (
    SELECT `Nombre del departamento`
    FROM calidad_aire_en_colombia.calidad_aire
    WHERE `Year` BETWEEN 2011 AND 2022
    GROUP BY `Nombre del departamento`
    HAVING COUNT(DISTINCT `Year`) = (
        SELECT COUNT(DISTINCT `Year`) 
        FROM calidad_aire_en_colombia.calidad_aire 
        WHERE `Year` BETWEEN 2011 AND 2022
    )
)
SELECT * FROM Departamentos_Completos
ORDER BY `Nombre del departamento` ASC;
/* De los 23 departamentos de nuestro dataset solo 13 tienen la data completa desde 2011 a 2022*/

-- CREAMOS UNA NUEVA TABLA QUE SOLO CONTENGA LOS DATOS 
-- DE LOS 13 departamentos que tienen la data completa en Colombia
USE calidad_aire_en_colombia;
CREATE TABLE calidad_aire_completos AS
SELECT * FROM calidad_aire_en_colombia.calidad_aire
WHERE `Nombre del departamento` IN ('ANTIOQUIA', 'BOYACA', 'CALDAS', 'CESAR', 'CUNDINAMARCA',
 'HUILA', 'LA GUAJIRA', 'MAGDALENA', 'QUINDIO', 'RISARALDA', 'SANTANDER', 'TOLIMA', 'VALLE DEL CAUCA');
 
 -- REVISAMOS LOS DATOS DE NUESTRA NUEVA TABLA
 SELECT * FROM calidad_aire_en_colombia.calidad_aire_completos;
 
 -- ¿CÓMO HA EVELUCIONADO EL PROMEDIO DE PM10 EN COLOMBIA EN LOS DISTINTOS DEPARTAMENTOS (2011-2022)?
WITH contaminante_PM10 AS (
	SELECT * FROM calidad_aire_en_colombia.calidad_aire_completos
    WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO2', 'SO2')
    /* Solo se trabajara con los contaminantes que estan regulados anualmente dado la ley 2254/2017 */
) 
SELECT `Nombre del Departamento`, AVG(Promedio) AS Promedio_Anual_PM10
FROM contaminante_PM10
WHERE `Variable`= 'PM10'
GROUP BY `Nombre del Departamento`
ORDER BY Promedio_Anual_PM10 DESC;

-- ¿CÓMO HA EVELUCIONADO EL PROMEDIO DE PM2.5 EN COLOMBIA EN LOS DISTINTOS DEPARTAMENTOS (2011-2022)?
WITH `contaminante_PM2.5` AS (
	SELECT * FROM calidad_aire_en_colombia.calidad_aire_completos
    WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO2', 'SO2')
    /* Solo se trabajara con los contaminantes que estan regulados anualmente dado la ley 2254/2017 */
) 
SELECT `Nombre del Departamento`, AVG(Promedio) AS `Promedio_Anual_PM2.5`
FROM `contaminante_PM2.5`
WHERE `Variable`= 'PM2.5'
GROUP BY `Nombre del Departamento`
ORDER BY `Promedio_Anual_PM2.5` DESC;

-- ¿CÓMO HA EVELUCIONADO EL PROMEDIO DE PST EN COLOMBIA EN LOS DISTINTOS DEPARTAMENTOS (2011-2022)?
WITH `contaminante_PST` AS (
	SELECT * FROM calidad_aire_en_colombia.calidad_aire_completos
    WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO2', 'SO2')
    /* Solo se trabajara con los contaminantes que estan regulados anualmente dado la ley 2254/2017 */
) 
SELECT `Nombre del Departamento`, AVG(Promedio) AS `Promedio_Anual_PST`
FROM `contaminante_PST`
WHERE `Variable`= 'PST'
GROUP BY `Nombre del Departamento`
ORDER BY `Promedio_Anual_PST` DESC;

-- ¿CÓMO HA EVELUCIONADO EL PROMEDIO DE NO2 EN COLOMBIA EN LOS DISTINTOS DEPARTAMENTOS (2011-2022)?
WITH `contaminante_NO2` AS (
	SELECT * FROM calidad_aire_en_colombia.calidad_aire_completos
    WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO2', 'SO2')
    /* Solo se trabajara con los contaminantes que estan regulados anualmente dado la ley 2254/2017 */
) 
SELECT `Nombre del Departamento`, AVG(Promedio) AS `Promedio_Anual_NO2`
FROM `contaminante_NO2`
WHERE `Variable`= 'NO2'
GROUP BY `Nombre del Departamento`
ORDER BY `Promedio_Anual_NO2` DESC;

-- ¿CÓMO HA EVELUCIONADO EL PROMEDIO DE SO2 EN COLOMBIA EN LOS DISTINTOS DEPARTAMENTOS (2011-2022)?
WITH `contaminante_SO2` AS (
	SELECT * FROM calidad_aire_en_colombia.calidad_aire_completos
    WHERE `Variable` IN ('PM10', 'PM2.5', 'PST', 'NO2', 'SO2')
    /* Solo se trabajara con los contaminantes que estan regulados anualmente dado la ley 2254/2017 */
) 
SELECT `Nombre del Departamento`, AVG(Promedio) AS `Promedio_Anual_SO2`
FROM `contaminante_SO2`
WHERE `Variable`= 'SO2'
GROUP BY `Nombre del Departamento`
ORDER BY `Promedio_Anual_SO2` DESC;