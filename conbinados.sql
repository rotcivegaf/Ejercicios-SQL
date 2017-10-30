/* 1. Obtener el nombre de los 3 libros que mas se vendieron junto con su autor. */
SELECT l.titulo, a.au_nombre, sum(v.qty) cantidadVentas
FROM libros l, autores a, libroautor la, ventas v
WHERE (
	la.libro_id = l.libro_id AND
    la.au_id = a.au_id AND
    v.libro_id = l.libro_id
)
GROUP BY v.libro_id, a.au_id
ORDER BY cantidadVentas DESC
LIMIT 3;
