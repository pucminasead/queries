-- Query compara novos microfundamentos com os antigos, filtrando caso o cod_Notes seja nulo e exibindo as exceções

WITH
	TODAS_DISCIPLINAS as (
		SELECT	cod_disciplina, nom_Disciplina, cod_Notes
		FROM	SGA_EAD..disciplina
		WHERE	nom_Disciplina like 'Microfundamento:%'
				AND seq_Turma like '%00'
				AND ind_ativo = 1
				AND cod_Notes is not null
	), 

	NOVAS_DISCIPLINAS as (
		SELECT	cod_disciplina, nom_Disciplina, cod_Notes
		FROM	SGA_EAD..disciplina
		WHERE	ano = 2023
				AND semestre = 2
				AND nom_Disciplina like 'Microfundamento:%'
				AND cod_Notes is null
				AND seq_Turma like '%00'
				AND ind_ativo = 1
	)

SELECT	*
FROM	NOVAS_DISCIPLINAS AS n
WHERE	n.cod_disciplina NOT IN (
	SELECT distinct td.cod_disciplina FROM TODAS_DISCIPLINAS AS td
)
