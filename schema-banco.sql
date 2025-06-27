-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: banco
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `classificacao_cliente`
--

DROP TABLE IF EXISTS `classificacao_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classificacao_cliente` (
  `id_classificacao` int NOT NULL AUTO_INCREMENT,
  `nome_classificacao` varchar(50) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_classificacao`),
  UNIQUE KEY `nome_classificacao_UNIQUE` (`nome_classificacao`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_transacao`
--

DROP TABLE IF EXISTS `tipo_transacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_transacao` (
  `id_tipo_transacao` int NOT NULL AUTO_INCREMENT,
  `nome_tipo` varchar(50) NOT NULL,
  `natureza` enum('Credito','Debito') NOT NULL,
  `descricao_tipo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_transacao`),
  UNIQUE KEY `nome_tipo_UNIQUE` (`nome_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_conta`
--

DROP TABLE IF EXISTS `tipo_conta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_conta` (
  `id_tipo_conta` int NOT NULL AUTO_INCREMENT,
  `nome_tipo` varchar(50) NOT NULL,
  `descricao_tipo` varchar(255) DEFAULT NULL,
  `taxa_manutencao` decimal(8,2) NOT NULL,
  `taxa_rendimento_anual` decimal(5,4) NOT NULL,
  `limite_transacao_diario` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_tipo_conta`),
  UNIQUE KEY `nome_tipo_UNIQUE` (`nome_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `tipo_cliente` enum('Fisica','Juridica') NOT NULL,
  `cpf` varchar(11) DEFAULT NULL,
  `cnpj` varchar(14) DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `razao_social` varchar(100) DEFAULT NULL,
  `nome_fantasia` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `data_inicio_atividade` date DEFAULT NULL,
  `data_cadastro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_classificacao` int DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`),
  UNIQUE KEY `cnpj_UNIQUE` (`cnpj`),
  KEY `id_classificacao_idx` (`id_classificacao`),
  CONSTRAINT `fk_id_classificacao` FOREIGN KEY (`id_classificacao`) REFERENCES `classificacao_cliente` (`id_classificacao`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conta`
--

DROP TABLE IF EXISTS `conta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conta` (
  `id_conta` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_tipo_conta` int NOT NULL,
  `numero_conta` varchar(20) NOT NULL,
  `saldo` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status_conta` enum('Ativa','Bloqueada','Cancelada','Suspensa') NOT NULL DEFAULT 'Ativa',
  `data_criacao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_fechamento` datetime DEFAULT NULL,
  PRIMARY KEY (`id_conta`),
  UNIQUE KEY `numero_conta_UNIQUE` (`numero_conta`),
  KEY `fk_conta_id_cliente_idx` (`id_cliente`),
  KEY `fk_conta_tipo_conta_idx` (`id_tipo_conta`),
  CONSTRAINT `fk_conta_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_conta_tipo_conta` FOREIGN KEY (`id_tipo_conta`) REFERENCES `tipo_conta` (`id_tipo_conta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contato_telefone`
--

DROP TABLE IF EXISTS `contato_telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contato_telefone` (
  `id_telefone` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `ddd` varchar(3) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `tipo_contato` enum('Celular','Residencial','Comercial','Recado','Outro') NOT NULL,
  `is_whatsapp` tinyint NOT NULL DEFAULT '0',
  `observacao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_telefone`),
  KEY `fk_id_cliente_idx` (`id_cliente`),
  CONSTRAINT `fk_contato_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `endereco` (
  `id_endereco` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `logradouro` varchar(255) NOT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `bairro` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` char(2) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `tipo_endereco` enum('Residencial','Comercial','Entrega','Cobranca','Outro') NOT NULL,
  `is_padrao` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_endereco`),
  KEY `fk_id_cliente_idx` (`id_cliente`),
  CONSTRAINT `fk_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cartao`
--

DROP TABLE IF EXISTS `cartao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartao` (
  `id_cartao` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_conta` int NOT NULL,
  `numero_cartao` varchar(19) NOT NULL,
  `tipo_cartao` enum('Credito','Debito','Multiplo') NOT NULL,
  `limite_mensal_credito` decimal(12,2) DEFAULT NULL,
  `limite_diario_uso` decimal(12,2) DEFAULT NULL,
  `mes_vencimento` int NOT NULL,
  `ano_vencimento` int NOT NULL,
  `data_emissao` date DEFAULT NULL,
  `status_cartao` enum('Ativo','Bloqueado','Cancelado','Perdido','Roubado','Expirado') NOT NULL DEFAULT 'Ativo',
  PRIMARY KEY (`id_cartao`),
  UNIQUE KEY `numero_cartao_UNIQUE` (`numero_cartao`),
  KEY `fk_cliente_id_cliente_idx` (`id_cliente`),
  KEY `fk_conta_id_conta_idx` (`id_conta`),
  CONSTRAINT `fk_cliente_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_conta_id_conta` FOREIGN KEY (`id_conta`) REFERENCES `conta` (`id_conta`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transacao_financeira`
--

DROP TABLE IF EXISTS `transacao_financeira`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacao_financeira` (
  `id_transacao` int NOT NULL AUTO_INCREMENT,
  `id_conta` int NOT NULL,
  `id_tipo_transacao` int NOT NULL,
  `valor` decimal(12,2) NOT NULL,
  `data_hora_transacao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `descricao` varchar(255) DEFAULT NULL,
  `status_transacao` enum('Concluida','Pendente','Cancelada','Falha') NOT NULL DEFAULT 'Concluida',
  `codigo_referencia_externa` varchar(50) DEFAULT NULL,
  `dados_favorecido_destino` varchar(255) DEFAULT NULL,
  `id_transacao_vinculada` int DEFAULT NULL,
  PRIMARY KEY (`id_transacao`),
  KEY `idx_transacao_financeira_id_conta` (`id_conta`),
  KEY `idx_transacao_financeira_id_tipo_transacao` (`id_tipo_transacao`),
  KEY `idx_transacao_financeira_id_transacao_vinculada` (`id_transacao_vinculada`),
  CONSTRAINT `fk_transacao_financeira_vinculada` FOREIGN KEY (`id_transacao_vinculada`) REFERENCES `transacao_financeira` (`id_transacao`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_transacao_id_conta` FOREIGN KEY (`id_conta`) REFERENCES `conta` (`id_conta`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_transacao_id_tipo_transacao` FOREIGN KEY (`id_tipo_transacao`) REFERENCES `tipo_transacao` (`id_tipo_transacao`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fatura`
--

DROP TABLE IF EXISTS `fatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fatura` (
  `id_fatura` int NOT NULL AUTO_INCREMENT,
  `id_cartao` int NOT NULL,
  `data_vencimento` date NOT NULL,
  `data_fechamento` date NOT NULL,
  `valor_total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `valor_pago` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status_fatura` enum('Aberta','Fechada','Paga','Parcialmente Paga','Atrasada') NOT NULL DEFAULT 'Aberta',
  PRIMARY KEY (`id_fatura`),
  KEY `fk_fatura_id_cartao_idx` (`id_cartao`),
  CONSTRAINT `fk_fatura_id_cartao` FOREIGN KEY (`id_cartao`) REFERENCES `cartao` (`id_cartao`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `login` varchar(100) NOT NULL,
  `hash_senha` varchar(255) NOT NULL,
  `data_cadastro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ativo` tinyint NOT NULL DEFAULT '1',
  `ultimo_login` datetime DEFAULT NULL,
  `id_conta_principal` int DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `login_UNIQUE` (`login`),
  KEY `fk_usuario_id_cliente_idx` (`id_cliente`),
  KEY `fk_usuario_id_conta_idx` (`id_conta_principal`),
  CONSTRAINT `fk_usuario_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_id_conta` FOREIGN KEY (`id_conta_principal`) REFERENCES `conta` (`id_conta`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-26 23:33:01
