-- Active: 1680283139327@@127.0.0.1@3306@univ
CREATE TABLE faculty (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);


CREATE TABLE laboratory (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  faculty_id INT,
  FOREIGN KEY (faculty_id) REFERENCES faculty(id) on DELETE CASCADE
);


CREATE TABLE team (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  lab_id INT,
  FOREIGN KEY (lab_id) REFERENCES laboratory(id) on DELETE CASCADE
);


CREATE TABLE researcher (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES department(id) on DELETE CASCADE
);


CREATE TABLE researcher_team (
  team_id INT,
  researcher_id INT,
  PRIMARY KEY (team_id, researcher_id),
  FOREIGN KEY (team_id) REFERENCES team(id) on DELETE CASCADE,
  FOREIGN KEY (researcher_id) REFERENCES researcher(id) on DELETE CASCADE
);

CREATE TABLE focus (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);


CREATE TABLE researcher_focus (
  focus_id INT,
  researcher_id INT,
  PRIMARY KEY (focus_id, researcher_id),
  FOREIGN KEY (focus_id) REFERENCES focus(id) on DELETE CASCADE,
  FOREIGN KEY (researcher_id) REFERENCES researcher(id) on DELETE CASCADE
);


CREATE TABLE article (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  publication_date DATE NOT NULL,
  journal_id INT,
  database_id INT,
  UNIQUE (journal_id, title),
  FOREIGN KEY (journal_id) REFERENCES journal(id) on DELETE CASCADE,
  FOREIGN KEY (database_id) REFERENCES databas(id) on DELETE CASCADE
);


CREATE TABLE keyword (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);


CREATE TABLE article_keyword (
  article_id INT,
  keyword_id INT,
  PRIMARY KEY (article_id, keyword_id),
  FOREIGN KEY (article_id) REFERENCES article(id) on DELETE CASCADE,
  FOREIGN KEY (keyword_id) REFERENCES keyword(id) on DELETE CASCADE
);

CREATE TABLE Databas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);


CREATE TABLE book (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);


CREATE TABLE journal (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);


CREATE TABLE conference (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);


CREATE TABLE article_researcher (
  article_id INT,
  researcher_id INT,
  PRIMARY KEY (article_id, researcher_id),
  FOREIGN KEY (article_id) REFERENCES article(id) on DELETE CASCADE,
  FOREIGN KEY (researcher_id) REFERENCES researcher(id) on DELETE CASCADE
);


CREATE TABLE journal_database (
  journal_id INT,
  databas_id int NOT NULL,
  PRIMARY KEY (journal_id, databas_id),
  FOREIGN KEY (journal_id) REFERENCES journal(id) on DELETE CASCADE,
  Foreign Key (databas_id) REFERENCES databas(id) on DELETE CASCADE
);


CREATE TABLE conference_database (
  conference_id INT,
  databas_id int NOT NULL,
  PRIMARY KEY (conference_id, databas_id),
  FOREIGN KEY (conference_id) REFERENCES conference(id) on DELETE CASCADE,
  Foreign Key (databas_id) REFERENCES databas(id) on DELETE CASCADE
);


CREATE TABLE department (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);


CREATE TABLE book_article (
  book_id INT,
  article_id INT,
  PRIMARY KEY (book_id, article_id),
  FOREIGN KEY (book_id) REFERENCES book(id) on DELETE CASCADE,
  FOREIGN KEY (article_id) REFERENCES article(id) on DELETE CASCADE
);



