-- Query extrai os dados de todos os alunos do semestre e exibe se está matriculado em microfundamento, projeto, competencias, desafios e se a matricula no projeto está duplicada 

WITH
    MATRICULA_ALL AS (
        SELECT DISTINCT
                a.nom_aluno, a.cod_aluno, a.nom_curso
        FROM    SGA_EAD..matricula AS m
                INNER JOIN SGA_EAD..disciplina as d
                    ON m.seq_turma = d.seq_Turma
                    AND m.ano_turma = d.ano
                    AND d.semestre = m.sem_turma

                INNER JOIN SGA_EAD..aluno AS a
                    ON a.cod_aluno = m.cod_aluno
        WHERE   d.ano = 2023
                AND d.semestre = 2
                AND (
                    d.nom_Disciplina like 'MICROFUNDAMENTO: %'
                    OR d.nom_Disciplina like 'PROJETO: %'
                    OR d.nom_Disciplina like 'COMPETÊNCIAS COMPORTAMENTAIS: %'
                    OR d.nom_Disciplina like 'DESAFIOS CONTEMPORÂNEOS: %'
                    OR D.nom_Disciplina like 'GRUPOS DE ESTUDOS %'
                )
                AND m.dat_cancelamento is null
                
        ),
    MATRICULA_MICROFUNDAMENTO  AS (
        SELECT DISTINCT
                a.cod_aluno
        FROM    SGA_EAD..matricula AS m
                INNER JOIN SGA_EAD..disciplina as d
                    ON m.seq_turma = d.seq_Turma
                    AND m.ano_turma = d.ano
                    AND d.semestre = m.sem_turma

                INNER JOIN SGA_EAD..aluno AS a
                    ON a.cod_aluno = m.cod_aluno
        WHERE   d.ano = 2023
                AND d.semestre = 2
                AND d.nom_Disciplina like 'MICROFUNDAMENTO: %'
                AND m.dat_cancelamento is null
        ),

    MATRICULA_COMPETENCIAS  AS (
        SELECT DISTINCT
                a.cod_aluno
        FROM    SGA_EAD..matricula AS m
                INNER JOIN SGA_EAD..disciplina as d
                    ON m.seq_turma = d.seq_Turma
                    AND m.ano_turma = d.ano
                    AND d.semestre = m.sem_turma

                INNER JOIN SGA_EAD..aluno AS a
                    ON a.cod_aluno = m.cod_aluno
        WHERE   d.ano = 2023
                AND d.semestre = 2
                AND d.nom_Disciplina like 'COMPETÊNCIAS COMPORTAMENTAIS: %'
                AND m.dat_cancelamento is null
        ),
        
    MATRICULA_PROJETO  AS (
        SELECT DISTINCT
                a.cod_aluno
        FROM    SGA_EAD..matricula AS m
                INNER JOIN SGA_EAD..disciplina as d
                    ON m.seq_turma = d.seq_Turma
                    AND m.ano_turma = d.ano
                    AND d.semestre = m.sem_turma

                INNER JOIN SGA_EAD..aluno AS a
                    ON a.cod_aluno = m.cod_aluno
        WHERE   d.ano = 2023
                AND d.semestre = 2
                AND d.nom_Disciplina like 'PROJETO: %'
                AND m.dat_cancelamento is null
        ),

    MATRICULA_DESAFIOS  AS (
        SELECT DISTINCT
                a.cod_aluno
        FROM    SGA_EAD..matricula AS m
                INNER JOIN SGA_EAD..disciplina as d
                    ON m.seq_turma = d.seq_Turma
                    AND m.ano_turma = d.ano
                    AND d.semestre = m.sem_turma

                INNER JOIN SGA_EAD..aluno AS a
                    ON a.cod_aluno = m.cod_aluno
        WHERE   d.ano = 2023
                AND d.semestre = 2
                AND d.nom_Disciplina like 'DESAFIOS CONTEMPORÂNEOS: %'
                AND m.dat_cancelamento is null
        ),
        
    MATRICULA_GRUPOS  AS (
        SELECT DISTINCT
                a.cod_aluno
        FROM    SGA_EAD..matricula AS m
                INNER JOIN SGA_EAD..disciplina as d
                    ON m.seq_turma = d.seq_Turma
                    AND m.ano_turma = d.ano
                    AND d.semestre = m.sem_turma

                INNER JOIN SGA_EAD..aluno AS a
                    ON a.cod_aluno = m.cod_aluno
        WHERE   d.ano = 2023
                AND d.semestre = 2
                AND d.nom_Disciplina like 'GRUPOS DE ESTUDOS %'
                AND m.dat_cancelamento is null
        ), 

    NUM_PERIODO  AS (
        SELECT DISTINCT
                d.num_periodo,
                a.cod_aluno, 
                CONCAT('Eixo ', num_periodo,' - ', d.nom_Disciplina,' - TURMA ', REVERSE(SUBSTRING(REVERSE(CONVERT(VARCHAR, d.seq_Turma)),1,2)), ' - ', ano, '/', semestre) as nome_disciplina,
                ROW_NUMBER() OVER(
                    PARTITION BY a.cod_aluno 
                    ORDER BY d.num_periodo
                ) as row_number

        FROM    SGA_EAD..matricula AS m
                INNER JOIN SGA_EAD..disciplina as d
                    ON m.seq_turma = d.seq_Turma
                    AND m.ano_turma = d.ano
                    AND d.semestre = m.sem_turma

                INNER JOIN SGA_EAD..aluno AS a
                    ON a.cod_aluno = m.cod_aluno
        WHERE   d.ano = 2023
                AND d.semestre = 2
                AND d.nom_Disciplina like 'PROJETO: %'
                AND d.seq_Turma not like '%00' 
                AND m.dat_cancelamento is null
        )
SELECT  DISTINCT nom_aluno, ma.cod_aluno, nom_curso, nome_disciplina,
		CASE 
			WHEN ma.cod_aluno NOT IN (SELECT * FROM MATRICULA_MICROFUNDAMENTO)	THEN 'Não matriculado'
			ELSE 'Matriculado'			
		END as Microfundamento,
		CASE 
			WHEN ma.cod_aluno NOT IN (SELECT * FROM MATRICULA_PROJETO) THEN 'Não matriculado'
			ELSE 'Matriculado'
		END as Projeto,
		CASE 
			WHEN ma.cod_aluno NOT IN (SELECT * FROM MATRICULA_COMPETENCIAS) THEN 'Não matriculado'
			ELSE 'Matriculado'
		END as Competencias,
		CASE
			WHEN ma.cod_aluno NOT IN (SELECT * FROM MATRICULA_DESAFIOS) THEN 'Não matriculado'
			ELSE 'Matriculado'
		END as Desafios,
		CASE 
			WHEN row_number = 1 THEN 'Única'
			ELSE 'Duplicada'
		END as matricula_projeto
FROM	MATRICULA_ALL as ma
		INNER JOIN NUM_PERIODO as np
		ON  ma.cod_aluno = np.cod_aluno
