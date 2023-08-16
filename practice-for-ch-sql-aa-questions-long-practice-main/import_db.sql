PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULl 
);

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL, -- subject question
    body TEXT,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    reg_reply TEXT,
    user_id INTEGER NOT NULL,
    
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id TEXT NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('John', 'Doe'),
    ('Jane', 'Doe');

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('AA project', 'How to create DB', 1),
    ('What is grass', 'Is it real', 2);

INSERT INTO
    question_follows (user_id, question_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 2);

INSERT INTO
    replies (question_id, parent_reply_id, reg_reply, user_id)
VALUES
    ( 1, NULL, 'good luck', 2),
    ( 2, NULL, 'it is fake', 1),
    ( 1, 1, 'very helpful', 1);

INSERT INTO
    question_likes (user_id, question_id)
VALUES
    (1, 2),
    (2, 1);