# Inadvertidamente, a equipe de bolsistas alterou o código da base, colocando um termo_lgpd que não estava documentado. Eu tive que acrescetar assumindo que é varchar(5) para caber true e false, uma vez que o prepare na hora de fazer o insert é do tipo s (string?) VPM 20250512 - eu percebi já que tem muita coisa não documentada no código ou em documentos de apoio
# TABELAS COM 6 CONSTRAINTS
# desenvolvido por Victor Mammana
DROP TABLE IF EXISTS mensagens;
DROP TABLE IF EXISTS perguntas;
DROP TABLE IF EXISTS `acoes`;

# TABELAS COM 2 CONSTRAINTS

DROP TABLE IF EXISTS `enderecos`;
DROP TABLE IF EXISTS `frases`;


# TABELAS COM 3 CONSTRAINTS

DROP TABLE IF EXISTS `localizacoes`;
DROP TABLE IF EXISTS `tipos_acoes`;
DROP TABLE IF EXISTS `tokens`;
DROP TABLE IF EXISTS `vinculos`;


# TABELAS COM 1 CONSTRAINT

DROP TABLE IF EXISTS `arquivos`;
DROP TABLE IF EXISTS `atividades_eventos`;
DROP TABLE IF EXISTS `cidades`;
DROP TABLE IF EXISTS `estados`;
DROP TABLE IF EXISTS `instituicoes`;
DROP TABLE IF EXISTS `tipos_instituicoes`;
DROP TABLE IF EXISTS `tipos_resultados`;
DROP TABLE IF EXISTS `tipos_tokens`;
DROP TABLE IF EXISTS `usuarios`;


# TABELAS SEM CONSTRAINTS

