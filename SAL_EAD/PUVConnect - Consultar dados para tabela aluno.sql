--Query para extrair dados do aluno para o projeto PUVConnect

WITH 
	student_data AS (
		SELECT DISTINCT	nom_aluno, cod_aluno, dat_inclusao, tel_celular, dsc_email, seq_oferta
		FROM	SAL_EAD..aluno
		WHERE	ind_ativo = 1
				AND ind_excluido = 0
				AND YEAR(dat_inclusao) = 2023
				AND seq_oferta = 1909
				AND ind_ativo = 1
				AND cod_aluno = xxxxxx
	),

	oferta AS (
		SELECT	nom_curso, seq_oferta, dat_inicio
		FROM	SAL_EAD..oferta
		WHERE	cod_tipo_curso IN (1, 5)
				AND YEAR(dat_inicio) = 2023
				AND cod_curso_EAD LIKE 'SALEAD_%'
				AND seq_oferta = xxxxxx
	),

	matricula_do_aluno AS (
		SELECT DISTINCT	co.nom_disciplina
		FROM	SAL_EAD..matricula AS m
				INNER JOIN SAL_EAD..curriculo_oferta AS co
				ON co.seq_oferta = m.seq_oferta
		WHERE	YEAR(dat_matricula) = 2023
				AND dat_cancelamento IS NULL
				AND m.ind_excluido = 0
				AND m.seq_oferta = xxxxxx
				AND m.cod_aluno = xxxxxx
	)
SELECT	sd.nom_aluno AS 'Nome', sd.cod_aluno AS 'Matricula', sd.dat_inclusao AS 'Data Matricula',
		sd.tel_celular AS 'Telefone', sd.dsc_email AS 'Email', o.nom_curso AS 'Curso', YEAR(o.dat_inicio) AS 'Oferta',
		STRING_AGG(TRIM(mda.nom_disciplina), ' | ') AS Disciplinas
FROM	student_data AS sd, oferta AS o, matricula_do_aluno AS mda
GROUP BY sd.nom_aluno, sd.cod_aluno, sd.dat_inclusao, sd.tel_celular, sd.dsc_email, o.nom_curso, YEAR(o.dat_inicio)