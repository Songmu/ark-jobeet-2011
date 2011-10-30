use inc::Module::Install;

name 'Jobeet';
all_from 'lib/Jobeet.pm';

requires 'Path::AttrRouter';
requires 'Ark';

requires 'Text::MicroTemplate::Extended';
requires 'DateTime';
requires 'FindBin::libs';
requires 'DBIx::Class';
requires 'DBIx::Class::Cursor::Cached';
requires 'SQL::Translator';
requires 'DBD::mysql';
requires 'DateTime::Format::MySQL';

requires 'IO::Prompt';

requires 'Text::MicroTemplate::DataSection';
requires 'String::CamelCase';

tests 't/*.t';
author_tests 'xt';

auto_set_repository;
auto_include;

WriteAll;
