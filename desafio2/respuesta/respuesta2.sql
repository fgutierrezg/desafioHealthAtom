--Ejercio 1

SELECT titanes.nombre, titanes.altura, muertes.fecha
FROM titanes
JOIN muertes ON titanes.id = muertes.id_titan
WHERE muertes.causa = 'Accidente'
ORDER BY muertes.fecha;

--Ejercio 2

SELECT titanes.nombre, MAX(titanes.altura)
FROM titanes
JOIN muertes ON titanes.id = muertes.id_titan
WHERE muertes.causa = 'Batallón 1'
ORDER BY muertes.fecha;

--Ejercicio 3

SELECT titanes.id, titanes.nombre, titanes.altura, avistamientos.fecha
FROM titanes
JOIN avistamientos ON titanes.id = avistamientos.id_titan
WHERE titanes.id NOT IN(SELECT DISTINCT(id_titan) FROM muertes) 
AND avistamientos.fecha = (
    SELECT MAX(fecha)
    FROM avistamientos
    WHERE id_titan = titanes.id
);

--Ejercicio 4

SELECT titanes.id, titanes.nombre
FROM titanes
INNER JOIN avistamientos ON titanes.id = avistamientos.id_titan
WHERE YEAR(avistamientos.fecha) IN (
    SELECT YEAR(fecha)
    FROM avistamientos
    GROUP BY YEAR(fecha)
    HAVING COUNT(DISTINCT MONTH(fecha)) > 1
)

GROUP BY titanes.id, titanes.nombre
ORDER BY titanes.nombre

--Ejercicio 5
SELECT rec.nombre, COUNT(rec.nombre) AS cantidad, rec.unidad FROM movimientos_recursos mov
JOIN recursos rec ON rec.id = mov.id_recurso
JOIN muertes mue ON mue.id = mov.id_muerte
JOIN titanes tit ON tit.id = mue.id_titan
WHERE tit.altura <= 5
GROUP BY rec.nombre
ORDER BY cantidad

--Ejercicio 6
SELECT rec.nombre, COUNT(rec.nombre) AS cantidad, rec.unidad FROM movimientos_recursos mov
JOIN recursos rec ON rec.id = mov.id_recurso
JOIN muertes mue ON mue.id = mov.id_muerte
JOIN titanes tit ON tit.id = mue.id_titan
WHERE tit.altura = 9
GROUP BY rec.nombre
ORDER BY cantidad DESC
LIMIT 1;

--Ejercio 7
SELECT tit.id, tit.nombre, mue.fecha as fecha_muerte, av.fecha as fecha_avistamiento FROM titanes tit
JOIN muertes mue ON mue.id_titan = tit.id
JOIN avistamientos av ON av.id_titan = tit.id
WHERE av.fecha > mue.fecha

--Ejercicio 8
/*

Tenemos incongruencias ya que existen avistamientos registrados de titanes que se supone murieron.
Esto puede deberse a:
1. Problemas de quienes ingresan la información, error de tipeo, error humano. 
2. Problemas del sistema (a nivel código). Suponiendo que exista alguna función que guarda y asigna fecha a los registros, puede que esta se encuentre con algun error, sería bueno revisar el código. 
3. Problema de definición a nivel de BD. Quizás existe una función, un trigger, procedimiento almacenado u otro proceso que contenga un error.

Además, pudiese ser que haya algun traidor entre las filas que esté corrompiendo los registros a propósito para bajar la moral o crear desconfianza en quienes lideran la resistencia humana.

*/