DROP TABLE IF EXISTS `esferas_institucionais`;
DROP TABLE IF EXISTS `paises`;
DROP TABLE IF EXISTS `pessoas`;
DROP TABLE IF EXISTS `tabelas_mantidas`;
DROP TABLE IF EXISTS `tipos_arquivos`;
DROP TABLE IF EXISTS `tipos_elementos_sintaticos`;
DROP TABLE IF EXISTS `tipos_flexoes`;
DROP TABLE IF EXISTS `tipos_vinculos`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE perguntas (
  id_chave_pergunta int NOT NULL AUTO_INCREMENT,
  nome_pergunta varchar(255) NOT NULL,
  placeholder varchar(255) DEFAULT NULL,
  help text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_chave_pergunta),
  UNIQUE KEY nome_pergunta (nome_pergunta)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `esferas_institucionais` (
  `id_chave_esfera_institucional` int NOT NULL AUTO_INCREMENT,
  `nome_esfera_institucional` varchar(40) NOT NULL,
  `descricao` text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_esfera_institucional`),
  UNIQUE KEY `nome_esfera_institucional` (`nome_esfera_institucional`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paises` (
  `id_chave_pais` int NOT NULL AUTO_INCREMENT,
  `nome_pais` varchar(255) NOT NULL,
  `codigo_iso` varchar(3) NOT NULL,
  `populacao_estimada` bigint DEFAULT NULL,
  `area_total` decimal(12,2) DEFAULT NULL,
  `densidade_demografica` decimal(10,2) DEFAULT NULL,
  `capital` varchar(100) NOT NULL,
  `regiao` varchar(100) NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_pais`),
  UNIQUE KEY `codigo_iso` (`codigo_iso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoas` (
  `id_chave_pessoa` int NOT NULL AUTO_INCREMENT,
  `nome_pessoa` varchar(255) NOT NULL,
  `cpf` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  termo_lgpd varchar(5) DEFAULT 'false',
  PRIMARY KEY (`id_chave_pessoa`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tabelas_mantidas` (
  `id_tabela_mantida` int NOT NULL AUTO_INCREMENT,
  `nome_tabela_mantida` varchar(255) NOT NULL,
  `descricao` varchar(1000) NOT NULL,
  `manter` tinyint(1) NOT NULL,
  `data_insercao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tabela_mantida`),
  UNIQUE KEY `nome_tabela_mantida` (`nome_tabela_mantida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_arquivos` (
  `id_chave_tipo_arquivo` int NOT NULL AUTO_INCREMENT,
  `nome_tipo_arquivo` varchar(255) NOT NULL,
  `extensao` varchar(10) NOT NULL,
  `descricao` text NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_tipo_arquivo`),
  unique (nome_tipo_arquivo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_elementos_sintaticos` (
  `id_chave_tipo_elemento_sintatico` int NOT NULL AUTO_INCREMENT,
  `nome_tipo_elemento_sintatico` varchar(255) NOT NULL,
  `descricao` text NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_tipo_elemento_sintatico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_flexoes` (
  `id_chave_tipo_flexao` int NOT NULL AUTO_INCREMENT,
  `nome_tipo_flexao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `acentuada` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_insercao` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id_chave_tipo_flexao`),
  UNIQUE KEY `nome_tipo_flexao` (`nome_tipo_flexao`),
  UNIQUE KEY `acentuada` (`acentuada`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_vinculos` (
  `id_chave_tipo_vinculo` int NOT NULL AUTO_INCREMENT,
  `nome_tipo_vinculo` varchar(100) NOT NULL,
  `descricao` text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_tipo_vinculo`),
  UNIQUE KEY `nome_tipo_vinculo` (`nome_tipo_vinculo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


# TABELAS COM 1 CONSTRAINT

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arquivos` (
  `id_chave_arquivo` int NOT NULL AUTO_INCREMENT,
  `nome_arquivo` varchar(255) NOT NULL,
  `id_tipo_arquivo` int DEFAULT NULL,
  `caminho_arquivo_original` varchar(255) NOT NULL,
  `caminho_arquivo_anonimizado` varchar(255) DEFAULT NULL,
  `quantidade_pessoas` int DEFAULT '0',
  `descricao_imagem` text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_arquivo`),
  unique (nome_arquivo),
  KEY `id_tipo_arquivo` (`id_tipo_arquivo`),
  CONSTRAINT `arquivos_ibfk_1` FOREIGN KEY (`id_tipo_arquivo`) REFERENCES `tipos_arquivos` (`id_chave_tipo_arquivo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_chave_usuario` int NOT NULL AUTO_INCREMENT,
  `nome_usuario` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `hash` varchar(128),
  `hash_mobile` varchar(128),
  `data_inicio_cadastro` date NOT NULL,
  `data_fim_cadastro` date DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_pessoa` int DEFAULT NULL,
  tem_local_storage varchar(3) default 'nao', # marca se o aplicativo já colocou um cookie com o hash no celular do cara... se colocou, não permite mais colocar
  pode_msg varchar(3) DEFAULT 'nao',
  PRIMARY KEY (`id_chave_usuario`),
  UNIQUE KEY `nome_usuario` (`nome_usuario`),
  KEY `id_pessoa` (`id_pessoa`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoas` (`id_chave_pessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atividades_eventos` (
  `id_chave_atividade_evento` INT NOT NULL AUTO_INCREMENT,
  `nome_atividade_evento` VARCHAR(255) NOT NULL,
  `data_insercao` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `id_usuario` INT DEFAULT NULL,
  `data_atividade_evento` DATE DEFAULT NULL,
  `hora_atividade_evento` TIME DEFAULT NULL,
  `hash_atividade_evento` CHAR(128) NOT NULL,
  PRIMARY KEY (`id_chave_atividade_evento`),
  UNIQUE KEY `unq_hash_atividade_evento` (`hash_atividade_evento`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `atividades_eventos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_chave_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


DELIMITER $$

CREATE TRIGGER trg_gerar_hash_atividade_evento
BEFORE INSERT ON atividades_eventos
FOR EACH ROW
BEGIN
  IF NEW.hash_atividade_evento IS NULL THEN
    SET NEW.hash_atividade_evento = SHA2(UUID(), 512);
  END IF;
END$$

DELIMITER ;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados` (
  `id_chave_estado` int NOT NULL AUTO_INCREMENT,
  `nome_estado` varchar(255) NOT NULL,
  `sigla_estado` char(2) NOT NULL,
  `codigo_ibge` int NOT NULL,
  `regiao` varchar(100) DEFAULT NULL,
  `populacao_estimada` int DEFAULT NULL,
  `area_total` decimal(10,2) DEFAULT NULL,
  `densidade_demografica` decimal(8,2) DEFAULT NULL,
  `capital` varchar(100) DEFAULT NULL,
  `id_pais` int DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_estado`),
  KEY `id_pais` (`id_pais`),
  CONSTRAINT `estados_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_chave_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cidades` (
  `id_chave_cidade` int NOT NULL AUTO_INCREMENT,
  `codigo_ibge` int DEFAULT NULL,
  `nome_cidade` varchar(255) NOT NULL,
  `id_estado` int NOT NULL,
  `populacao` int DEFAULT NULL,
  `area_km2` decimal(10,2) DEFAULT NULL,
  `densidade_demografica` decimal(8,2) DEFAULT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `gentilico` varchar(100) DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_cidade`),
  UNIQUE KEY `codigo_ibge` (`codigo_ibge`),
  KEY `id_estado` (`id_estado`),
  CONSTRAINT `cidades_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_chave_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_instituicoes` (
  `id_chave_tipo_instituicao` int NOT NULL AUTO_INCREMENT,
  `nome_tipo_instituicao` varchar(255) NOT NULL,
  `descricao` text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_esfera_institucional` int DEFAULT NULL,
  PRIMARY KEY (`id_chave_tipo_instituicao`),
  UNIQUE KEY `nome_tipo_instituicao` (`nome_tipo_instituicao`),
  KEY `id_esfera_institucional` (`id_esfera_institucional`),
  CONSTRAINT `tipos_instituicoes_ibfk_1` FOREIGN KEY (`id_esfera_institucional`) REFERENCES `esferas_institucionais` (`id_chave_esfera_institucional`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instituicoes` (
  `id_chave_instituicao` int NOT NULL AUTO_INCREMENT,
  `nome_instituicao` varchar(255) NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_tipo_instituicao` int DEFAULT NULL,
  PRIMARY KEY (`id_chave_instituicao`),
  UNIQUE KEY `nome_instituicao` (`nome_instituicao`),
  KEY `id_tipo_instituicao` (`id_tipo_instituicao`),
  CONSTRAINT `instituicoes_ibfk_1` FOREIGN KEY (`id_tipo_instituicao`) REFERENCES `tipos_instituicoes` (`id_chave_tipo_instituicao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;



/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_resultados` (
  `id_chave_tipo_resultado` int NOT NULL AUTO_INCREMENT,
  `nome_tipo_resultado` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `numeracao_tipo_resultado` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_tipo_resultado_pai` int DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_tipo_resultado`),
  KEY `fk_tipo_resultado_pai` (`id_tipo_resultado_pai`),
  CONSTRAINT `fk_tipo_resultado_pai` FOREIGN KEY (`id_tipo_resultado_pai`) REFERENCES `tipos_resultados` (`id_chave_tipo_resultado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_tokens` (
  `id_chave_tipo_token` int NOT NULL AUTO_INCREMENT,
  `nome_tipo_token` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `acentuada` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tipo_token_pai` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_insercao` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id_chave_tipo_token`),
  UNIQUE KEY `nome_tipo_token` (`nome_tipo_token`),
  KEY `tipo_token_pai` (`tipo_token_pai`),
  CONSTRAINT `tipos_tokens_ibfk_1` FOREIGN KEY (`tipo_token_pai`) REFERENCES `tipos_tokens` (`nome_tipo_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localizacoes` (
  `id_chave_localizacao` int NOT NULL AUTO_INCREMENT,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `bounding_box_lat_min` decimal(9,6) DEFAULT NULL,
  `bounding_box_lat_max` decimal(9,6) DEFAULT NULL,
  `bounding_box_long_min` decimal(9,6) DEFAULT NULL,
  `bounding_box_long_max` decimal(9,6) DEFAULT NULL,
  `display_name` text NOT NULL,
  `road` varchar(255) DEFAULT NULL,
  `neighbourhood` varchar(255) DEFAULT NULL,
  `suburb` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postcode` varchar(20) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `id_cidade` int DEFAULT NULL,
  `id_estado` int DEFAULT NULL,
  `id_pais` int DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `hash_localizacao` CHAR(128) NOT NULL,
  PRIMARY KEY (`id_chave_localizacao`),
  unique(hash_localizacao),
  KEY `id_cidade` (`id_cidade`),
  KEY `id_estado` (`id_estado`),
  KEY `id_pais` (`id_pais`),
  CONSTRAINT `localizacoes_ibfk_1` FOREIGN KEY (`id_cidade`) REFERENCES `cidades` (`id_chave_cidade`),
  CONSTRAINT `localizacoes_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_chave_estado`),
  CONSTRAINT `localizacoes_ibfk_3` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_chave_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

DELIMITER $$



CREATE TRIGGER trg_gerar_hash_localizacao
BEFORE INSERT ON localizacoes
FOR EACH ROW
BEGIN
  IF NEW.hash_localizacao IS NULL THEN
    SET NEW.hash_localizacao = SHA2(UUID(), 512);
  END IF;
END$$
DELIMITER ;



# TABELAS COM 2 CONSTRAINTS

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enderecos` (
  `id_chave_endereco` int NOT NULL AUTO_INCREMENT,
  `id_instituicao` int DEFAULT NULL,
  `id_localizacao` int NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_endereco`),
  KEY `id_instituicao` (`id_instituicao`),
  KEY `id_localizacao` (`id_localizacao`),
  CONSTRAINT `enderecos_ibfk_1` FOREIGN KEY (`id_instituicao`) REFERENCES `instituicoes` (`id_chave_instituicao`),
  CONSTRAINT `enderecos_ibfk_2` FOREIGN KEY (`id_localizacao`) REFERENCES `localizacoes` (`id_chave_localizacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

# TABELAS COM 3 CONSTRAINTS

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id_chave_token` int NOT NULL AUTO_INCREMENT,
  `nome_token` varchar(200) NOT NULL,
  `id_tipo_token` int DEFAULT NULL,
  `id_raiz` int DEFAULT NULL,
  `id_tipo_flexao` int DEFAULT NULL,
  `id_grupo_token` int DEFAULT NULL,
  `data_insercao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_token`),
  UNIQUE KEY `nome_token` (`nome_token`,`id_tipo_token`),
  KEY `id_tipo_token` (`id_tipo_token`),
  KEY `id_raiz` (`id_raiz`),
  KEY `id_tipo_flexao` (`id_tipo_flexao`),
  KEY `id_grupo_token` (`id_grupo_token`),
  CONSTRAINT `fk_raiz_token` FOREIGN KEY (`id_raiz`) REFERENCES `tokens` (`id_chave_token`),
  CONSTRAINT `fk_tipo_flexao` FOREIGN KEY (`id_tipo_flexao`) REFERENCES `tipos_flexoes` (`id_chave_tipo_flexao`),
  CONSTRAINT `fk_tipo_token` FOREIGN KEY (`id_tipo_token`) REFERENCES `tipos_tokens` (`id_chave_tipo_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
ALTER TABLE tokens MODIFY nome_token VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin; -- importante para permitir diferenciar acentuação, como crase, que dá tokens diferentes. No select é preciso mudar a collation para uma que não diferencia acentuação
-- SELECT * FROM tokens WHERE nome_token COLLATE utf8mb4_unicode_ci LIKE '%autogestão%';
-- SELECT * FROM tokens WHERE nome_token COLLATE utf8mb4_general_ci = 'à autogestão';

CREATE TABLE tipos_acoes (
	id_chave_tipo_acao INT NOT NULL AUTO_INCREMENT,
	nome_tipo_acao VARCHAR(255) NOT NULL,
	id_tipo_resultado INT DEFAULT NULL,
	id_tipo_elemento_sintatico INT DEFAULT NULL,
	data_insercao TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id_chave_tipo_acao),
	UNIQUE KEY nome_tipo_acao (nome_tipo_acao),
	CONSTRAINT tipos_acoes_ibfk_1 FOREIGN KEY (id_tipo_resultado) REFERENCES tipos_resultados (id_chave_tipo_resultado),
	CONSTRAINT tipos_acoes_ibfk_2 FOREIGN KEY (id_tipo_elemento_sintatico) REFERENCES tipos_elementos_sintaticos (id_chave_tipo_elemento_sintatico)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frases` (
  `id_chave_frase` int NOT NULL AUTO_INCREMENT,
  `nome_frase` varchar(255) DEFAULT NULL,
  `id_token` int DEFAULT NULL,
  `ordem` int DEFAULT NULL,
  `id_tipo_acao` int DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_frase`),
  UNIQUE KEY `id_token` (`id_tipo_acao`,`ordem`),
  CONSTRAINT `frases_ibfk_1` FOREIGN KEY (`id_token`) REFERENCES `tokens` (`id_chave_token`),
  CONSTRAINT `frases_ibfk_3` FOREIGN KEY (`id_tipo_acao`) REFERENCES `tipos_acoes` (`id_chave_tipo_acao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;



/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vinculos` (
  `id_chave_vinculo` int NOT NULL AUTO_INCREMENT,
  `id_pessoa` int NOT NULL,
  `id_instituicao` int NOT NULL,
  `id_tipo_vinculo` int NOT NULL,
  `data_inicio_vinculo` date NOT NULL,
  `data_fim_vinculo` date DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_vinculo`),
  KEY `id_pessoa` (`id_pessoa`),
  KEY `id_instituicao` (`id_instituicao`),
  KEY `id_tipo_vinculo` (`id_tipo_vinculo`),
  CONSTRAINT `vinculos_ibfk_1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoas` (`id_chave_pessoa`),
  CONSTRAINT `vinculos_ibfk_2` FOREIGN KEY (`id_instituicao`) REFERENCES `instituicoes` (`id_chave_instituicao`),
  CONSTRAINT `vinculos_ibfk_3` FOREIGN KEY (`id_tipo_vinculo`) REFERENCES `tipos_vinculos` (`id_chave_tipo_vinculo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

# TABLES COM 6 CONSTRAINTS

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acoes` (
  `id_chave_acao` int NOT NULL AUTO_INCREMENT,
  `id_atividade_evento` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `id_localizacao` int DEFAULT NULL,
  `id_tipo_acao` int DEFAULT NULL,
  `id_arquivo` int DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `data_acao` date NOT NULL,
  `hora_acao` time NOT NULL,
  `descricao` text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_pessoa` int DEFAULT NULL,
  `hash_acao` CHAR(128) NOT NULL,
  PRIMARY KEY (`id_chave_acao`),
  UNIQUE KEY `unq_hash_acao` (`hash_acao`),
  KEY `id_atividade_evento` (`id_atividade_evento`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_localizacao` (`id_localizacao`),
  KEY `id_tipo_acao` (`id_tipo_acao`),
  KEY `id_arquivo` (`id_arquivo`),
  KEY `fk_acoes_pessoas` (`id_pessoa`),
  CONSTRAINT `acoes_ibfk_1` FOREIGN KEY (`id_atividade_evento`) REFERENCES `atividades_eventos` (`id_chave_atividade_evento`),
  CONSTRAINT `acoes_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_chave_usuario`),
  CONSTRAINT `acoes_ibfk_3` FOREIGN KEY (`id_localizacao`) REFERENCES `localizacoes` (`id_chave_localizacao`),
  CONSTRAINT `acoes_ibfk_4` FOREIGN KEY (`id_tipo_acao`) REFERENCES `tipos_acoes` (`id_chave_tipo_acao`),
  CONSTRAINT `acoes_ibfk_5` FOREIGN KEY (`id_arquivo`) REFERENCES `arquivos` (`id_chave_arquivo`),
  CONSTRAINT `fk_acoes_pessoas` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoas` (`id_chave_pessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

DELIMITER $$

CREATE TRIGGER trg_gerar_hash_acao
BEFORE INSERT ON acoes
FOR EACH ROW
BEGIN
  IF NEW.hash_acao IS NULL THEN
    SET NEW.hash_acao = SHA2(UUID(), 512);
  END IF;
END$$

DELIMITER ;

CREATE TABLE mensagens (
	id_chave_mensagem INT NOT NULL AUTO_INCREMENT,
	nome_mensagem VARCHAR(255),
	texto_mensagem TEXT,
	id_usuario_remetente int,
	id_usuario_destinatario int,
        data_mensagem timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id_chave_mensagem),
	CONSTRAINT fk_mensagem1 FOREIGN Key (id_usuario_remetente) REFERENCES usuarios(id_chave_usuario),
	CONSTRAINT fk_mensagem2 FOREIGN Key (id_usuario_destinatario) REFERENCES usuarios(id_chave_usuario)
);



