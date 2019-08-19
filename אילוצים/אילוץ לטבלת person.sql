alter table  lawyer add constraint CHK_SPECIAL
CHECK( SPECIALIZATION in ('labor', 'criminal', 'commercial', 'family'));
