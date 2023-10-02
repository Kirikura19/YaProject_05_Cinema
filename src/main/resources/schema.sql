-- Создание таблицы User
CREATE TABLE IF NOT EXISTS "User" (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    login VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    birthday DATE NOT NULL,
    CONSTRAINT valid_email CHECK (position('@' IN email) > 0 AND position('.' IN email) > position('@' IN email)), -- Проверка формата email
    CONSTRAINT valid_birthday CHECK (birthday <= CURRENT_DATE), -- Проверка на дату рождения, которая не наступила
    CONSTRAINT min_login_length CHECK (LENGTH(login) >= 6) -- Минимальная длина логина
    );

-- Создание таблицы Film
CREATE TABLE IF NOT EXISTS Film (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(200),
    releaseDate DATE NOT NULL,
    duration BIGINT CHECK (duration >= 1),
    user_id INTEGER REFERENCES "User"(id)
    );

CREATE TABLE IF NOT EXISTS Friendship (
    user_id1 INTEGER,
    user_id2 INTEGER,
    PRIMARY KEY (user_id1, user_id2),
    FOREIGN KEY (user_id1) REFERENCES "User"(id),
    FOREIGN KEY (user_id2) REFERENCES "User"(id)
    );
