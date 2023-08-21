-- Query compara modelos de projetos entre semestres e exibe os novos que são exceções

WITH
	MODELOS_NOVOS as ( 
		SELECT * 
		FROM SGA_EAD..disciplina 
		WHERE ano = 2023 
			AND semestre = 2 
			AND nom_Disciplina like 'PROJETO:%' 
			AND seq_Turma like '%00' 
			AND	ind_ativo = 1
	), 
	MODELOS_ANTIGOS as ( 
		SELECT * 
		FROM SGA_EAD..disciplina 
		WHERE ano = 2023 
			AND semestre = 1 
			AND nom_Disciplina like 'PROJETO:%' 
			AND seq_Turma like '%00' 
			AND cod_Notes like 'BPT%'
	)
SELECT *
FROM MODELOS_NOVOS AS mn 
WHERE mn.cod_disciplina NOT IN (
	SELECT ma.cod_disciplina FROM MODELOS_ANTIGOS AS ma
)

