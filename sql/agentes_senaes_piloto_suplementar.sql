
-- Inserts únicos em regioes_atuacao
INSERT IGNORE INTO regioes_atuacao (nome_regiao_atuacao) VALUES ('São Paulo - Leste 2');
INSERT IGNORE INTO regioes_atuacao (nome_regiao_atuacao) VALUES ('São Paulo - ABC');
INSERT IGNORE INTO regioes_atuacao (nome_regiao_atuacao) VALUES ('São Paulo - Leste 1');

-- Inserts em tipos_vinculos (para perfis do CSV)
INSERT IGNORE INTO tipos_vinculos (nome_tipo_vinculo, descricao) VALUES ('Bolsista com Ação Territorial', 'Inserido automaticamente a partir do CSV');

-- Alterações na tabela pessoas para incluir FKs
-- Inserts na tabela pessoas
INSERT INTO pessoas (nome_pessoa, email, telefone, id_tipo_vinculo, id_regiao_atuacao) VALUES ('Robson Souza Dutra', 'blackzuka10@gmail.com', '11', (SELECT id_chave_tipo_vinculo FROM tipos_vinculos WHERE nome_tipo_vinculo = 'Bolsista com Ação Territorial'), (SELECT id_chave_regiao_atuacao FROM regioes_atuacao WHERE nome_regiao_atuacao = 'São Paulo - Leste 2'));
INSERT INTO pessoas (nome_pessoa, email, telefone, id_tipo_vinculo, id_regiao_atuacao) VALUES ('Luis Tezoto', 'luis.tezoto@trabalho.gov.br', '11', (SELECT id_chave_tipo_vinculo FROM tipos_vinculos WHERE nome_tipo_vinculo = 'Bolsista com Ação Territorial'), (SELECT id_chave_regiao_atuacao FROM regioes_atuacao WHERE nome_regiao_atuacao = 'São Paulo - ABC'));
INSERT INTO pessoas (nome_pessoa, email, telefone, id_tipo_vinculo, id_regiao_atuacao) VALUES ('Mariana Giroto', 'mariana.giroto@trabalho.gov.br', '11', (SELECT id_chave_tipo_vinculo FROM tipos_vinculos WHERE nome_tipo_vinculo = 'Bolsista com Ação Territorial'), (SELECT id_chave_regiao_atuacao FROM regioes_atuacao WHERE nome_regiao_atuacao = 'São Paulo - Leste 1'));

-- Inserts na tabela usuarios
INSERT INTO usuarios (nome_usuario, senha, hash, data_inicio_cadastro, id_pessoa, pode_msg) VALUES ('blackzuka10', '', 'fa9211f0d2e24df25d64a1a23a90b692ce3f574fa8f6602bc664ffe7b8e701e6', CURDATE(), (SELECT id_chave_pessoa FROM pessoas WHERE email = 'blackzuka10@gmail.com'), 'nao');
INSERT INTO usuarios (nome_usuario, senha, hash, data_inicio_cadastro, id_pessoa, pode_msg) VALUES ('luis.tezoto', '', 'a3448a833fcea3aa65498300cc70525e37c6fb8bc68e78c3755216657c6b2fc8', CURDATE(), (SELECT id_chave_pessoa FROM pessoas WHERE email = 'luis.tezoto@trabalho.gov.br'), 'nao');
INSERT INTO usuarios (nome_usuario, senha, hash, data_inicio_cadastro, id_pessoa, pode_msg) VALUES ('mariana.giroto', '', '07d9c72199c5ecb16a3d817c2cf6c359a5e00b50960b2f495b2ecb1f11b0a5d6', CURDATE(), (SELECT id_chave_pessoa FROM pessoas WHERE email = 'mariana.giroto@trabalho.gov.br'), 'nao');
