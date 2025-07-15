-- ---------------------------------------
-- DATABASE CREATION
-- ---------------------------------------
CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

-- ---------------------------------------
-- TABLE: Users
-- ---------------------------------------
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user'
);

-- ---------------------------------------
-- TABLE: Books
-- ---------------------------------------
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100),
    published_year INT,
    available BOOLEAN DEFAULT TRUE
);

-- ---------------------------------------
-- TABLE: IssuedBooks
-- ---------------------------------------
CREATE TABLE IssuedBooks (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    issue_date DATE DEFAULT CURRENT_DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ---------------------------------------
-- SAMPLE DATA
-- ---------------------------------------

-- Insert Users
INSERT INTO Users (username, password, role) VALUES
('admin', 'admin123', 'admin'),
('john_doe', 'john123', 'user'),
('alice', 'alice123', 'user');

-- Insert Books
INSERT INTO Books (title, author, published_year) VALUES
('C++ Primer', 'Stanley Lippman', 2013),
('Clean Code', 'Robert C. Martin', 2008),
('The Pragmatic Programmer', 'Andy Hunt', 1999),
('Introduction to Algorithms', 'Cormen', 2009);

-- ---------------------------------------
-- QUERIES & OPERATIONS
-- ---------------------------------------

-- 1. Login
-- Replace with user input values in app
SELECT * FROM Users WHERE username = 'john_doe' AND password = 'john123';

-- 2. View all books
SELECT * FROM Books;

-- 3. View available books only
SELECT * FROM Books WHERE available = TRUE;

-- 4. Issue a book (Book ID: 2, User ID: 2)
-- Step 1: Check if book is available
SELECT available FROM Books WHERE book_id = 2;

-- Step 2: Mark book as issued
UPDATE Books SET available = FALSE WHERE book_id = 2;

-- Step 3: Record in IssuedBooks
INSERT INTO IssuedBooks (book_id, user_id) VALUES (2, 2);

-- 5. Return a book (Book ID: 2, User ID: 2)
-- Step 1: Set return date
UPDATE IssuedBooks 
SET return_date = CURRENT_DATE 
WHERE book_id = 2 AND user_id = 2 AND return_date IS NULL;

-- Step 2: Mark book as available
UPDATE Books SET available = TRUE WHERE book_id = 2;

-- ---------------------------------------
-- REPORTS
-- ---------------------------------------

-- A. Books currently issued
SELECT 
    i.issue_id, b.title, u.username, i.issue_date
FROM 
    IssuedBooks i
JOIN 
    Books b ON i.book_id = b.book_id
JOIN 
    Users u ON i.user_id = u.user_id
WHERE 
    i.return_date IS NULL;

-- B. Overdue books (14+ days)
SELECT 
    b.title, u.username, i.issue_date,
    DATEDIFF(CURRENT_DATE, i.issue_date) AS overdue_days
FROM 
    IssuedBooks i
JOIN 
    Books b ON i.book_id = b.book_id
JOIN 
    Users u ON i.user_id = u.user_id
WHERE 
    i.return_date IS NULL
    AND DATEDIFF(CURRENT_DATE, i.issue_date) > 14;
