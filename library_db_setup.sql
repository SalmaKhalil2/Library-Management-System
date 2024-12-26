-- This script was created using MySQL to set up a library database.

CREATE DATABASE IF NOT EXISTS librart_DB;

USE  librart_DB;
CREATE TABLE Book (
    Book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    Quantity INT NOT NULL
);

CREATE TABLE Member (
    Member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE, 
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE Borrowing (
    Borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    Borrow_date DATE NOT NULL,
    Return_date DATE,
    Book_id INT NOT NULL,
    Member_id INT NOT NULL,
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id),
    FOREIGN KEY (Member_id) REFERENCES Member(Member_id)
);

CREATE TABLE Fine (
    Fine_id INT AUTO_INCREMENT PRIMARY KEY,
    Amount DECIMAL(10, 2) NOT NULL,
    Fine_date DATE NOT NULL,
    Paid_status VARCHAR(50) NOT NULL,
    Borrow_id INT NOT NULL,
    FOREIGN KEY (Borrow_id) REFERENCES Borrowing(Borrow_id)
);

INSERT INTO Book (title, author, Quantity) 
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 5),
('1984', 'George Orwell', 3),
('To Kill a Mockingbird', 'Harper Lee', 4),
('Moby Dick', 'Herman Melville', 2);
INSERT INTO Member (name, email, phone) 
VALUES 
('John Doe', 'johndoe@example.com', '1234567890'),
('Jane Smith', 'janesmith@example.com', '0987654321'),
('Michael Johnson', 'michaelj@example.com', '1122334455'),
('Emily Davis', 'emilyd@example.com', '5566778899');
INSERT INTO Borrowing (Borrow_date, Return_date, Book_id, Member_id) 
VALUES 
('2024-12-01', '2024-12-15', 1, 1),
('2024-12-05', '2024-12-20', 2, 2),
('2024-12-10', '2024-12-25', 3, 3),
('2024-12-12', '2024-12-26', 4, 4);
INSERT INTO Fine (Amount, Fine_date, Paid_status, Borrow_id) 
VALUES 
(5.00, '2024-12-16', 'Unpaid', 1),
(3.00, '2024-12-21', 'Paid', 2),
(7.50, '2024-12-24', 'Unpaid', 3),
(2.00, '2024-12-27', 'Unpaid', 4);
