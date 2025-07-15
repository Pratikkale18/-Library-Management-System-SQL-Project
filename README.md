# -Library-Management-System-SQL-Project

A simple Library Management System using **pure SQL**. Manages users, books, book issuance, and returns using relational database principles.

📌 Features

- 👤 User & Admin roles
- 📚 Add/View/Manage books
- 🔄 Issue & Return books
- 📊 Track overdue and current issued books


 🛠️ Technologies Used

- 💾 MySQL (also works with MariaDB/PostgreSQL)
- 🧠 SQL queries (DDL + DML + JOINs)

🗃️ Tables

### `Users`
- `user_id` (INT, PK)
- `username` (VARCHAR)
- `password` (VARCHAR)
- `role` ('admin' or 'user')

### `Books`
- `book_id` (INT, PK)
- `title`, `author`, `published_year`
- `available` (BOOLEAN)

### `IssuedBooks`
- `issue_id` (INT, PK)
- `book_id` (FK)
- `user_id` (FK)
- `issue_date`, `return_date`

---

📦 Setup

### Step 1: Clone and Open
```bash
git clone https://github.com/yourusername/library-management-system-sql.git
cd library-management-system-sql

🙋 Author
Made with ❤️ by Pratik Kale
GitHub: @Pratikkale18
