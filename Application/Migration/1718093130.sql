CREATE TABLE readers (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    reader_name TEXT NOT NULL,
    introduction TEXT DEFAULT '' NOT NULL,
    loves UUID[] DEFAULT '{}' NOT NULL
);
CREATE INDEX readers_user_id_index ON readers (user_id);
ALTER TABLE readers ADD CONSTRAINT readers_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
