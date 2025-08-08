CREATE DATABASE JobPortalDB;

USE JobPortalDB;


CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100),
    Phone VARCHAR(20),
    UserType VARCHAR(20) CHECK (UserType IN ('Employer', 'JobSeeker'))
);
select * from Users;


CREATE TABLE JobSeekers (
    UserID INT PRIMARY KEY,
    Resume TEXT,
    ExperienceLevel VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
select * from JobSeekers;


CREATE TABLE Employers (
    UserID INT PRIMARY KEY,
    CompanyName VARCHAR(100),
    CompanyAddress VARCHAR(200),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
select * from Employers;


CREATE TABLE Skills (
    SkillID INT PRIMARY KEY IDENTITY(1,1),
    SkillName VARCHAR(50)
);
select * from Skills;


CREATE TABLE JobSeekerSkills (
    UserID INT,
    SkillID INT,
    PRIMARY KEY (UserID, SkillID),
    FOREIGN KEY (UserID) REFERENCES JobSeekers(UserID),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID)
);
select * from JobSeekerSkills;


CREATE TABLE Jobs (
    JobID INT PRIMARY KEY IDENTITY(1,1),
    EmployerID INT,
    JobTitle VARCHAR(100),
    JobDescription TEXT,
    JobType VARCHAR(20),
    Salary DECIMAL(10,2),
    Location VARCHAR(100),
    PostedDate DATE,
    FOREIGN KEY (EmployerID) REFERENCES Employers(UserID)
);
select * from Jobs;


CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY IDENTITY(1,1),
    JobID INT,
    JobSeekerID INT,
    ApplicationDate DATE,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Reviewed', 'Accepted', 'Rejected')),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (JobSeekerID) REFERENCES JobSeekers(UserID)
);
select * from Applications;


INSERT INTO Users (FullName, Email, Password, Phone, UserType)
VALUES
('Ali Raza', 'ali@example.com', 'pass123', '03001234567', 'JobSeeker'),
('Sara Khan', 'sara@example.com', 'pass456', '03002345678', 'JobSeeker'),
('Umar Iqbal', 'umar@example.com', 'pass789', '03003456789', 'JobSeeker'),
('TechCorp HR', 'hr@techcorp.com', 'tech123', '03007654321', 'Employer'),
('WebSolutions HR', 'hr@websol.com', 'web123', '03009876543', 'Employer'),
('EduTech HR', 'hr@edutech.com', 'edu123', '03001112222', 'Employer'),
('Admin User', 'admin@portal.com', 'adminpass', '03009999999', 'JobSeeker'),
('Random Employer', 'rand@emp.com', 'randpass', '03004445555', 'Employer');


INSERT INTO JobSeekers (UserID, Resume, ExperienceLevel)
VALUES
(1, 'Experienced Python developer', 'Intermediate'),
(2, 'Frontend developer with HTML/CSS/JS skills', 'Beginner'),
(3, 'C++ and SQL programmer', 'Advanced');


INSERT INTO Employers (UserID, CompanyName, CompanyAddress)
VALUES
(4, 'TechCorp', 'Lahore, Pakistan'),
(5, 'WebSolutions', 'Karachi, Pakistan'),
(6, 'EduTech', 'Islamabad, Pakistan');


INSERT INTO Skills (SkillName)
VALUES ('Python'), ('SQL'), ('HTML'), ('C++'), ('JavaScript');


INSERT INTO JobSeekerSkills (UserID, SkillID)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 5),
(3, 2),
(3, 4);


INSERT INTO Jobs (EmployerID, JobTitle, JobDescription, JobType, Salary, Location, PostedDate)
VALUES
(4, 'Python Developer', 'Looking for a Python dev with SQL skills', 'Full-time', 60000, 'Lahore', GETDATE()),
(5, 'Frontend Developer', 'HTML/CSS/JS required for UI design', 'Part-time', 40000, 'Karachi', GETDATE()),
(6, 'C++ Developer', 'Experienced C++ programmer for embedded systems', 'Full-time', 75000, 'Islamabad', GETDATE()),
(4, 'SQL Analyst', 'Data analysis and reporting using SQL', 'Full-time', 55000, 'Lahore', GETDATE()),
(5, 'Junior Web Dev', 'Assist in frontend development', 'Internship', 20000, 'Remote', GETDATE()),
(6, 'Technical Writer', 'Create manuals for software projects', 'Contract', 30000, 'Remote', GETDATE());


INSERT INTO Applications (JobID, JobSeekerID, ApplicationDate, Status)
VALUES
(1, 1, GETDATE(), 'Pending'),
(2, 2, GETDATE(), 'Reviewed'),
(3, 3, GETDATE(), 'Pending'),
(4, 1, GETDATE(), 'Accepted'),
(5, 2, GETDATE(), 'Rejected'),
(6, 3, GETDATE(), 'Pending'),
(2, 1, GETDATE(), 'Reviewed'),
(1, 3, GETDATE(), 'Rejected');


UPDATE Jobs WITH (ROWLOCK, XLOCK)
SET Salary = Salary + 1000
WHERE JobID = 1;


SELECT 
    A.ApplicationID,
    U.FullName AS JobSeekerName,
    U.Email AS JobSeekerEmail,
    J.JobTitle,
    E.CompanyName,
    A.ApplicationDate,
    A.Status
FROM Applications A
JOIN JobSeekers JS ON A.JobSeekerID = JS.UserID
JOIN Users U ON JS.UserID = U.UserID
JOIN Jobs J ON A.JobID = J.JobID
JOIN Employers E ON J.EmployerID = E.UserID;


CREATE LOGIN job_user WITH PASSWORD = 'StrongPass123';
CREATE USER job_user FOR LOGIN job_user;

GRANT SELECT, INSERT, UPDATE, DELETE ON Users TO job_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON Jobs TO job_user;

REVOKE UPDATE, DELETE ON Applications FROM job_user;


EXECUTE AS USER = 'job_user';
SELECT USER_NAME(), SUSER_NAME(), IS_MEMBER('db_datareader') AS IsReader;
REVERT;


SELECT name, type_desc 
FROM sys.database_principals 
WHERE name = 'job_user';
