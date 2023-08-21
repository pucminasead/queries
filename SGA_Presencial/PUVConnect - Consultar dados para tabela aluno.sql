--Query para extrair dados do aluno para o projeto PUVConnect

DECLARE @cod_matricula INT;

SELECT @cod_matricula = cod_aluno
FROM SGA_EAD..aluno
WHERE cod_pessoa = xxxxxx;

WITH 
student_data AS (
	SELECT	*
	FROM	SGA_PRESENCIAL..aluno
	WHERE	cod_aluno = @cod_matricula
),

turma AS (
	SELECT DISTINCT	m.seq_turma, t.num_turma
	FROM	SGA_EAD..matricula AS m
	JOIN (
		SELECT DISTINCT	seq_turma, RIGHT(REPLICATE('0', 3) + SUBSTRING(CAST(seq_turma AS varchar(10)), LEN(seq_turma) - 2, 3), 3) AS num_turma
		FROM	SGA_EAD..matricula
		WHERE	RIGHT(seq_turma, 3) <> '00'
				--AND dat_cancelamento IS NULL
				--AND ano_turma = 2023
				--AND sem_turma = 1	
	) AS t ON m.seq_turma = t.seq_turma 
	WHERE	cod_aluno = @cod_matricula 
			AND ano_turma = YEAR(GETDATE())
			AND sem_turma = 1

),

disciplinas AS (
	SELECT	 STRING_AGG(nom_disciplina, ' | ') AS 'disciplinas matriculadas'
	FROM	SGA_EAD..matricula 
	WHERE	cod_aluno = @cod_matricula 
			AND ano_turma = YEAR(GETDATE())
			AND sem_turma = 1
)


SELECT DISTINCT sd.nom_aluno AS 'Nome', sd.cod_aluno AS 'Matricula', sd.dat_inclusao AS 'Data da matricula',
			sd.tel_celular AS 'Telefone', sd.dsc_Email AS 'Emails', sd.dat_ultimo_acesso_ava AS 'Ultimo acesso',
			t.seq_turma as 'Turma', t.num_turma as 'Numero Turma', d.[disciplinas matriculadas]
FROM student_data as sd, turma as t, disciplinas as d
