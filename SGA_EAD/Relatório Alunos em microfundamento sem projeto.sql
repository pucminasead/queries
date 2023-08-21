-- Query extrai os dados de todos os alunos do semestre e exibe se está matriculado em microfundamento mas não está em projeto

WITH
    MATRICULA AS (
        SELECT DISTINCT
                a.nom_aluno, a.cod_aluno, a.nom_curso,  d.nome_curso, d.ano, d.semestre
        FROM    SGA_EAD..matricula AS m
                INNER JOIN SGA_EAD..disciplina as d
                    ON m.seq_turma = d.seq_Turma
                    AND m.ano_turma = d.ano
                    AND d.semestre = m.sem_turma

                INNER JOIN SGA_EAD..aluno AS a
                    ON a.cod_aluno = m.cod_aluno
        WHERE   d.ano = 2023
                AND d.semestre = 1
                --AND d.seq_Turma not like '%00'
                AND d.nom_Disciplina like 'Microfundamento: %'
                --AND d.seq_Turma in (2457101, 0522101, 8600101, 8564101,
                                    --8861101, 9113101, 9113201, 521101,
                                    --9107101, 4156101, 3763101, 8469101) 
                --Filtra por disciplinas exatas
                --AND (d.nom_Disciplina like 'Desafios Contemporâneos: %') OR (d.nom_Disciplina like 'Competências Comportamentais: %') -- Filtrar por desafios e competências
                AND m.dat_cancelamento is null
            
        ),
    PERIODO AS
        (
        SELECT DISTINCT
                d.seq_Turma, m.cod_aluno, d.num_periodo
        FROM    SGA_EAD..disciplina AS d
                INNER JOIN SGA_EAD..matricula AS m
                    ON m.seq_turma = d.seq_Turma
                    AND m.ano_turma = d.ano
                    AND m.sem_turma = d.semestre 
        WHERE   d.ano = 2023
                AND d.semestre = 2
                AND d.nom_Disciplina like 'Projeto: %'
                AND m.dat_cancelamento is null
                AND d.seq_Turma not like '%00'
        )
SELECT  m.cod_aluno,
        m.nom_aluno,
        m.nom_curso AS curso_aluno,
        CASE
            WHEN p.num_periodo = 1 THEN 'CALOURO'
            WHEN p.num_periodo is null THEN 'NÃO MATRICULADO EM PROJETO'
            ELSE 'VETERANO'
        END AS tipo_aluno,
        p.num_periodo,
        m.nome_curso AS curso_disciplina        
FROM    MATRICULA as m
        LEFT JOIN PERIODO as p
        ON p.cod_aluno = m.cod_aluno
WHERE	p.num_periodo is null


ORDER BY tipo_aluno, p.num_periodo