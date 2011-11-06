-- Convert schema '/home/songmu/dev/test/Jobeet/script/dev/../../sql/Jobeet-Schema-2-SQLite.sql' to '/home/songmu/dev/test/Jobeet/script/dev/../../sql/Jobeet-Schema-3-SQLite.sql':;

BEGIN;

ALTER TABLE jobeet_category ADD COLUMN slug VARCHAR(255) NOT NULL;

CREATE UNIQUE INDEX jobeet_category_slug02 ON jobeet_category (slug);


COMMIT;

