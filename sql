--sql--
//建立資料庫，使用
CREATE DATABASE LibraryDB;
USE LibraryDB;

//建立資料表
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    student_number VARCHAR(10),
    name VARCHAR(100),
    email VARCHAR(100)
);

//建立資料表
CREATE TABLE Book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    author VARCHAR(100),
    isbn VARCHAR(20),
    available BOOLEAN DEFAULT TRUE
);

//建立資料表
CREATE TABLE Borrow (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

//插入資料
INSERT INTO User (student_number, name, email) VALUES
('S01', '王小明', 'ming@example.com'),
('S02', '陳小美', 'mei@example.com'),
('S03', '張志強', 'chiang@example.com'),
('S04', '林惠文', 'huiwen@example.com'),
('S05', '李育誠', 'yucheng@example.com');

INSERT INTO Book (title, author, isbn) VALUES 
('資料庫系統概論', '陳大文', '9789861234567'),
('Python 程式設計', '李小強', '9789579876543'),
('線性代數', '王大明', '9789573210001'),
('系統分析與設計', '林小慧', '9789862233445'),
('網頁設計入門', '陳佩珊', '9789865678990');

INSERT INTO Borrow (user_id, book_id, borrow_date, return_date) VALUES
(1, 1, '2025-06-01', NULL),
(2, 2, '2025-06-02', '2025-06-08'),
(3, 3, '2025-06-05', NULL),
(4, 4, '2025-06-06', '2025-06-10'),
(5, 5, '2025-06-07', NULL),
(2, 5, '2025-06-10', NULL),
(1, 3, '2025-06-11', '2025-06-17');

//查詢未歸還書籍
SELECT u.student_number, u.name, b.title, br.borrow_date
FROM Borrow br
JOIN User u ON br.user_id = u.user_id
JOIN Book b ON br.book_id = b.book_id
WHERE br.return_date IS NULL;

//建立視圖
CREATE VIEW View_Unreturned AS
SELECT u.student_number, u.name, b.title, br.borrow_date
FROM Borrow br
JOIN User u ON br.user_id = u.user_id
JOIN Book b ON br.book_id = b.book_id
WHERE br.return_date IS NULL;

//模擬還書流程
START TRANSACTION;

UPDATE Borrow 
SET return_date = CURDATE()
WHERE user_id = 3 AND book_id = 3 AND return_date IS NULL;

UPDATE Book 
SET available = TRUE
WHERE book_id = 3;

COMMIT;
//查詢未歸還的書籍
SELECT title FROM Book WHERE available = FALSE;


SELECT * FROM Borrow WHERE return_date IS NULL;
SELECT * FROM Book;
