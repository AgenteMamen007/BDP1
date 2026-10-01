SELECT
  employeenumber,
  lastname
FROM employees
WHERE
  reportsto IN (
    SELECT
      employeenumber
    FROM employees
    WHERE
      reportsto IN (
        SELECT
          employeenumber
        FROM employees
        WHERE
          reportsto IS NULL
      )
  );