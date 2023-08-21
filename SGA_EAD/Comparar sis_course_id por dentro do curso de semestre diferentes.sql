-- Query que filtra as intersecções entre semestre anterior e o atual

WITH 
    MICROFUNDAMENTO_NEW AS (
        SELECT DISTINCT
                    d.nom_Disciplina,
                    d.nome_curso,
                    d.cod_disciplina,
                    d.num_periodo,
                    CONCAT ('SGA_', d.cod_instituto,'_',
                    CASE
                        WHEN cod_curso_oferta IN( 220, 2412 ) THEN '2412'
                        WHEN cod_curso_oferta IN( 145, 2413 ) THEN '2413'
                        WHEN cod_curso_oferta IN( 356, 2414 ) THEN '2414'
                        WHEN cod_curso_oferta IN(1079, 2415 ) THEN '2415'
                        WHEN cod_curso_oferta IN(1060, 2416 ) THEN '2416'
                        WHEN cod_curso_oferta IN( 767, 2417 ) THEN '2417'
                        WHEN cod_curso_oferta IN( 865, 2418 ) THEN '2418'
                        WHEN cod_curso_oferta IN( 884, 2419 ) THEN '2419'
                        WHEN cod_curso_oferta IN(1139, 2420 ) THEN '2420'
                        WHEN cod_curso_oferta IN( 804, 2421 ) THEN '2421'
                        WHEN cod_curso_oferta IN(1158, 2422 ) THEN '2422'
                        WHEN cod_curso_oferta IN(1177, 2423 ) THEN '2423'
                        WHEN cod_curso_oferta IN(1234, 2424 ) THEN '2424'
                        WHEN cod_curso_oferta IN( 240, 2425 ) THEN '2425'
                        WHEN cod_curso_oferta IN(1253, 2426 ) THEN '2426'
                        WHEN cod_curso_oferta IN( 315, 2427 ) THEN '2427'
                        WHEN cod_curso_oferta IN( 974, 2428 ) THEN '2428'
                        WHEN cod_curso_oferta IN(1041, 2429 ) THEN '2429'
                        WHEN cod_curso_oferta IN(1273, 2430 ) THEN '2430'
                        WHEN cod_curso_oferta IN( 266, 2431 ) THEN '2431'
                        WHEN cod_curso_oferta IN( 955, 2432 ) THEN '2432'
                        WHEN cod_curso_oferta IN( 253, 2433 ) THEN '2433'
                        WHEN cod_curso_oferta IN( 302, 2434 ) THEN '2434'
                        WHEN cod_curso_oferta IN(1196, 2435 ) THEN '2435'
                        WHEN cod_curso_oferta IN(1120, 2436 ) THEN '2436'
                        WHEN cod_curso_oferta IN(1291, 2437 ) THEN '2437'
                        WHEN cod_curso_oferta IN( 846, 2438 ) THEN '2438'
                        WHEN cod_curso_oferta IN( 903, 2439 ) THEN '2439'
                        WHEN cod_curso_oferta IN( 278, 2440 ) THEN '2440'
                        WHEN cod_curso_oferta IN( 290, 2441 ) THEN '2441'
                        WHEN cod_curso_oferta IN(1101, 2442 ) THEN '2442'
                        WHEN cod_curso_oferta IN(1215, 2443 ) THEN '2443'
                        ELSE CONVERT (VARCHAR, cod_curso_oferta)
                    END, '_', d.ano,'_', d.semestre, '_PORDENTRO') AS sis_course_id
        FROM  SGA_EAD..disciplina AS d
        WHERE d.nom_Disciplina like 'PROJETO: %'
                AND d.seq_Turma like '%100'
                AND d.num_periodo = 1
                AND d.ano = 2023
                AND d.semestre = 1
                AND d.ind_ativo = 1
    ),
    MICROFUNDAMENTO_OLD AS (
        SELECT DISTINCT d.nom_Disciplina,
                    d.nome_curso,
                    d.cod_disciplina,
                    d.num_periodo,
                    CONCAT ('SGA_', d.cod_instituto,'_',
                    CASE
                        WHEN cod_curso_oferta IN( 220, 2412 ) THEN '2412'
                        WHEN cod_curso_oferta IN( 145, 2413 ) THEN '2413'
                        WHEN cod_curso_oferta IN( 356, 2414 ) THEN '2414'
                        WHEN cod_curso_oferta IN(1079, 2415 ) THEN '2415'
                        WHEN cod_curso_oferta IN(1060, 2416 ) THEN '2416'
                        WHEN cod_curso_oferta IN( 767, 2417 ) THEN '2417'
                        WHEN cod_curso_oferta IN( 865, 2418 ) THEN '2418'
                        WHEN cod_curso_oferta IN( 884, 2419 ) THEN '2419'
                        WHEN cod_curso_oferta IN(1139, 2420 ) THEN '2420'
                        WHEN cod_curso_oferta IN( 804, 2421 ) THEN '2421'
                        WHEN cod_curso_oferta IN(1158, 2422 ) THEN '2422'
                        WHEN cod_curso_oferta IN(1177, 2423 ) THEN '2423'
                        WHEN cod_curso_oferta IN(1234, 2424 ) THEN '2424'
                        WHEN cod_curso_oferta IN( 240, 2425 ) THEN '2425'
                        WHEN cod_curso_oferta IN(1253, 2426 ) THEN '2426'
                        WHEN cod_curso_oferta IN( 315, 2427 ) THEN '2427'
                        WHEN cod_curso_oferta IN( 974, 2428 ) THEN '2428'
                        WHEN cod_curso_oferta IN(1041, 2429 ) THEN '2429'
                        WHEN cod_curso_oferta IN(1273, 2430 ) THEN '2430'
                        WHEN cod_curso_oferta IN( 266, 2431 ) THEN '2431'
                        WHEN cod_curso_oferta IN( 955, 2432 ) THEN '2432'
                        WHEN cod_curso_oferta IN( 253, 2433 ) THEN '2433'
                        WHEN cod_curso_oferta IN( 302, 2434 ) THEN '2434'
                        WHEN cod_curso_oferta IN(1196, 2435 ) THEN '2435'
                        WHEN cod_curso_oferta IN(1120, 2436 ) THEN '2436'
                        WHEN cod_curso_oferta IN(1291, 2437 ) THEN '2437'
                        WHEN cod_curso_oferta IN( 846, 2438 ) THEN '2438'
                        WHEN cod_curso_oferta IN( 903, 2439 ) THEN '2439'
                        WHEN cod_curso_oferta IN( 278, 2440 ) THEN '2440'
                        WHEN cod_curso_oferta IN( 290, 2441 ) THEN '2441'
                        WHEN cod_curso_oferta IN(1101, 2442 ) THEN '2442'
                        WHEN cod_curso_oferta IN(1215, 2443 ) THEN '2443'
                        ELSE CONVERT (VARCHAR, cod_curso_oferta)
                    END, '_', d.ano,'_', d.semestre, '_PORDENTRO') AS sis_course_id 
        FROM  SGA_EAD..disciplina AS d
        WHERE d.nom_Disciplina like 'PROJETO: %'
                AND d.seq_Turma like '%100'
                AND d.num_periodo = 1
                AND d.ano = 2022
                AND d.semestre = 2
                AND d.ind_ativo = 1
    )
SELECT DISTINCT  mo.sis_course_id AS old, mn.sis_course_id AS new, mn.nome_curso
FROM    MICROFUNDAMENTO_OLD AS mo inner join MICROFUNDAMENTO_NEW AS mn
            ON mo.nom_Disciplina = mn.nom_Disciplina
            AND mo.nome_curso = mn.nome_curso
            AND mo.num_periodo = mn.num_periodo
ORDER BY mn.nome_curso