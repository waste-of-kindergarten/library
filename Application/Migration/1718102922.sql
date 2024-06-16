CREATE TABLE comments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    reader_id UUID NOT NULL,
    book_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    "comment" TEXT NOT NULL
);
CREATE INDEX comments_reader_id_index ON comments (reader_id);
CREATE INDEX comments_book_id_index ON comments (book_id);
ALTER TABLE comments ADD CONSTRAINT comments_ref_book_id FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE NO ACTION;
ALTER TABLE comments ADD CONSTRAINT comments_ref_reader_id FOREIGN KEY (reader_id) REFERENCES readers (id) ON DELETE NO ACTION;
