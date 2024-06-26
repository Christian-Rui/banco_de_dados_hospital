use hospital_database;
/*
ALTER TABLE medicos ADD COLUMN em_atividade BOOLEAN DEFAULT TRUE;
*/
SET SQL_SAFE_UPDATES = 0;
UPDATE medicos SET em_atividade = FALSE WHERE id_medico IN (1, 8);

UPDATE medicos SET em_atividade = TRUE WHERE id_medico NOT IN (1, 8);
SET SQL_SAFE_UPDATES = 1;

select * from medicos;

