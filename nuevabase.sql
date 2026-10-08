DROP TABLE IF EXISTS employeeoffices CASCADE;
DROP TABLE IF EXISTS customeremployees CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS orderdetails CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS productlines CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS offices CASCADE;

-- 1. Tabla: productlines
CREATE TABLE productlines (
    productline character varying(50) NOT NULL,
    textdescription character varying(4000) DEFAULT NULL,
    htmldescription character varying(4000),
    image character varying,
    CONSTRAINT productlines_pkey PRIMARY KEY (productline)
);

-- 2. Tabla: products
CREATE TABLE products (
    productcode character varying(15) NOT NULL,
    productname character varying(70) NOT NULL,
    productline character varying(50) NOT NULL,
    productscale character varying(10) NOT NULL,
    productvendor character varying(50) NOT NULL,
    productdescription text NOT NULL,
    quantityinstock smallint NOT NULL,
    buyprice numeric(10,2) NOT NULL,
    msrp numeric(10,2) NOT NULL,
    CONSTRAINT products_pkey PRIMARY KEY (productcode),
    CONSTRAINT products_productline_fkey FOREIGN KEY (productline) 
        REFERENCES productlines(productline)
);

-- 3. Tabla: offices
CREATE TABLE offices (
    officecode character varying(10) NOT NULL,
    city character varying(50) NOT NULL,
    phone character varying(50) NOT NULL,
    addressline1 character varying(50) NOT NULL,
    addressline2 character varying(50) DEFAULT NULL,
    state character varying(50) DEFAULT NULL,
    country character varying(50) NOT NULL,
    postalcode character varying(15) NOT NULL,
    territory character varying(10) NOT NULL,
    CONSTRAINT offices_pkey PRIMARY KEY (officecode)
);

-- 4. Tabla: employees
CREATE TABLE employees (
    employeenumber integer NOT NULL,
    lastname character varying(50) NOT NULL,
    firstname character varying(50) NOT NULL,
    extension character varying(10) NOT NULL,
    email character varying(100) NOT NULL,
    reportsto integer,
    jobtitle character varying(50) NOT NULL,
    CONSTRAINT employees_pkey PRIMARY KEY (employeenumber),
    CONSTRAINT employees_reportsto_fkey FOREIGN KEY (reportsto) 
        REFERENCES employees(employeenumber)
);

-- 5. Tabla: employeeoffices 
CREATE TABLE employeeoffices (
    employeenumber integer NOT NULL,
    officecode character varying(10) NOT NULL,
    startdate date NOT NULL,
    enddate date,
    CONSTRAINT employeeoffices_pkey PRIMARY KEY (employeenumber, officecode, startdate),
    CONSTRAINT employeeoffices_employeenumber_fkey FOREIGN KEY (employeenumber) 
        REFERENCES employees(employeenumber),
    CONSTRAINT employeeoffices_officecode_fkey FOREIGN KEY (officecode) 
        REFERENCES offices(officecode)
);

-- 6. Tabla: customers
CREATE TABLE customers (
    customernumber integer NOT NULL,
    customername character varying(50) NOT NULL,
    contactlastname character varying(50) NOT NULL,
    contactfirstname character varying(50) NOT NULL,
    phone character varying(50) NOT NULL,
    addressline1 character varying(50) NOT NULL,
    addressline2 character varying(50) DEFAULT NULL,
    city character varying(50) NOT NULL,
    state character varying(50) DEFAULT NULL,
    postalcode character varying(15) DEFAULT NULL,
    country character varying(50) NOT NULL,
    creditlimit numeric(10,2) DEFAULT NULL,
    CONSTRAINT customers_pkey PRIMARY KEY (customernumber)
);

-- 7. Tabla: customeremployees 
CREATE TABLE customeremployees (
    customernumber integer NOT NULL,
    employeenumber integer NOT NULL,
    CONSTRAINT customeremployees_pkey PRIMARY KEY (customernumber, employeenumber),
    CONSTRAINT customeremployees_customernumber_fkey FOREIGN KEY (customernumber) 
        REFERENCES customers(customernumber),
    CONSTRAINT customeremployees_employeenumber_fkey FOREIGN KEY (employeenumber) 
        REFERENCES employees(employeenumber)
);

-- 8. Tabla: orders
CREATE TABLE orders (
    ordernumber integer NOT NULL,
    orderdate date NOT NULL,
    requireddate date NOT NULL,
    shippeddate date,
    status character varying(15) NOT NULL,
    comments text,
    customernumber integer NOT NULL,
    CONSTRAINT orders_pkey PRIMARY KEY (ordernumber),
    CONSTRAINT orders_customernumber_fkey FOREIGN KEY (customernumber) 
        REFERENCES customers(customernumber)
);

-- 9. Tabla: orderdetails
CREATE TABLE orderdetails (
    ordernumber integer NOT NULL,
    productcode character varying(15) NOT NULL,
    quantityordered integer NOT NULL,
    priceeach numeric(10,2) NOT NULL,
    orderlinenumber smallint NOT NULL,
    CONSTRAINT orderdetails_pkey PRIMARY KEY (ordernumber, productcode),
    CONSTRAINT orderdetails_ordernumber_fkey FOREIGN KEY (ordernumber) 
        REFERENCES orders(ordernumber),
    CONSTRAINT orderdetails_productcode_fkey FOREIGN KEY (productcode) 
        REFERENCES products(productcode)
);

-- 10. Tabla: payments
CREATE TABLE payments (
    checknumber character varying(50) NOT NULL,
    paymentdate date NOT NULL,
    amount numeric(10,2) NOT NULL,
    ordernumber integer NOT NULL,
    CONSTRAINT payments_pkey PRIMARY KEY (checknumber),
    CONSTRAINT payments_ordernumber_fkey FOREIGN KEY (ordernumber) 
        REFERENCES orders(ordernumber)
);