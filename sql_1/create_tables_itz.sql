






# TABELAS SEM CONSTRAINTS




/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `esferas_institucionais` (
  `id_chave_esfera_institucional` int NOT NULL AUTO_INCREMENT,
  `nome_esfera_institucional` varchar(40) NOT NULL,
  `descricao` text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_esfera_institucional`),
  UNIQUE KEY `nome_esfera_institucional` (`nome_esfera_institucional`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  PRIMARY KEY (`id_chave_pessoa`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_arquivos` (
  `id_chave_tipo_arquivo` int NOT NULL AUTO_INCREMENT,
  `nome_tipo_arquivo` varchar(255) NOT NULL,
  `extensao` varchar(10) NOT NULL,
  `descricao` text NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_tipo_arquivo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_elementos_sintaticos` (
  `id_chave_tipo_elemento_sintatico` int NOT NULL AUTO_INCREMENT,
  `nome_tipo_elemento_sintatico` varchar(255) NOT NULL,
  `descricao` text NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chave_tipo_elemento_sintatico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

