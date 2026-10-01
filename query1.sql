SELECT
  c.customernumber,
  c.customername,
  SUM(p.amount) AS total_amount
FROM customers c
JOIN payments p ON c.customernumber = p.customernumber
WHERE
  c.customernumber IN (
    SELECT DISTINCT
      o.customernumber
    FROM products pr
    JOIN orderdetails od ON pr.productcode = od.productcode
    JOIN orders o ON od.ordernumber = o.ordernumber
    WHERE
      pr.productname = '1940 Ford Pickup Truck'
  )
GROUP BY
  c.customernumber,
  c.customername
ORDER BY
  total_amount DESC;