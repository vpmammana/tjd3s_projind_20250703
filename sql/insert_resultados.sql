
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Diagnóstico Territorial e Reconhecimento de Iniciativas","1", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial e Reconhecimento de Iniciativas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoiar o processo de mapeamento e cadastramento das iniciativas econômicas populares e solidárias no CADSOL",
            "1.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial e Reconhecimento de Iniciativas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Realizar a identificação, sensibilização, mobilização e organização dos Empreendimentos de Economia Solidária e Coletivos de Economia Popular e suas redes e cadeias nos territórios",
            "1.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial e Reconhecimento de Iniciativas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Realizar Pesquisa Ação para reconhecimento das realidades das comunidades e segmentos que compõem os territórios do Programa",
            "1.3",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Educação Popular e Formação em Economia Solidária","2", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Educação Popular e Formação em Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Implementar ações de formação contínua, pesquisa, extensão, assessoramento, com base na tecnologia social e nos saberes comunitários",
            "2.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Educação Popular e Formação em Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Promover formação continuada sobre trabalho justo, digno, seguro e saudável em empreendimentos de economia popular e solidária",
            "2.2",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Incidência Política e Articulação Institucional","3", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Incidência Política e Articulação Institucional"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Articular as políticas públicas e os programas sociais com os/as demais agentes populares do governo federal, estadual e municipal, fundamentado na educação popular",
            "3.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Incidência Política e Articulação Institucional"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Organizar e promover fóruns e conselhos de Economia Popular e Solidária, fortalecendo o movimento e sua incidência na formulação de políticas públicas",
            "3.2",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Valorização do Trabalho Justo e Digno","4", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Valorização do Trabalho Justo e Digno"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Identificar e sensibilizar o trabalho justo, digno, seguro e saudável em empreendimentos de economia popular e solidária",
            "4.1",
            @id_tipo
        );

    