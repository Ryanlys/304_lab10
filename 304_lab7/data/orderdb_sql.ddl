DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    admin				int,
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,	
    status 				VARCHAR(40),
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Lobed');
INSERT INTO category(categoryName) VALUES ('Fan-shaped');
INSERT INTO category(categoryName) VALUES ('Katsura');
INSERT INTO category(categoryName) VALUES ('Simple');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sugar Maple', 1, ' ',2.70);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sycamore Maple', 1, ' ',12.70);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('White Oak', 1, ' ',45.0);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ginkgo', 2, ' ',23.0);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Katsura', 3, ' ',1.70);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Eastern Redbud', 4, ' ',0.80);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grey Alder', 4, ' ',0.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sugar Maple', 1, ' ',2.69);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sycamore Maple', 1, ' ',29.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('White Oak', 1, ' ',49.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ginkgo', 2, ' ',14.90);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Katsura', 3, ' ',0.89);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Eastern Redbud', 4, ' ',31.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grey Alder', 4, ' ',7.99);


INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test', 1);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby', 1);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES ('test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test' , 'test', 1);



DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 8.10);
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 4, 2, 2.70);
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 1, 2.70);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 13.50);
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 5, 2.70);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/7.jpg' WHERE ProductId = 7;


-- Insert Warehouses & warehouse inven
INSERT INTO warehouse(warehouseName) VALUES ('Main');
INSERT INTO warehouse(warehouseName) VALUES ('Backup');

INSERT INTO productinventory (productId,warehouseId,quantity,price) VALUES (1,1,89,2.70);
INSERT INTO productinventory (productId,warehouseId,quantity,price) VALUES (2,1,33,12.70);
INSERT INTO productinventory (productId,warehouseId,quantity,price) VALUES (3,1,259,45.0);
INSERT INTO productinventory (productId,warehouseId,quantity,price) VALUES (4,1,12,23.0);
INSERT INTO productinventory (productId,warehouseId,quantity,price) VALUES (5,1,234,1.70);
INSERT INTO productinventory (productId,warehouseId,quantity,price) VALUES (6,1,68,0.80);
INSERT INTO productinventory (productId,warehouseId,quantity,price) VALUES (7,1,123,0.50);
INSERT INTO productinventory (productId,warehouseId,quantity,price) VALUES (6,2,15,0.80);
INSERT INTO productinventory (productId,warehouseId,quantity,price) VALUES (7,2,12,0.50);