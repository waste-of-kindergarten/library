-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
CREATE TABLE books (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    book_name TEXT NOT NULL,
    author TEXT NOT NULL,
    category TEXT NOT NULL,
    publication_year INT NOT NULL,
    press TEXT DEFAULT '' NOT NULL,
    tags TEXT[] DEFAULT '{}' NOT NULL,
    size INT DEFAULT 0 NOT NULL
);
CREATE TABLE readers (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    reader_name TEXT NOT NULL,
    introduction TEXT DEFAULT '' NOT NULL,
    loves UUID[] DEFAULT '{}' NOT NULL
);
CREATE INDEX readers_user_id_index ON readers (user_id);
CREATE TABLE comments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    reader_id UUID NOT NULL,
    book_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    "comment" TEXT NOT NULL
);
CREATE INDEX comments_reader_id_index ON comments (reader_id);
CREATE INDEX comments_book_id_index ON comments (book_id);
ALTER TABLE comments ADD CONSTRAINT comments_ref_book_id FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE NO ACTION;
ALTER TABLE comments ADD CONSTRAINT comments_ref_reader_id FOREIGN KEY (reader_id) REFERENCES readers (id) ON DELETE NO ACTION;
ALTER TABLE readers ADD CONSTRAINT readers_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
