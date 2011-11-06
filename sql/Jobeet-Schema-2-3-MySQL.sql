-- Convert schema '/home/songmu/dev/test/Jobeet/script/dev/../../sql/Jobeet-Schema-2-MySQL.sql' to 'Jobeet::Schema v2':;

BEGIN;

ALTER TABLE jobeet_category ADD COLUMN slug VARCHAR(255) NOT NULL,
                            ADD UNIQUE jobeet_category_slug (slug);


COMMIT;

