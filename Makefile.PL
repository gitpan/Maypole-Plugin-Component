use 5.006;
use ExtUtils::MakeMaker;

WriteMakefile(
    AUTHOR       => 'Sebastian Riedel <sri@oook.de>',
    NAME         => 'Maypole::Plugin::Component',
    VERSION_FROM => 'Component.pm',
    PREREQ_PM    => { Maypole => '2.0' }
);
