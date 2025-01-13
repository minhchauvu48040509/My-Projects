-- Question-A
-- Table Creation (Corrected and Completed)

CREATE TABLE Promotion (
	PromoID CHAR(3) NOT NULL,
	PromoName VARCHAR(50) NOT NULL,
	PromoDiscount DECIMAL(4,1) NOT NULL,
	PRIMARY KEY (PromoID)
);

CREATE TABLE Category (
	CategoryID CHAR(5) NOT NULL,
	CategoryName VARCHAR(50) NOT NULL,
	CategoryDesc VARCHAR(200) NOT NULL,
	PRIMARY KEY (CategoryID)
);

CREATE TABLE Chocolate (
	ChocolateID CHAR(6) NOT NULL,
	ChocolateName VARCHAR(50) NOT NULL,
	ChocolateDesc VARCHAR(200) NOT NULL,
	ChocolatePrice DECIMAL (5,2) NOT NULL,
	ChocolateWeight INT NOT NULL,
	CategoryID CHAR(5) NOT NULL,
	PRIMARY KEY (ChocolateID),
	FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Discount (
	PromotionID CHAR(3) NOT NULL,
	ChocolateID CHAR(6) NOT NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL,
	PRIMARY KEY (PromotionID, ChocolateID, StartDate),
	FOREIGN KEY (PromotionID) REFERENCES Promotion(PromoID),
	FOREIGN KEY (ChocolateID) REFERENCES Chocolate(ChocolateID)
);

CREATE TABLE Customer (
	CustomerID CHAR(6) NOT NULL,
	CustomerName VARCHAR(70) NOT NULL,
	CustomerEmail VARCHAR(100) NOT NULL,
	CustomerPhNum VARCHAR(32) NOT NULL,
	PRIMARY KEY (CustomerID)
);

CREATE TABLE Review (
	ReviewID CHAR(6) NOT NULL,
	ReviewRating DECIMAL(2,0) NOT NULL,
	ReviewComment VARCHAR(255) NOT NULL,
	ReviewDate DATETIME NOT NULL,
	CustomerID CHAR(6) NULL,
	ChocolateID CHAR(6) NOT NULL,
	PRIMARY KEY (ReviewID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (ChocolateID) REFERENCES Chocolate(ChocolateID)
);

-- Inserting at least 5 records for each table

-- Promotion records
INSERT INTO Promotion VALUES ('P01', 'Opening Sale', 50.0);
INSERT INTO Promotion VALUES ('P02', 'Valentine Special', 30.0);
INSERT INTO Promotion VALUES ('P03', 'Christmas Sale', 25.0);
INSERT INTO Promotion VALUES ('P04', 'Black Friday', 40.0);
INSERT INTO Promotion VALUES ('P05', 'Summer Deal', 20.0);

-- Category records
INSERT INTO Category VALUES ('CAT01', 'Ecuador Single Origin', 'Cocoa beans from a single Ecuadorian source');
INSERT INTO Category VALUES ('CAT02', 'Venezuelan Truffles', 'Premium truffles from Venezuela');
INSERT INTO Category VALUES ('CAT03', 'Belgian Dark', 'Classic Belgian dark chocolate');
INSERT INTO Category VALUES ('CAT04', 'Swiss Milk', 'Rich Swiss milk chocolate');
INSERT INTO Category VALUES ('CAT05', 'Peruvian Special', 'Unique Peruvian cocoa blends');

-- Chocolate records
INSERT INTO Chocolate VALUES ('CHOC01', 'Dark Chocolate Tablet', 'Bite-sized dark chocolate', 15.99, 80, 'CAT01');
INSERT INTO Chocolate VALUES ('CHOC02', 'Milk Chocolate Bar', 'Creamy Swiss milk chocolate', 12.99, 120, 'CAT04');
INSERT INTO Chocolate VALUES ('CHOC03', 'Belgian Pralines', 'Fine Belgian pralines', 25.99, 150, 'CAT03');
INSERT INTO Chocolate VALUES ('CHOC04', 'Venezuelan Truffles', 'Premium truffles from Venezuela', 30.50, 100, 'CAT02');
INSERT INTO Chocolate VALUES ('CHOC05', 'Peruvian Cocoa Tablet', 'Unique Peruvian cocoa', 20.00, 100, 'CAT05');

-- Discount records
INSERT INTO Discount VALUES ('P01', 'CHOC01', '2023-02-01 08:00:00', '2023-02-02 18:00:00');
INSERT INTO Discount VALUES ('P02', 'CHOC02', '2023-02-10 08:00:00', '2023-02-14 23:59:00');
INSERT INTO Discount VALUES ('P03', 'CHOC03', '2023-12-20 08:00:00', '2023-12-25 23:59:00');
INSERT INTO Discount VALUES ('P04', 'CHOC04', '2023-11-25 08:00:00', '2023-11-25 23:59:00');
INSERT INTO Discount VALUES ('P05', 'CHOC05', '2023-07-01 08:00:00', '2023-07-07 23:59:00');

-- Customer records
INSERT INTO Customer VALUES ('CUS145', 'Jon Snow', 'j.snow@notreal.com', '90861923');
INSERT INTO Customer VALUES ('CUS146', 'Arya Stark', 'a.stark@notreal.com', '91234567');
INSERT INTO Customer VALUES ('CUS147', 'Tyrion Lannister', 't.lannister@notreal.com', '98765432');
INSERT INTO Customer VALUES ('CUS148', 'Daenerys Targaryen', 'd.targaryen@notreal.com', '87654321');
INSERT INTO Customer VALUES ('CUS149', 'Bran Stark', 'b.stark@notreal.com', '81920384');

-- Review records
INSERT INTO Review VALUES ('REV131', 8, 'Delicious dark chocolate', '2023-02-02 13:22:54', 'CUS145', 'CHOC01');
INSERT INTO Review VALUES ('REV132', 9, 'Amazing milk chocolate!', '2023-02-12 10:05:32', 'CUS146', 'CHOC02');
INSERT INTO Review VALUES ('REV133', 7, 'Good truffles, but pricey', '2023-12-25 16:20:00', 'CUS147', 'CHOC03');
INSERT INTO Review VALUES ('REV134', 10, 'Fantastic Venezuelan truffles!', '2023-11-25 14:45:00', 'CUS148', 'CHOC04');
INSERT INTO Review VALUES ('REV136', 9, 'Unique flavor in Peruvian chocolate', '2023-07-07 11:30:00', 'CUS149', 'CHOC05');




-- Question-B
/* Explain in simple words what each query does and make sure you comment it
 */

-- An example of an answer to a Query

/* This query prints the names of all chocolates */

Select ChocolateName
from Chocolate;

-- Query 1: A query involving a single table with one condition. Insert your answer below
-- This query retrieves the names and email addresses of all customers 
-- whose name is 'Jon Snow'.
SELECT CustomerName, CustomerEmail
FROM Customer
WHERE CustomerName = 'Jon Snow';



-- Query 2: A query involving a single table with two conditions, with one of the conditions that uses a wild card operator. Insert your answer below
-- This query selects customer names whose email contains 'example' 
-- and whose phone number starts with '123'.
SELECT CustomerName 
FROM Customer 
WHERE CustomerEmail LIKE '%example%' 
AND CustomerPhNum LIKE '123%';



-- Query 3: A query involving a join between at least two tables with an order by clause. Insert your answer below
-- This query retrieves the names of customers and the chocolates they reviewed, 
-- sorted by the review rating in descending order.
SELECT Customer.CustomerName, Chocolate.ChocolateName, Review.ReviewRating
FROM Customer
JOIN Review ON Customer.CustomerID = Review.CustomerID
JOIN Chocolate ON Review.ChocolateID = Chocolate.ChocolateID
ORDER BY Review.ReviewRating DESC;


-- Query 4: A query involving a single table with an aggregate and group by function. Insert your answer below
-- This query retrieves the ChocolateID and the average rating for each chocolate.
-- The reviews are grouped by the ChocolateID.
SELECT ChocolateID, AVG(ReviewRating) AS AvgRating
FROM Review
GROUP BY ChocolateID;

