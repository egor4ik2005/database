-- Таблица: Фильмы
CREATE TABLE IF NOT EXISTS movies (
    movie_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    genre TEXT NOT NULL,
    duration_minutes INTEGER NOT NULL,
    age_rating TEXT CHECK (age_rating IN ('0+', '6+', '12+', '16+', '18+'))
);

-- Таблица: Залы
CREATE TABLE IF NOT EXISTS halls (
    hall_id SERIAL PRIMARY KEY,
    seats_count INTEGER NOT NULL CHECK (seats_count > 0),
    screen_type TEXT NOT NULL,
    sound_system TEXT NOT NULL
);

-- Таблица: Сеансы
CREATE TABLE IF NOT EXISTS sessions (
    session_id SERIAL PRIMARY KEY,
    movie_id INTEGER REFERENCES movies(movie_id),
    hall_id INTEGER REFERENCES halls(hall_id),
    session_time TIMESTAMP NOT NULL,
    ticket_price NUMERIC(8,2) NOT NULL
);

-- Таблица: Клиенты
CREATE TABLE IF NOT EXISTS clients (
    client_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    bonus_points INTEGER DEFAULT 0,
    registration_date TIMESTAMP NOT NULL
);

-- Таблица: Сотрудники
CREATE TABLE IF NOT EXISTS employees (
    employee_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    position TEXT NOT NULL,
    salary NUMERIC(10,2) NOT NULL,
    hire_date DATE NOT NULL
);

-- Таблица: Билеты
CREATE TABLE IF NOT EXISTS tickets (
    ticket_id SERIAL PRIMARY KEY,
    session_id INTEGER REFERENCES sessions(session_id),
    client_id INTEGER REFERENCES clients(client_id),
    seat_number TEXT NOT NULL,
    purchase_date TIMESTAMP NOT NULL,
    payment_status TEXT CHECK (payment_status IN ('paid', 'unpaid', 'refunded'))
);

-- Таблица: Отзывы
CREATE TABLE IF NOT EXISTS reviews (
    review_id SERIAL PRIMARY KEY,
    client_id INTEGER REFERENCES clients(client_id),
    movie_id INTEGER REFERENCES movies(movie_id),
    rating NUMERIC(2,1) CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP NOT NULL
);

-- Таблица: История изменений сеансов (SCD Type 2)
CREATE TABLE IF NOT EXISTS session_history (
    history_id SERIAL PRIMARY KEY,
    session_id INTEGER REFERENCES sessions(session_id),
    ticket_price NUMERIC(8,2) NOT NULL,
    session_time TIMESTAMP NOT NULL,
    valid_from TIMESTAMP NOT NULL,
    valid_to TIMESTAMP
);
