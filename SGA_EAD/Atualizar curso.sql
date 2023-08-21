-- Query para atualizar o curso do no banco

UPDATE 	
	SGA_EAD..disciplina
	SET 	--cod_notes = 'BPT_2412_1_PROJETO',
			cod_Notes = 'SGA_61286_2417_2023_2_9435100',
			ind_atualizado_ead = 1,
			dat_atualizacao_ead = GETDATE()
	WHERE  	seq_turma = 9435100
			AND ano = 2023
			AND semestre = 2 