-- Convert schema '/home/songmu/dev/test/Jobeet/script/dev/../../sql/Jobeet-Schema-1-MySQL.sql' to 'Jobeet::Schema v1':;

BEGIN;

ALTER TABLE jobeet_job ADD COLUMN company VARCHAR(255),
                       ADD COLUMN logo VARCHAR(255),
                       ADD COLUMN url VARCHAR(255);


COMMIT;

