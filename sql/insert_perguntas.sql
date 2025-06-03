# a colocação de um tipo_resultado "perguntas" na tabela tipos_resultados visa tentar aproveitar a tabela tokens para guardar as perguntas. Mas tem como problema a falta de um campo para guardar o texto que vai no placeholder e no help. Então achei melhor criar uma tabela nova "perguntas" no arquivo cria_banco_mvp.sql.

INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai) VALUES ("Conjunto de perguntas para sensibilizar usuário a escolher tokens","0", NULL);

        SET @id_tipo = (
            SELECT id_chave_tipo_resultado 
            FROM tipos_resultados 
            WHERE nome_tipo_resultado = "Conjunto de perguntas para sensibilizar usuário a escolher tokens"
        );
        
        INSERT INTO tipos_resultados (nome_tipo_resultado, numeracao_tipo_resultado, id_tipo_resultado_pai)
        VALUES (
            "Perguntas, organizadas na estrutura de tokens, para sensibilizar o usuário a escolher tokens",
            "0.1",
            @id_tipo
        );

INSERT INTO perguntas (nome_pergunta, placeholder, help) 
VALUES 
("Qual foi a sua ação?", 
 "Digite um verbo no passado", 
 "Aqui você vai escrever uma ação que realizou, usando um verbo no passado, como 'construiu', 'ajudou' ou 'organizou'. Quando clicar neste campo, você verá uma lista de verbos no passado para escolher. Você pode digitar as primeiras letras do verbo para encontrá-lo mais rápido.");

INSERT INTO perguntas (nome_pergunta, placeholder, help) 
VALUES 
("Sobre quem ou o que você agiu?", 
 "Digite um substantivo ou qualquer palavra de uma locução substantiva", 
 "Neste campo, você vai escrever quem ou o que foi impactado pela sua ação. Pode ser uma pessoa, um objeto ou até mesmo um lugar, como 'comunidade', 'relatório' ou 'parque'. Se preferir, digite as primeiras letras para encontrar sugestões.");

INSERT INTO perguntas (nome_pergunta, placeholder, help) 
VALUES 
("Que características você percebe no objeto da sua ação?", 
 "Digite um adjetivo ou qualquer palavra de uma locução adjetiva", 
 "Aqui você vai escrever uma característica que você notou naquilo sobre o que agiu. Pode ser uma qualidade, como 'importante', 'urgente', ou 'bem planejado'. Você verá sugestões enquanto digita.");

INSERT INTO perguntas (nome_pergunta, placeholder, help) 
VALUES 
("Indique um destino ou finalidade da sua ação?", 
 "Digite um substantivo ou qualquer palavra de uma locução substantiva", 
 "Neste campo, você vai indicar o objetivo ou o lugar para onde sua ação foi direcionada. Exemplos: 'projeto', 'moradores' ou 'melhoria do ambiente'. Você verá uma lista de sugestões ao clicar.");

INSERT INTO perguntas (nome_pergunta, placeholder, help) 
VALUES 
("Indique as características desse destino ou finalidade?", 
 "Digite um adjetivo ou qualquer palavra de uma locução adjetiva", 
 "Aqui você vai descrever as características do destino ou objetivo da sua ação. Pode ser algo como 'sustentável', 'eficiente' ou 'acolhedor'. Sugestões aparecerão enquanto você digita.");

