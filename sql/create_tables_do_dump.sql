-- Alterado por Victor Mammana
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: papedins_db
-- Generation Time: Sep 21, 2024 at 11:47 PM
-- Server version: 8.0.39
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

DROP DATABASE IF EXISTS `papedins_db`;

CREATE DATABASE IF NOT EXISTS `papedins_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `papedins_db`;

CREATE TABLE `acoes` (
  `id_chave_acao` int NOT NULL,
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
  `id_pessoa` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `arquivos` (
  `id_chave_arquivo` int NOT NULL,
  `nome_arquivo` varchar(255) NOT NULL,
  `id_tipo_arquivo` int DEFAULT NULL,
  `caminho_arquivo_original` varchar(255) NOT NULL,
  `caminho_arquivo_anonimizado` varchar(255) DEFAULT NULL,
  `quantidade_pessoas` int DEFAULT '0',
  `descricao_imagem` text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `atividades_eventos` (
  `id_chave_atividade_evento` int NOT NULL,
  `nome_atividade_evento` varchar(255) NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_usuario` int DEFAULT NULL,
  `data_atividade_evento` date DEFAULT NULL,
  `hora_atividade_evento` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `cidades` (
  `id_chave_cidade` int NOT NULL,
  `codigo_ibge` int DEFAULT NULL,
  `nome_cidade` varchar(255) NOT NULL,
  `id_estado` int NOT NULL,
  `populacao` int DEFAULT NULL,
  `area_km2` decimal(10,2) DEFAULT NULL,
  `densidade_demografica` decimal(8,2) DEFAULT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `gentilico` varchar(100) DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `enderecos` (
  `id_chave_endereco` int NOT NULL,
  `id_instituicao` int DEFAULT NULL,
  `id_localizacao` int NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `esferas_institucionais` (
  `id_chave_esfera_institucional` int NOT NULL,
  `nome_esfera_institucional` varchar(40) NOT NULL,
  `descricao` text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `estados` (
  `id_chave_estado` int NOT NULL,
  `nome_estado` varchar(255) NOT NULL,
  `sigla_estado` char(2) NOT NULL,
  `codigo_ibge` int NOT NULL,
  `regiao` varchar(100) DEFAULT NULL,
  `populacao_estimada` int DEFAULT NULL,
  `area_total` decimal(10,2) DEFAULT NULL,
  `densidade_demografica` decimal(8,2) DEFAULT NULL,
  `capital` varchar(100) DEFAULT NULL,
  `id_pais` int DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `instituicoes` (
  `id_chave_instituicao` int NOT NULL,
  `nome_instituicao` varchar(255) NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_tipo_instituicao` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `localizacoes` (
  `id_chave_localizacao` int NOT NULL,
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
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `paises` (
  `id_chave_pais` int NOT NULL,
  `nome_pais` varchar(255) NOT NULL,
  `codigo_iso` varchar(3) NOT NULL,
  `populacao_estimada` bigint DEFAULT NULL,
  `area_total` decimal(12,2) DEFAULT NULL,
  `densidade_demografica` decimal(10,2) DEFAULT NULL,
  `capital` varchar(100) NOT NULL,
  `regiao` varchar(100) NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pessoas` (
  `id_chave_pessoa` int NOT NULL,
  `nome_pessoa` varchar(255) NOT NULL,
  `cpf` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tabelas_mantidas` (
  `id_tabela_mantida` int NOT NULL,
  `nome_tabela_mantida` varchar(255) NOT NULL,
  `descricao` varchar(1000) NOT NULL,
  `manter` tinyint(1) NOT NULL,
  `data_insercao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tipos_acoes` (
  `id_chave_tipo_acao` int NOT NULL,
  `nome_tipo_acao` varchar(255) NOT NULL,
  `id_token` int DEFAULT NULL,
  `id_tipo_elemento_sintatico` int DEFAULT NULL,
  `ordem` int DEFAULT NULL,
  `id_tipo_resultado` int DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tipos_arquivos` (
  `id_chave_tipo_arquivo` int NOT NULL,
  `nome_tipo_arquivo` varchar(255) NOT NULL,
  `extensao` varchar(10) NOT NULL,
  `descricao` text NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tipos_elementos_sintaticos` (
  `id_chave_tipo_elemento_sintatico` int NOT NULL,
  `nome_tipo_elemento_sintatico` varchar(255) NOT NULL,
  `descricao` text NOT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tipos_flexoes` (
  `id_chave_tipo_flexao` int NOT NULL,
  `nome_tipo_flexao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `acentuada` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_insercao` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tipos_instituicoes` (
  `id_chave_tipo_instituicao` int NOT NULL,
  `nome_tipo_instituicao` varchar(255) NOT NULL,
  `descricao` text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_esfera_institucional` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tipos_resultados` (
  `id_chave_tipo_resultado` int NOT NULL,
  `nome_tipo_resultado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `numeracao_tipo_resultado` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_tipo_resultado_pai` int DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tipos_tokens` (
  `id_chave_tipo_token` int NOT NULL,
  `nome_tipo_token` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `acentuada` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tipo_token_pai` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_insercao` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tipos_vinculos` (
  `id_chave_tipo_vinculo` int NOT NULL,
  `nome_tipo_vinculo` varchar(100) NOT NULL,
  `descricao` text,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tokens` (
  `id_chave_token` int NOT NULL,
  `nome_token` varchar(200) NOT NULL,
  `id_tipo_token` int DEFAULT NULL,
  `id_raiz` int DEFAULT NULL,
  `id_tipo_flexao` int DEFAULT NULL,
  `id_grupo_token` int DEFAULT NULL,
  `data_insercao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL,
  `nome_usuario` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `data_inicio_cadastro` date NOT NULL,
  `data_fim_cadastro` date DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_pessoa` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `vinculos` (
  `id_chave_vinculo` int NOT NULL,
  `id_pessoa` int NOT NULL,
  `id_instituicao` int NOT NULL,
  `id_tipo_vinculo` int NOT NULL,
  `data_inicio_vinculo` date NOT NULL,
  `data_fim_vinculo` date DEFAULT NULL,
  `data_insercao` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `acoes`
  ADD PRIMARY KEY (`id_chave_acao`),
  ADD KEY `id_atividade_evento` (`id_atividade_evento`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_localizacao` (`id_localizacao`),
  ADD KEY `id_tipo_acao` (`id_tipo_acao`),
  ADD KEY `id_arquivo` (`id_arquivo`),
  ADD KEY `fk_acoes_pessoas` (`id_pessoa`);

ALTER TABLE `arquivos`
  ADD PRIMARY KEY (`id_chave_arquivo`),
  ADD KEY `id_tipo_arquivo` (`id_tipo_arquivo`);

ALTER TABLE `atividades_eventos`
  ADD PRIMARY KEY (`id_chave_atividade_evento`),
  ADD KEY `id_usuario` (`id_usuario`);

ALTER TABLE `cidades`
  ADD PRIMARY KEY (`id_chave_cidade`),
  ADD UNIQUE KEY `codigo_ibge` (`codigo_ibge`),
  ADD KEY `id_estado` (`id_estado`);

ALTER TABLE `enderecos`
  ADD PRIMARY KEY (`id_chave_endereco`),
  ADD KEY `id_instituicao` (`id_instituicao`),
  ADD KEY `id_localizacao` (`id_localizacao`);

ALTER TABLE `esferas_institucionais`
  ADD PRIMARY KEY (`id_chave_esfera_institucional`),
  ADD UNIQUE KEY `nome_esfera_institucional` (`nome_esfera_institucional`);

ALTER TABLE `estados`
  ADD PRIMARY KEY (`id_chave_estado`),
  ADD KEY `id_pais` (`id_pais`);

ALTER TABLE `instituicoes`
  ADD PRIMARY KEY (`id_chave_instituicao`),
  ADD UNIQUE KEY `nome_instituicao` (`nome_instituicao`),
  ADD KEY `id_tipo_instituicao` (`id_tipo_instituicao`);

ALTER TABLE `localizacoes`
  ADD PRIMARY KEY (`id_chave_localizacao`),
  ADD KEY `id_cidade` (`id_cidade`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `id_pais` (`id_pais`);

ALTER TABLE `paises`
  ADD PRIMARY KEY (`id_chave_pais`),
  ADD UNIQUE KEY `codigo_iso` (`codigo_iso`);

ALTER TABLE `pessoas`
  ADD PRIMARY KEY (`id_chave_pessoa`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `cpf` (`cpf`);

ALTER TABLE `tabelas_mantidas`
  ADD PRIMARY KEY (`id_tabela_mantida`),
  ADD UNIQUE KEY `nome_tabela_mantida` (`nome_tabela_mantida`);

ALTER TABLE `tipos_acoes`
  ADD PRIMARY KEY (`id_chave_tipo_acao`),
  ADD UNIQUE KEY `id_token` (`id_token`,`id_tipo_elemento_sintatico`,`ordem`),
  ADD KEY `id_tipo_elemento_sintatico` (`id_tipo_elemento_sintatico`),
  ADD KEY `id_tipo_resultado` (`id_tipo_resultado`);

ALTER TABLE `tipos_arquivos`
  ADD PRIMARY KEY (`id_chave_tipo_arquivo`);

ALTER TABLE `tipos_elementos_sintaticos`
  ADD PRIMARY KEY (`id_chave_tipo_elemento_sintatico`);

ALTER TABLE `tipos_flexoes`
  ADD PRIMARY KEY (`id_chave_tipo_flexao`),
  ADD UNIQUE KEY `nome_tipo_flexao` (`nome_tipo_flexao`),
  ADD UNIQUE KEY `acentuada` (`acentuada`);

ALTER TABLE `tipos_instituicoes`
  ADD PRIMARY KEY (`id_chave_tipo_instituicao`),
  ADD UNIQUE KEY `nome_tipo_instituicao` (`nome_tipo_instituicao`),
  ADD KEY `id_esfera_institucional` (`id_esfera_institucional`);

ALTER TABLE `tipos_resultados`
  ADD PRIMARY KEY (`id_chave_tipo_resultado`),
  ADD KEY `fk_tipo_resultado_pai` (`id_tipo_resultado_pai`);

ALTER TABLE `tipos_tokens`
  ADD PRIMARY KEY (`id_chave_tipo_token`),
  ADD UNIQUE KEY `nome_tipo_token` (`nome_tipo_token`),
  ADD KEY `tipo_token_pai` (`tipo_token_pai`);

ALTER TABLE `tipos_vinculos`
  ADD PRIMARY KEY (`id_chave_tipo_vinculo`),
  ADD UNIQUE KEY `nome_tipo_vinculo` (`nome_tipo_vinculo`);

ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id_chave_token`),
  ADD UNIQUE KEY `nome_token` (`nome_token`,`id_tipo_token`),
  ADD KEY `id_tipo_token` (`id_tipo_token`),
  ADD KEY `id_raiz` (`id_raiz`),
  ADD KEY `id_tipo_flexao` (`id_tipo_flexao`),
  ADD KEY `id_grupo_token` (`id_grupo_token`);

ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `nome_usuario` (`nome_usuario`),
  ADD KEY `id_pessoa` (`id_pessoa`);

ALTER TABLE `vinculos`
  ADD PRIMARY KEY (`id_chave_vinculo`),
  ADD KEY `id_pessoa` (`id_pessoa`),
  ADD KEY `id_instituicao` (`id_instituicao`),
  ADD KEY `id_tipo_vinculo` (`id_tipo_vinculo`);

ALTER TABLE `acoes`
  MODIFY `id_chave_acao` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `arquivos`
  MODIFY `id_chave_arquivo` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `atividades_eventos`
  MODIFY `id_chave_atividade_evento` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `cidades`
  MODIFY `id_chave_cidade` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `enderecos`
  MODIFY `id_chave_endereco` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `esferas_institucionais`
  MODIFY `id_chave_esfera_institucional` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `estados`
  MODIFY `id_chave_estado` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `instituicoes`
  MODIFY `id_chave_instituicao` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `localizacoes`
  MODIFY `id_chave_localizacao` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `paises`
  MODIFY `id_chave_pais` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `pessoas`
  MODIFY `id_chave_pessoa` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tabelas_mantidas`
  MODIFY `id_tabela_mantida` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tipos_acoes`
  MODIFY `id_chave_tipo_acao` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tipos_arquivos`
  MODIFY `id_chave_tipo_arquivo` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tipos_elementos_sintaticos`
  MODIFY `id_chave_tipo_elemento_sintatico` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tipos_flexoes`
  MODIFY `id_chave_tipo_flexao` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tipos_instituicoes`
  MODIFY `id_chave_tipo_instituicao` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tipos_resultados`
  MODIFY `id_chave_tipo_resultado` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tipos_tokens`
  MODIFY `id_chave_tipo_token` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tipos_vinculos`
  MODIFY `id_chave_tipo_vinculo` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tokens`
  MODIFY `id_chave_token` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `usuarios`
  MODIFY `id_usuario` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `vinculos`
  MODIFY `id_chave_vinculo` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `acoes`
  ADD CONSTRAINT `acoes_ibfk_1` FOREIGN KEY (`id_atividade_evento`) REFERENCES `atividades_eventos` (`id_chave_atividade_evento`),
  ADD CONSTRAINT `acoes_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `acoes_ibfk_3` FOREIGN KEY (`id_localizacao`) REFERENCES `localizacoes` (`id_chave_localizacao`),
  ADD CONSTRAINT `acoes_ibfk_4` FOREIGN KEY (`id_tipo_acao`) REFERENCES `tipos_acoes` (`id_chave_tipo_acao`),
  ADD CONSTRAINT `acoes_ibfk_5` FOREIGN KEY (`id_arquivo`) REFERENCES `arquivos` (`id_chave_arquivo`),
  ADD CONSTRAINT `fk_acoes_pessoas` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoas` (`id_chave_pessoa`);

ALTER TABLE `arquivos`
  ADD CONSTRAINT `arquivos_ibfk_1` FOREIGN KEY (`id_tipo_arquivo`) REFERENCES `tipos_arquivos` (`id_chave_tipo_arquivo`);

ALTER TABLE `atividades_eventos`
  ADD CONSTRAINT `atividades_eventos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

ALTER TABLE `cidades`
  ADD CONSTRAINT `cidades_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_chave_estado`);

ALTER TABLE `enderecos`
  ADD CONSTRAINT `enderecos_ibfk_1` FOREIGN KEY (`id_instituicao`) REFERENCES `instituicoes` (`id_chave_instituicao`),
  ADD CONSTRAINT `enderecos_ibfk_2` FOREIGN KEY (`id_localizacao`) REFERENCES `localizacoes` (`id_chave_localizacao`);

ALTER TABLE `estados`
  ADD CONSTRAINT `estados_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_chave_pais`);

ALTER TABLE `instituicoes`
  ADD CONSTRAINT `instituicoes_ibfk_1` FOREIGN KEY (`id_tipo_instituicao`) REFERENCES `tipos_instituicoes` (`id_chave_tipo_instituicao`);

ALTER TABLE `localizacoes`
  ADD CONSTRAINT `localizacoes_ibfk_1` FOREIGN KEY (`id_cidade`) REFERENCES `cidades` (`id_chave_cidade`),
  ADD CONSTRAINT `localizacoes_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_chave_estado`),
  ADD CONSTRAINT `localizacoes_ibfk_3` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_chave_pais`);

ALTER TABLE `tipos_acoes`
  ADD CONSTRAINT `tipos_acoes_ibfk_1` FOREIGN KEY (`id_token`) REFERENCES `tokens` (`id_chave_token`),
  ADD CONSTRAINT `tipos_acoes_ibfk_2` FOREIGN KEY (`id_tipo_elemento_sintatico`) REFERENCES `tipos_elementos_sintaticos` (`id_chave_tipo_elemento_sintatico`),
  ADD CONSTRAINT `tipos_acoes_ibfk_3` FOREIGN KEY (`id_tipo_resultado`) REFERENCES `tipos_resultados` (`id_chave_tipo_resultado`);

ALTER TABLE `tipos_instituicoes`
  ADD CONSTRAINT `tipos_instituicoes_ibfk_1` FOREIGN KEY (`id_esfera_institucional`) REFERENCES `esferas_institucionais` (`id_chave_esfera_institucional`);

ALTER TABLE `tipos_resultados`
  ADD CONSTRAINT `fk_tipo_resultado_pai` FOREIGN KEY (`id_tipo_resultado_pai`) REFERENCES `tipos_resultados` (`id_chave_tipo_resultado`);

ALTER TABLE `tipos_tokens`
  ADD CONSTRAINT `tipos_tokens_ibfk_1` FOREIGN KEY (`tipo_token_pai`) REFERENCES `tipos_tokens` (`nome_tipo_token`);

ALTER TABLE `tokens`
  ADD CONSTRAINT `fk_raiz_token` FOREIGN KEY (`id_raiz`) REFERENCES `tokens` (`id_chave_token`),
  ADD CONSTRAINT `fk_tipo_flexao` FOREIGN KEY (`id_tipo_flexao`) REFERENCES `tipos_flexoes` (`id_chave_tipo_flexao`),
  ADD CONSTRAINT `fk_tipo_token` FOREIGN KEY (`id_tipo_token`) REFERENCES `tipos_tokens` (`id_chave_tipo_token`);

ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoas` (`id_chave_pessoa`);

ALTER TABLE `vinculos`
  ADD CONSTRAINT `vinculos_ibfk_1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoas` (`id_chave_pessoa`),
  ADD CONSTRAINT `vinculos_ibfk_2` FOREIGN KEY (`id_instituicao`) REFERENCES `instituicoes` (`id_chave_instituicao`),
  ADD CONSTRAINT `vinculos_ibfk_3` FOREIGN KEY (`id_tipo_vinculo`) REFERENCES `tipos_vinculos` (`id_chave_tipo_vinculo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
