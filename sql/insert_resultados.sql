
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Políticas Públicas Municipais de economia popular e solidária","1", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Políticas Públicas Municipais de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Articular e atuar na implementação e monitoramento de políticas públicas municipais de economia popular e solidária",
            "1.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Políticas Públicas Municipais de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Catalogar legislação municipal de economia popular e solidária e respectivos municípios",
            "1.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Políticas Públicas Municipais de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Catalogar programas municipais de economia popular e solidária e respectivos municípios",
            "1.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Políticas Públicas Municipais de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Reuniões com gestores para discutir implementação da política pública de economia popular e solidária",
            "1.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Políticas Públicas Municipais de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Reunir com empreendimentos para discutir papel das políticas municipais",
            "1.5",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Políticas Públicas Municipais de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Planejar formas de acesso às políticas municipais de economia popular e solidária",
            "1.6",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Políticas Públicas Municipais de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Monitorar o acesso às políticas municipais de economia popular e solidária",
            "1.7",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Políticas Públicas Municipais de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Catalogar espaços de comercialização dos produtos da economia popular e solidária",
            "1.8",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Políticas Públicas Municipais de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Divulgar espaços de comercialização, aproximando produtor/a-consumidor/a",
            "1.9",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Formação e Qualificação com Empreendimentos","2", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Levantar demandas de formação, qualificação e assessoramento técnico",
            "2.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Identificar parcerias para demandas de formação nos territórios",
            "2.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Sistematizar as informações sobre formação/qualificação pela equipe interna",
            "2.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Propor reuniões com instituições parceiras",
            "2.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Realizar planejamento com parceiros sobre execução das demandas",
            "2.5",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Organizar a realização das atividades",
            "2.6",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Acompanhar atividades relativas às demandas do Programa",
            "2.7",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Elaborar documentos sobre andamento para Senaes",
            "2.8",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Sistematizar experiências exitosas nos territórios",
            "2.9",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Desenvolver cursos sobre economia popular e solidária com integrantes de coletivos",
            "2.10",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Formação e Qualificação com Empreendimentos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Reunir com redes de educação popular para discutir relação com economia popular e solidária",
            "2.11",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Diagnósticos Territoriais","3", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Visitar empreendimentos para apresentar o Programa",
            "3.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Reunir movimentos para dialogar sobre desafios e potencialidades",
            "3.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Explicar função do questionário de diagnóstico",
            "3.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Realizar diagnóstico dos empreendimentos (formas organizativas, gestão, etc.)",
            "3.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Cadastrar empreendimentos no CADSOL",
            "3.5",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Levantar relações dos empreendimentos com outras organizações do território",
            "3.6",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Identificar programas e políticas públicas existentes no território",
            "3.7",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Gerar relatórios preliminares para subsidiar decisões",
            "3.8",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Sistematizar dados classificando demandas",
            "3.9",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Identificar tipos de coletivos que comercializam em feiras locais",
            "3.10",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Levantar tipos de produtos comercializados em feiras populares",
            "3.11",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnósticos Territoriais"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Levantar informações sobre redes de educação popular no território",
            "3.12",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Mobilização e Sensibilização","6", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Mobilização e Sensibilização"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Reunir coletivos de produção sobre organização da economia popular e solidária",
            "6.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Mobilização e Sensibilização"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Visitar coletivos para conversar sobre fortalecimento da economia popular e solidária",
            "6.2",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Monitoramento de Ações Formativas","4", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Monitoramento de Ações Formativas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Levantar informações do andamento das ações do Programa",
            "4.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Monitoramento de Ações Formativas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Organizar dados para subsidiar decisões da Senaes",
            "4.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Monitoramento de Ações Formativas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apontar formas de resolução coletiva de desafios",
            "4.5",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Diálogo com Movimentos de economia popular e solidária","5", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diálogo com Movimentos de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Colaborar com espaços organizativos de economia popular e solidária conforme demandas",
            "5.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diálogo com Movimentos de economia popular e solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Participar de reuniões de fóruns, colegiados e conselhos quando convidados",
            "5.2",
            @id_tipo
        );

    