-- Insert random data into faculty table
INSERT INTO faculty (name) VALUES
('Computer Science'),
('Mathematics'),
('Biology'),
('Chemistry');
-- Insert random data into laboratory table
INSERT INTO laboratory (name, faculty_id) VALUES
('Computer Vision Lab', 1),
('Artificial Intelligence Lab', 1),
('Algorithms and Complexity Lab', 2),
('Applied Mathematics Lab', 2),
('Molecular Biology Lab', 3),
('Ecology and Evolution Lab', 3),
('Organic Chemistry Lab', 4),
('Inorganic Chemistry Lab', 4);
-- Insert random data into team table
INSERT INTO team (name, lab_id) VALUES
('Computer Vision Team', 1),
('Artificial Intelligence Team', 2),
('Algorithms Team', 3),
('Mathematical Modeling Team', 4),
('Molecular Biology Team', 5),
('Ecology Team', 6),
('Organic Chemistry Team', 7),
('Inorganic Chemistry Team', 8);
-- Insert random data into department table
INSERT INTO department (name) VALUES
('Computer Science Department'),
('Mathematics Department'),
('Biology Department'),
('Chemistry Department');
-- Insert random data into researcher table
INSERT INTO researcher (name, department_id) VALUES
('John Doe', 1),
('Jane Smith', 1),
('Bob Johnson', 2),
('Alice Lee',3),
('Sarah Davis', 3),
('Michael Wilson', 4),
('Emily Taylor', 4);
-- Insert random data into researcher_team table
INSERT INTO researcher_team (team_id, researcher_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 3),
(3, 4),
(4, 3),
(4, 4),
(5, 6),
(6, 5),
(6, 6),
(7, 7),
(8, 7),
(8, 2);
-- Insert random data into focus table
INSERT INTO focus (name) VALUES
('Computer Vision'),
('Machine Learning'),
('Algorithms'),
('Mathematical Modeling'),
('Molecular Biology'),
('Ecology'),
('Organic Chemistry'),
('Inorganic Chemistry');
-- Insert random data into researcher_focus table
INSERT INTO researcher_focus (focus_id, researcher_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 3),
(3, 4),
(4, 3),
(4, 4),
(5, 5),
(5, 6),
(6, 5),
(6, 6),
(7, 7),
(8, 7),
(8, 2);
-- Insert random data into article table
INSERT INTO article (title, publication_date, journal_id, database_id) VALUES
('Article 1', '2022-01-01', 1, 2),
('Article 2', '2022-02-01', 1, 2),
('Article 3', '2022-03-01', 2, 2),
('Article 4', '2022-04-01', 2, 2),
('Article 5', '2022-05-01', 3, 2),
('Article 6', '2022-06-01', 3, 2),
('Article 7', '2022-07-01', 1, 3),
('Article 8', '2022-08-01', 1, 3),
('Article 11', '2022-11-01', 3, 3),
('Article 12', '2022-12-01', 3, 3);
-- Insert random data into keyword table
INSERT INTO keyword (name) VALUES
('Computer Vision'),
('Machine Learning'),
('Algorithms'),
('Mathematical Modeling'),
('Molecular Biology'),
('Ecology'),
('Organic Chemistry'),
('Inorganic Chemistry');
-- Insert random data into article_keyword table
INSERT INTO article_keyword (article_id, keyword_id) VALUES
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(13, 3),
(13, 4),
(14, 3),
(14, 4),
(15, 5),
(15, 6),
(16, 5),
(16, 6),
(17, 7),
(18, 3),
(19, 4),
(20, 3),
(20, 4);
-- Insert random data into journal_database table
INSERT INTO journal_database (journal_id, databas_id) VALUES
(1, 3),
(1, 1),
(2, 1),
(2, 3),
(3, 2),
(3, 3);
-- Insert random data into conference_database table
INSERT INTO conference_database (conference_id, databas_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 2),
(3, 3);
-- Insert random data into book table
INSERT INTO book (name) VALUES
('Book 1'),
('Book 2'),
('Book 3');
-- Insert random data into book_article table
INSERT INTO book_article (book_id, article_id) VALUES
(1, 11),
(2, 12),
(3, 13);

INSERT INTO journal (name) VALUES
('Journal of Computer Science'),
('Mathematical Journal'),
('Journal of Molecular Biology'),
('Chemical Journal');


INSERT INTO databas (name) VALUES
('Database 1'),
('Database 2'),
('Database 3');

INSERT INTO conference (name) VALUES
('International Conference on Computer Science'),
('Mathematical Modeling and Analysis Conference'),
('Molecular Biology Symposium'),
('Chemical Engineering Conference');

INSERT INTO article_researcher (article_id, researcher_id) VALUES
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(13, 3),
(13, 4),
(14, 3),
(14, 4),
(15, 5),
(15, 6),
(16, 5),
(16, 6),
(17, 7),
(17, 4),
(18, 7),
(18, 3),
(19, 4),
(20, 3),
(20, 4);





--Select all researchers belonging to a specific laboratory.
SELECT r.name 
FROM researcher r,researcher_team rt,team t,laboratory l
WHERE  r.id=rt.researcher_id
AND rt.team_id = t.id
AND t.lab_id=l.id
AND l.name = 'Computer Vision Lab';


--Select all articles written by a specific researcher.
SELECT a.title , a.publication_date
FROM article a, article_researcher ar, researcher r
WHERE a.id = ar.article_id
AND ar.researcher_id = r.id
AND r.name = 'John Doe';


--Add a new researcher to a specific team.
INSERT INTO researcher_team (team_id, researcher_id)
VALUES (1, 5);



--Update the title of a specific article.
UPDATE article
SET title = 'New Title'
WHERE id = 1;




--Delete a specific keyword.
DELETE FROM keyword
WHERE name = 'Mathematical Modeling';



--Select all researchers belonging to a specific department and sort the results in alphabetical order.
SELECT name 
FROM researcher
WHERE department_id = 1
ORDER BY name ;



--Select all articles published in a specific journal and sort the results in chronological order.
SELECT title , publication_date
FROM article
WHERE journal_id = 1
ORDER BY publication_date ;



--Select all research laboratories indexed in a specific database.
SELECT DISTINCT l.name AS laboratory_name
FROM laboratory l, team t, researcher_team rt, researcher r, article_researcher ar, article a, article_confrence ac, journal_database jd, conference_database cd
WHERE l.id = t.lab_id
AND t.id = rt.team_id
AND rt.researcher_id = r.id
AND r.id = ar.researcher_id
AND ar.article_id = a.id
AND ((a.journal_id = jd.journal_id AND jd.databas_id = 1) OR (ac.conference_id = cd.conference_id AND cd.databas_id = 1))
AND l.name="Computer Vision Labx";

CREATE Table article_confrence(
    article_id INT NOT NULL,
    conference_id INT NOT NULL,
    PRIMARY KEY (article_id,conference_id),
    Foreign Key (article_id) REFERENCES article(id),
    Foreign Key (conference_id) REFERENCES conference(id)
);

INSERT INTO article_confrence (article_id,conference_id) VALUES
(11,2),
(12,4),
(14,3),
(18,2),
(16,4)
;


DROP DATABASE univ;
