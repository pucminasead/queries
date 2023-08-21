-- Query compara modelos de microfundamentos entre semestres e exibe os novos que são exceções

WITH
	MODELOS_NOVOS as ( 
		SELECT	* 
		FROM	SGA_EAD..disciplina 
		WHERE	ano = 2023 
				AND semestre = 2 
				AND nom_Disciplina like 'MICROFUNDAMENTO:%' 
				AND seq_Turma like '%00' 
				AND	ind_ativo = 1
	), 
	MODELOS_ANTIGOS as ( 
		SELECT	* 
		FROM	SGA_EAD..disciplina 
		WHERE	ano = 2023 
				AND semestre = 1 
				AND nom_Disciplina like 'MICROFUNDAMENTO:%' 
				AND seq_Turma like '%00' 
				AND cod_Notes like 'SGA_%'
	)

SELECT *
FROM MODELOS_NOVOS mn 
WHERE mn.cod_disciplina NOT IN (
	SELECT ma.cod_disciplina FROM MODELOS_ANTIGOS ma
)

