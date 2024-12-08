
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Diagnóstico Territorial de Economia Solidária","1", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial de Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Levantamento de potencialidades e vocações locais do território de atuação realizado por membros do projeto",
            "1.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial de Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Levantamento dos problemas do território de atuação realizado por membros do projeto",
            "1.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial de Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Levantamento de movimentos sociais e lideranças comunitárias atuantes no território realizado por membros do projeto",
            "1.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial de Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Identificação e visitação de equipamentos públicos no território que possam apoiar a economia solidária realizadas por membros do projeto",
            "1.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial de Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Participação de membros do projeto como ouvinte ou observador de reuniões de conselhos ou colegiados de economia solidária no território",
            "1.5",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial de Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Sistematização realizada por membros do projeto das informações obtidas previamente por meio de mapeamentos e levantamentos, e construção de um diagnóstico análitico das comunidades, bem como de sua segmentação",
            "1.6",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial de Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Registro em plataforma do projeto das informações, dados, diagnósticos, conhecimentos, testemunhos, evidências que tenham sido levantados pelos membros do projeto",
            "1.7",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial de Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Identificação por membros do projeto de iniciativas de economia solidária no território por membros do projeto",
            "1.8",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial de Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Identificação por membros do projeto de iniciativas de plataformização digital para economia solidária",
            "1.9",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Diagnóstico Territorial de Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Modelagem realizada por membros do projeto das iniciativas de economia solidária, identificadas previamente no território, que tenha ênfase na modelagem de negócios, redes e cadeias produtivas, cabendo a modelagem de qualquer forma de atividade de economia solidária que vise a produção de bens e/ou serviços, bem como a comercialização dos mesmos, mas sempre observando as características da economia solidária",
            "1.10",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Processos Formativos e Comunicação na Economia Solidária","2", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Processos Formativos e Comunicação na Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Participação dos membros do projeto como educandos em processos de formação continuada sobre Economia Popular e Solidária",
            "2.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Processos Formativos e Comunicação na Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Oferta e realização, pelos membros do projeto, de formação voltada para a qualificação de integrantes de empreendimentos de Economia Popular e Solidária, agentes de economia solidária, membros do projeto, trabalhadores e trabalhadoras de economia solidária no âmbito do Programa Manuel Querino de Qualificação, incluindo conteúdos de economia solidária, que deve ser citada em todas as frases. Execução do Projeto Educar para Cooperar no âmbito do SEBRAE para realização de qualificações e assessoramento técnico para empreendimentos solidários",
            "2.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Processos Formativos e Comunicação na Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Produção de materiais de comunicação para visibilidade da Economia Popular e Solidária por membros do projeto",
            "2.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Processos Formativos e Comunicação na Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Distribuir materiais de comunicação no território",
            "2.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Processos Formativos e Comunicação na Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Gerenciar redes sociais para promover a comunicação entre agentes, bolsistas e integrantes de iniciativas de Economia Solidária",
            "2.5",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Processos Formativos e Comunicação na Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Implementação do Programa Paul Singer",
            "2.6",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Processos Formativos e Comunicação na Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Promover a formação dos integrantes de iniciativas de economia solidária no cadastro de suas iniciativas no CADSOL",
            "2.7",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Identificação e cadastramento de Iniciativas no CADSOL","3", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Identificação e cadastramento de Iniciativas no CADSOL"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Identificação de iniciativas de Economia Popular e Solidária que não estão cadastradas oficialmente no CADSOL",
            "3.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Identificação e cadastramento de Iniciativas no CADSOL"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Identificação de redes locais que colaboram com a economia solidária mas que não estão cadastradas oficialmente no CADSOL",
            "3.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Identificação e cadastramento de Iniciativas no CADSOL"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Incentivo ao cadastro no CADSOL para iniciativas cujo cadastro ainda não existe, conforme constatado numa etapa anterior de identificação de iniciativas não cadastradas.",
            "3.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Identificação e cadastramento de Iniciativas no CADSOL"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Acompanhamento do processo de registro de iniciativas no CADSOL junto às instâncias pertinentes, como conselhos de economia solidária",
            "3.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Identificação e cadastramento de Iniciativas no CADSOL"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Avaliação da qualidade do registro de iniciativas no CADSOL, usando como ponto de partida as informações levantadas previamente no território",
            "3.5",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Identificação e cadastramento de Iniciativas no CADSOL"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoio à formação de equipes gestoras do CADSOL em todo o território nacional",
            "3.6",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Fortalecimento da Economia Solidária no Território","4", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Fortalecimento da Economia Solidária no Território"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Mobilizar, organizar, estimular a criação e propor  iniciativas de Economia Popular e Solidária para atores do território",
            "4.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Fortalecimento da Economia Solidária no Território"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Fomentar redes, cadeias e arranjos produtivos de Economia Solidária",
            "4.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Fortalecimento da Economia Solidária no Território"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Estímulo à criação, à manutenção e ampliação de oportunidades de trabalho e acesso à renda",
            "4.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Fortalecimento da Economia Solidária no Território"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Estabelecimento de colaboração formal, efetiva e regular com órgãos públicos em programas de desenvolvimento e combate ao desemprego e à pobreza por meio de instrumentos formais",
            "4.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Fortalecimento da Economia Solidária no Território"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoio à realização de Chamada Pública para o apoio a empreendimentos de economia solidária",
            "4.5",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Fortalecimento da Economia Solidária no Território"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Participação ativa em Conselhos, Assembléias, Fóruns e outras instâncias de tomada de decisão em empreendimentos de economia solidária, cooperativas, associações, redes e movimentos sociais",
            "4.6",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Sensibilização e Articulação Comunitária","5", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Sensibilização e Articulação Comunitária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Articulação da atuação com demais agentes populares no território",
            "5.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Sensibilização e Articulação Comunitária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoio à participação de jovens nas conferências municipais",
            "5.2",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Documentação das Atividades dos Bolsistas","6", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Documentação das Atividades dos Bolsistas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Elaboração e revisão de relatórios mensais e diários de bordo",
            "6.1",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Organização e Participação em Eventos","7", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Organização e Participação em Eventos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoio à realização de eventos de economia solidária, a exemplo de congressos, seminários, etc.",
            "7.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Organização e Participação em Eventos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoio à realização de feiras no contexto de economia solidária, inclusive para a comercialização de produtos das atividades de economia solidária.",
            "7.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Organização e Participação em Eventos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoio à realização das Conferências Nacionais.",
            "7.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Organização e Participação em Eventos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Participação de membros do projeto em eventos como ouvinte ou observador, a exemplo de congressos, conferências, feiras, seminários, palestras, etc..",
            "7.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Organização e Participação em Eventos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Participação de membros do projeto em eventos como palestrante, orador, apresentador, a exemplo de congressos, conferências, feiras, seminários, palestras, etc..",
            "7.5",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Apoio aos processos intrínsecos à execução do projeto","8", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Apoio aos processos intrínsecos à execução do projeto"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Revisão de listas de bolsistas e condições do termo de outorga, principalmente a validade de vigência dos termos de outorga de bolsas, a qualidade dos planos de trabalho e a regularidade dos relatórios de atividades, bem como a verificação dos vínculos e condições de atuação dos bolsistas, número de bolsas pagas, relatórios entregues, inadimplência na entrega de relatórios, avaliação da qualidade dos relatórios",
            "8.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Apoio aos processos intrínsecos à execução do projeto"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Supervisão, orientação e coordenação das atividades de Secretaria-Executiva do Conselho Nacional de Economia Solidária - CNES",
            "8.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Apoio aos processos intrínsecos à execução do projeto"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoio à elaboração e celebração de instrumentos públicos ou de qualquer natureza legal (avenças), com vistas a buscar sinergias institucionais e financiamento",
            "8.3",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Desenvolvimento e Avaliação de Políticas Públicas","9", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Desenvolvimento e Avaliação de Políticas Públicas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Proposição e revisão de minutas de normativos e pareceres técnicos",
            "9.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Desenvolvimento e Avaliação de Políticas Públicas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Análise e modelagem de políticas públicas para economia solidária",
            "9.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Desenvolvimento e Avaliação de Políticas Públicas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Definir características das atividades de coordenação da política de economia popular e solidária",
            "9.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Desenvolvimento e Avaliação de Políticas Públicas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Articular com representações da sociedade civil que contribuem para a determinação de diretrizes e prioridades nas políticas públicas de economia solidária",
            "9.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Desenvolvimento e Avaliação de Políticas Públicas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoio à concepção e implantação de políticas públicas para o pagamento de benefícios por meio de bancos comunitários, cooperativas de crédito solidário, com instrumentos de finanças solidárias",
            "9.5",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Desenvolvimento e Avaliação de Políticas Públicas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoio na elaboração da lei que cria a Política Nacional de Economia Solidária (PNES)",
            "9.6",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Desenvolvimento e Avaliação de Políticas Públicas"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoio na elaboração da lei que cria moedas sociais",
            "9.7",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Apoio à manutenção, recuperação ou desenvolvimento de sistemas de TI e Aplicativos","10", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Apoio à manutenção, recuperação ou desenvolvimento de sistemas de TI e Aplicativos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apoiar ou atuar no desenvolvimento de sistemas de TI para economia solidária, com participação em qualquer etapa da engenharia de software: do levantamento de requisitos, etnografia, desenvolvimento de personas, especificação, codificação, testes, implantação à manutenção, etc.",
            "10.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Apoio à manutenção, recuperação ou desenvolvimento de sistemas de TI e Aplicativos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Gerenciar equipes de software.",
            "10.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Apoio à manutenção, recuperação ou desenvolvimento de sistemas de TI e Aplicativos"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Gestão do Cadastro Nacional de Iniciativas e Empreendimentos de Economia Solidária - CADSOL",
            "10.3",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Inovação para Economia Solidária","11", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Inovação para Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Desenvolver resultados inovadores para potencializar economia solidária",
            "11.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Inovação para Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Apresnetação por membros do projeto sobre oportunidades de pesquisa em tecnologias sociais e saberes comunitários para serem desenvolvidas com as informações levantadas previamente no território, com vistas a fortalecer a economia solidária",
            "11.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Inovação para Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Submissão de artigos científicos, patentes, registros de softwares, etc., bem como qualquer publicação bibliográfica típica do universo acadêmico, incluindo teses, dissertações, monografias, papers, reviews, editoração de revistas científicas, membro de corpo editorial, referee de revistas científicas, etc.",
            "11.3",
            @id_tipo
        );

    
INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da Economia Solidária","12", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Oferecer capacitação em saúde e segurança do trabalhador para iniciativas de economia solidária",
            "12.1",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Propor e desenvolver métodos e ferramentas para melhorar as condições de saúde e segurança do trabalhador nas iniciativas de economia solidária",
            "12.2",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Promover estudos sobre normas regulamentadoras nacionais e seus equivalentes internacionais de saúde e segurança do trabalhador no contexto da economia solidária",
            "12.3",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Mapeamento, levantamento e diagnóstico analítico dos riscos à saúde e segurança do trabalhador nas iniciativas de economia solidária a partir das classificações consolidadas de riscos de acidentes e ameaças à saúde do trabalhador",
            "12.4",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Propor novas normas regulametadoras para saúde e segurança do trabalhador no contexto da economia solidária",
            "12.5",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Promover pesquisas sobre saúde e segurança do trabalhador no contexto da economia solidária",
            "12.6",
            @id_tipo
        );

    
        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Sensibilização sobre Saúde e Segurança do Trabalhador no âmbito da Economia Solidária"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Promover a capacitação em gestão de segurança do trabalho para agentes e trabalhadores envolvidos com iniciativas de economia solidária",
            "12.7",
            @id_tipo
        );

    