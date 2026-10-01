SELECT 
    od1.productcode AS id1, 
    od2.productcode AS id2, 
    COUNT(od1.ordernumber) AS numero_carros
FROM 
    orderdetails od1
JOIN 
    orderdetails od2 ON od1.ordernumber = od2.ordernumber
WHERE 
    od1.productcode < od2.productcode
GROUP BY 
    od1.productcode, 
    od2.productcode
HAVING 
    COUNT(od1.ordernumber) > 1
ORDER BY 
    numero_carros DESC
LIMIT 3;