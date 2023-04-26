-- Active: 1680283139327@@127.0.0.1@3306@uni
-- Active: 1680283139327@@127.0.0.1@3306@university
CREATE TABLE faculty (
  faculty_id INT AUTO_INCREMENT PRIMARY KEY,
  faculty_name VARCHAR(255) NOT NULL
);

CREATE TABLE laboratory (
  lab_id INT AUTO_INCREMENT PRIMARY KEY,
  lab_name VARCHAR(255) NOT NULL,
  faculty_id INT,
  FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

CREATE TABLE team (
  team_id INT AUTO_INCREMENT PRIMARY KEY,
  team_name VARCHAR(255) NOT NULL,
  lab_id INT,
  FOREIGN KEY (lab_id) REFERENCES laboratory(lab_id)
);

CREATE TABLE department (
  department_id INT AUTO_INCREMENT PRIMARY KEY,
  department_name VARCHAR(255) NOT NULL
);

CREATE TABLE member (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  member_name VARCHAR(255) NOT NULL,
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE team_member (
  team_id INT,
  member_id INT,
  PRIMARY KEY (team_id, member_id),
  FOREIGN KEY (team_id) REFERENCES team(team_id),
  FOREIGN KEY (member_id) REFERENCES member(member_id)
);

CREATE TABLE research_axis (
  axis_id INT AUTO_INCREMENT PRIMARY KEY,
  axis_name VARCHAR(255) NOT NULL
);

CREATE TABLE member_axis (
  member_id INT,
  axis_id INT,
  PRIMARY KEY (member_id, axis_id),
  FOREIGN KEY (member_id) REFERENCES member(member_id),
  FOREIGN KEY (axis_id) REFERENCES research_axis(axis_id)
);

CREATE TABLE article (
  article_id INT AUTO_INCREMENT PRIMARY KEY,
  article_title VARCHAR(255) NOT NULL,
  publication_date DATE NOT NULL
);

CREATE TABLE article_author (
  article_id INT,
  member_id INT,
  PRIMARY KEY (article_id, member_id),
  FOREIGN KEY (article_id) REFERENCES article(article_id),
  FOREIGN KEY (member_id) REFERENCES member(member_id)
);

CREATE TABLE keyword (
  keyword_id INT AUTO_INCREMENT PRIMARY KEY,
  keyword_name VARCHAR(255) NOT NULL
);

CREATE TABLE article_keyword (
  article_id INT,
  keyword_id INT,
  PRIMARY KEY (article_id, keyword_id),
  FOREIGN KEY (article_id) REFERENCES article(article_id),
  FOREIGN KEY (keyword_id) REFERENCES keyword(keyword_id)
);

CREATE TABLE publication (
  publication_id INT AUTO_INCREMENT PRIMARY KEY,
  publication_name VARCHAR(255) NOT NULL,
  publication_type ENUM('book', 'journal', 'conference') NOT NULL
);

CREATE TABLE publication_article (
  publication_id INT,
  article_id INT,
  PRIMARY KEY (publication_id, article_id),
  FOREIGN KEY (publication_id) REFERENCES publication(publication_id),
  FOREIGN KEY (article_id) REFERENCES article(article_id)
);

CREATE TABLE database_index (
  database_id INT AUTO_INCREMENT PRIMARY KEY,
  database_name VARCHAR(255) NOT NULL
);

CREATE TABLE database_publication (
  database_id INT,
  publication_id INT,
  PRIMARY KEY (database_id, publication_id),
  FOREIGN KEY (database_id) REFERENCES database_index(database_id),
  FOREIGN KEY (publication_id) REFERENCES publication(publication_id)
);

