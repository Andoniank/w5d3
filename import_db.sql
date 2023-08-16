PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULl 
);

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL, -- subject question
    body TEXT,

    FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    subj TEXT NOT NULL,
    parent_reply TEXT,
    user_id INTEGER NOT NULL,
    questions_body TEXT NOT NULL,
    reg_reply TEXT,

    FOREIGN KEY (subj) REFERENCES questions(title)
    FOREIGN KEY (parent_reply) REFERENCES replies(parent_reply)
    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (questions_body) REFERENCES questions(body)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    like_question BOOLEAN,
    user_id INTEGER NOT NULL,
    questions_id TEXT NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('John', 'Doe'),
    ('Jane', 'Doe');

INSERT INTO
    questions (title, body)
VALUES
    ('AA project', 'How to create DB'),
    ('What is grass', 'Is it real');

INSERT INTO
    question_follows (user_id, questions_id)
VALUES
    (1, 1)
    (2, 2)

INSERT INTO
    replies (subj, questions_body, parent_reply, reg_reply, user_id)
VALUES
    ('AA project', 'How to create DB', NULL, 'good luck', 2)
    ('What is grass', 'Is it real', NULL, 'it is fake', 1)
    ('AA project', 'How to create DB', 'good luck', 'very helpful', 1)

INSERT INTO
    question_likes (question_likes, user_id, questions_id)
VALUES
    (TRUE, 1, 2)
    (TRUE, 2, 1)