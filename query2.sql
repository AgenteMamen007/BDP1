SELECT 
    p.productline, 
    AVG(o.shippeddate - o.orderdate) AS tiempo_medio
FROM 
    orders o
JOIN 
    orderdetails od ON o.ordernumber = od.ordernumber
JOIN 
    products p ON od.productcode = p.productcode
WHERE 
    o.shippeddate IS NOT NULL
GROUP BY 
    p.productline;