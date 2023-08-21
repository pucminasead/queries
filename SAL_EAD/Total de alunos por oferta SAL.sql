-- Query para total de alunos por oferta SAL de um curso específico

SELECT	distinct o.seq_oferta, o.nom_curso, o.cod_curso, o.num_oferta, year(o.dat_inicio) as ano_oferta, count(distinct m.cod_aluno) as total_aluno_oferta
FROM	SAL_EAD..matricula as m
		INNER JOIN SAL_EAD..oferta as o
		ON o.seq_oferta = m.seq_oferta
		AND o.origem = m.origem
WHERE	m.dat_cancelamento is null 
		AND o.nom_curso like '%'
		AND m.ind_excluido = 0
		AND m.origem = 'EAD'

GROUP BY o.seq_oferta, o.nom_curso, o.cod_curso, o.num_oferta, year(o.dat_inicio)