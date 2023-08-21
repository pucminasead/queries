--Query para extrair dados do aluno para o projeto PUVConnect

DECLARE @cod_matricula INT;

SELECT @cod_matricula = cod_aluno
FROM SGA_EAD..aluno
WHERE cod_pessoa = xxxxxx;

WITH 
	student_data AS (
		SELECT	*
		FROM	SGA_EAD..aluno
		WHERE	cod_aluno = @cod_matricula
	),

	turma AS (
		SELECT DISTINCT	m.seq_turma, t.num_turma, cod_aluno
		FROM	SGA_EAD..matricula AS m
		JOIN (
			SELECT seq_turma, RIGHT(seq_turma, 2) AS num_turma, nom_disciplina
			FROM SGA_EAD..matricula
			WHERE RIGHT(seq_turma, 2) <> '00'
				AND nom_disciplina LIKE 'Projeto: %'
				AND dat_cancelamento IS NULL
				AND ano_turma = 2023 AND sem_turma = 1
		) AS t ON m.seq_turma = t.seq_turma
		WHERE	cod_aluno = @cod_matricula
				AND sem_turma = 1
				AND ano_turma = YEAR(GETDATE())
	),

	disciplinas AS (
		SELECT	STRING_AGG(nom_disciplina, ' | ') AS 'disciplinas matriculadas', cod_aluno
		FROM	SGA_EAD..matricula
		WHERE	cod_aluno = @cod_matricula
				AND ano_turma = YEAR(GETDATE())
				AND sem_turma = 1
		GROUP BY cod_aluno
	)


SELECT DISTINCT sd.nom_aluno AS 'Nome', sd.cod_aluno AS 'Matricula', sd.dat_inclusao AS 'Data da matricula',
	sd.tel_celular AS 'Telefone', sd.dsc_Email AS 'Emails', sd.dat_ultimo_acesso_ava AS 'Ultimo acesso',
	t.seq_turma AS 'Turma', t.num_turma AS 'Numero Turma', d.[disciplinas matriculadas]
FROM student_data AS sd
JOIN turma AS t ON sd.cod_aluno = t.cod_aluno
JOIN disciplinas AS d ON sd.cod_aluno = d.cod_aluno;
