CREATE DATABASE Library;
USE Library;

CREATE TABLE BRANCH (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20)
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, '123 ABC', '9669566585'),
(2, 102, '456 DEF', '9895352147'),
(3, 103, '789 GHI', '8596647328');

SELECT * FROM Branch;

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(101, 'Adith', 'Manager', 60000, 1),
(102, 'Siddharth', 'Clerk', 45000, 2),
(103, 'Jagan', 'Clerk', 50000, 1),
(104, 'Alisha', 'Manager', 70000, 2),
(105, 'Chandrika', 'Clerk', 55000, 3);


SELECT * FROM Employee;

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(201, 'Mukesh', '456 Neem Rd,Mumbai, Maharashtra, India', '2021-05-15'),
(202, 'Esha', '789 Banyan Rd,Bengaluru, Karnataka, India', '2022-03-20'),
(203, 'Devesh', '101 Ashoka Rd,New Delhi, Delhi, India', '2023-01-10'),
(204, 'Omkar', '202 Peepal Rd,Kolkata, West Bengal, India', '2022-11-05'),
(205, 'Sarla', '303 Gulmohar Rd,Jaipur, Rajasthan, India', '2021-08-28');

SELECT * FROM Customer;


CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(301, 201, 'History of World', '2022-02-10', 1001),
(302, 203, 'Introduction to SQL', '2022-12-05', 1002),
(303, 204, 'Mystery at Midnight', '2023-03-15', 1003),
(304, 205, 'Science Explained', '2022-09-20', 1004),
(305, 202, 'Romantic Escapes', '2021-11-30', 1005);

SELECT * FROM IssueStatus;

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(401, 201, 'History of World', '2022-03-01', 1001),
(402, 203, 'Introduction to SQL', '2023-01-15', 1002),
(403, 204, 'Mystery at Midnight', '2023-04-02', 1003),
(404, 205, 'Science Explained', '2022-10-10', 1004),
(405, 202, 'Romantic Escapes', '2022-01-10', 1005);

SELECT * FROM ReturnStatus;

CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
(1001, 'History of World', 'History', 10.99, 'yes', 'John Historian', 'World Publishers'),
(1002, 'Introduction to SQL', 'Technology', 12.99, 'yes', 'Alice Techie', 'Tech Books Ltd'),
(1003, 'Mystery at Midnight', 'Mystery', 8.99, 'no', 'Sara Sleuth', 'Mysterious Press'),
(1004, 'Science Explained', 'Science', 14.99, 'yes', 'Bob Scientist', 'SciTech Publishing'),
(1005, 'Romantic Escapes', 'Romance', 9.99, 'no', 'Emma Romance', 'Love Stories Inc');

#1. Retrieve the book title, category, and rental price of all available books.

SELECT Book_title, Category, Rental_Price FROM Books WHERE Status = 'yes';

#2. List the employee names and their respective salaries in descending order of salary.

SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

#3. Retrieve the book titles and the corresponding customers who have issued those books.

SELECT Issued_Book_name,Issue_Id FROM IssueStatus;

#4. Display the total count of books in each category.

SELECT Category, COUNT(*) AS Total_Books FROM Books GROUP BY Category;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT Emp_name, Position FROM Employee WHERE Salary > 50000;

#6. List the customer names who registered before 2022-01-01 and have not issued any books yet.

SELECT Customer_name FROM Customer WHERE Reg_date<2022-01-01 AND Customer_id NOT IN (SELECT Issued_cust FROM IssueStatus);

#7. Display the branch numbers and the total count of employees in each branch.

SELECT E.Branch_no, COUNT(*) AS Total_Employees FROM Employee AS E GROUP BY E.Branch_no;

#8. Display the names of customers who have issued books in the month of June 2023.

SELECT C.Customer_name FROM IssueStatus AS I
JOIN Customer AS C ON I.Issued_cust = C.Customer_Id WHERE MONTH(I.Issue_date) = 6 AND YEAR(I.Issue_date) = 2023;

#9. Retrieve book_title from book table containing history.

SELECT Book_title FROM Books WHERE Category = 'history';

#10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees

SELECT E.Branch_no, COUNT(*) AS Total_Employees FROM Employee AS E GROUP BY E.Branch_no HAVING Total_Employees > 5;
