CREATE DATABASE aws_test;
CREATE TABLE accounts (
  user_id serial PRIMARY KEY,
  username VARCHAR ( 50 ) UNIQUE NOT NULL,
  email VARCHAR ( 255 ) UNIQUE NOT NULL
);
INSERT INTO accounts (username, email)
VALUES ('test1','test1@mail.com'), ('test2','test2@mail.com'), ('test3','test3@mail.com');
SELECT * FROM accounts
