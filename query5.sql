SELECT
  o.country,
  COUNT(o.officecode) AS oficinas_sin_ventas
FROM offices o
WHERE
  o.officecode NOT IN (
    SELECT DISTINCT
      e.officecode
    FROM employees e
    JOIN customers c ON e.employeenumber = c.salesrepemployeenumber
    JOIN orders ord ON c.customernumber = ord.customernumber
    WHERE
      EXTRACT(YEAR FROM ord.orderdate) = 2003
  )
GROUP BY
  o.country
ORDER BY
  oficinas_sin_ventas DESC;