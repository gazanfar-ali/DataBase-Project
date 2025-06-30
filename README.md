## 💼 Job Portal Database System

Welcome to the **Job Portal Database System**, a well-structured SQL-based backend project designed to manage job seekers, employers, job postings, applications, 
and skills — all within a real-world job portal model like **Rozee.pk** or **LinkedIn Jobs**.


## 📌 Project Overview

This database system is developed using **Microsoft SQL Server Management Studio (SSMS)** and provides a robust relational structure to support:

- 👤 **Job Seekers** — Register, upload resumes, list skills, apply for jobs
- 🏢 **Employers** — Post jobs, view applications, manage recruitment
- 📝 **Applications** — Submitted by job seekers to job posts
- 💡 **Skills** — Many-to-many relationship with seekers

The schema uses **normalization**, **primary/foreign keys**, and **indexing** to ensure data integrity, scalability, and performance.


## 🛠️ Features Implemented

- 🔐 **Role-based access**: Employers vs Job Seekers
- 🔄 **Many-to-many & one-to-many** relationships
- 📁 **Resume and skill management**
- 📬 **Application tracking with status updates**
- 🧱 **Secure and normalized structure**



## 🧾 SQL Concepts Used

| Category | Commands |
|----------|----------|
| **DDL**  | `CREATE`, `ALTER`, `DROP` |
| **DML**  | `INSERT`, `SELECT`, `UPDATE`, `DELETE` |
| **DCL**  | `GRANT`, `REVOKE` |
| **Other**| `JOIN`, `GROUP BY`, `INDEX`, `CHECK`, `IDENTITY`, `CONSTRAINTS` |



## 🧩 Entity Relationships

The database includes key entities like:

- `Users` (Job Seeker / Employer)
- `Jobs`
- `Applications`
- `Skills`
- `JobSeekerSkills` (bridge table for many-to-many)

Relationship Types:
- One-to-One: `Users` ↔ `JobSeekers` / `Employers`
- One-to-Many: `Employers` → `Jobs`
- Many-to-Many: `JobSeekers` ↔ `Skills`

---

## 🌐 Real-World Relevance

This project simulates the backend of platforms like:

- ✅ **Rozee.pk**
- ✅ **Indeed**
- ✅ **LinkedIn Jobs**

It can be extended into a complete **web or mobile job portal** with features like filtering, search, and resume parsing.

---

## 📎 How to Use

1. Clone the repo or download the SQL files.
2. Open in **SSMS**.
3. Execute the provided scripts to create and populate the database.
4. Use `SELECT`, `JOIN`, and other queries to interact with the data.

---

## 📚 Authors

- 👨‍🎓 Muhammad Habeel — F2023376005  
- 👨‍🎓 Gazanfar Ali — F2023376013  

---

## 🏁 Final Words

This project not only fulfills academic requirements but is also highly relevant for real-world HR systems, freelance platforms, and job search engines. 
It’s clean, scalable, and ready to plug into your next job portal app! 🚀
