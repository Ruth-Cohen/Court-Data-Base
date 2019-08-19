alter table lawyer add constraint chk_special
check( specialization in ('labor','criminal','commercial','family'));
