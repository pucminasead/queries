-- Query extrai os dados de todos os alunos do semestre e exibe se está matriculado em projeto mas não em microfundamento

WITH
    MATRICULA_MICROFUNDAMENTO AS (
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
                AND d.semestre = 1
                AND d.nom_Disciplina like 'Microfundamento: %'
                AND m.dat_cancelamento is null

        ),
    MATRICULA_PROJETO  AS (
        SELECT DISTINCT
                a.nom_aluno, a.cod_aluno, a.nom_curso, d.ano, d.semestre
        FROM    SGA_EAD..matricula AS m
                INNER JOIN SGA_EAD..disciplina as d
                    ON m.seq_turma = d.seq_Turma
                    AND m.ano_turma = d.ano
                    AND d.semestre = m.sem_turma

                INNER JOIN SGA_EAD..aluno AS a
                    ON a.cod_aluno = m.cod_aluno
        WHERE   d.ano = 2023
                AND d.semestre = 1
                AND d.nom_Disciplina like 'Projeto: %'
                AND m.dat_cancelamento is null
        )
SELECT  *
FROM	MATRICULA_PROJETO
WHERE	cod_aluno NOT IN (SELECT * FROM MATRICULA_MICROFUNDAMENTO)