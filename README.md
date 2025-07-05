# 🏦 Sistema Bancário – Esquema de Banco de Dados MySQL

Este repositório contém o esquema de banco de dados para um sistema bancário básico, implementado em **MySQL**. O objetivo é fornecer uma estrutura fundamental para gerenciar **clientes**, **contas**, **transações**, **cartões** e **faturas**.

---

## 🛠️ Tecnologias Utilizadas

- **MySQL 8.0.x**: Sistema de Gerenciamento de Banco de Dados Relacional (SGBD).
- **MySQL Workbench 8.0.x**: Ferramenta visual para modelagem e gerenciamento do banco.

---

## 🧱 Estrutura do Banco de Dados

O banco de dados é composto pelas seguintes **tabelas principais**, projetadas para cobrir funcionalidades essenciais de um sistema bancário:

| Tabela                 | Descrição                                                                 |
|------------------------|---------------------------------------------------------------------------|
| `classificacao_cliente`| Classificação do cliente (ex: Padrão, Premium, VIP).                      |
| `tipo_transacao`       | Tipos de transações (ex: Depósito, Saque, PIX, Estorno).                  |
| `tipo_conta`           | Tipos de conta bancária (ex: Corrente, Poupança).                         |
| `cliente`              | Informações pessoais ou jurídicas dos clientes.                           |
| `conta`                | Detalhes das contas bancárias, como saldo e status.                       |
| `contato_telefone`     | Telefones associados aos clientes.                                        |
| `endereco`             | Endereços residenciais ou comerciais dos clientes.                        |
| `cartao`               | Informações sobre cartões (crédito, débito, múltiplos).                   |
| `transacao_financeira` | Registro das movimentações financeiras.                                   |
| `fatura`               | Controle de faturas vinculadas aos cartões.                               |
| `usuario`              | Dados de autenticação para acesso ao sistema.                             |

📄 O arquivo `database/schema-banco.sql` contém todos os comandos `CREATE TABLE`, organizados conforme as dependências entre chaves estrangeiras.

---

## 🖼️ Diagrama (Modelo Lógico)

Visualização do modelo conceitual e lógico do banco:

- 📘 **Modelo Conceitual**  
  ![Modelo Conceitual](assets/Modelo%20Conceitual.png)

- 📗 **Modelo Lógico**  
  ![Modelo Lógico](assets/Modelo%20Logico.png)


---

## 🚀 Como Implementar o Banco de Dados

### 📋 Pré-requisitos

- ✅ MySQL Server (versão 8.0.x ou compatível)
- ✅ MySQL Workbench (ou outro cliente de sua preferência)

### 🔧 Passos

1. **Clone o Repositório**

```bash
git clone https://github.com/edbsjr/meu-sistema-bancario.git
```

2. **Acesse o Diretório do Projeto**

```bash
cd meu-sistema-bancario
```

3. **Crie o Banco de Dados**

Conecte-se ao seu MySQL e crie o schema:

```bash
CREATE SCHEMA `banco` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
```

4. **Execute o Script SQL**

No MySQL Workbench:

  - Abra o arquivo database/schema-banco.sql.

  - Conecte-se ao seu servidor MySQL.

  - Selecione o schema banco.

  - Execute o script (Ctrl + Shift + Enter).

Via Linha de Comando:

```bash
mysql -u seu_usuario -p banco < database/schema-banco.sql
```
(Será solicitada sua senha. Substitua seu_usuario pelo nome do seu usuário MySQL.)

## 🧪 Inserindo Dados de Teste (Opcional)
Caso tenha um script com INSERTs, você pode executá-lo após a criação das tabelas para popular o banco com dados de teste.

```bash
mysql -u seu_usuario -p banco < database/dados-de-teste.sql
```
## 🤝 Contribuição
Contribuições são bem-vindas! Sinta-se à vontade para abrir uma issue ou enviar um pull request com melhorias para a estrutura do banco ou correções.

## 📁 Estrutura de Pastas
```plaintext
meu-sistema-bancario/
├── database/
│   ├── schema-banco.sql
│   └── dados-de-teste.sql (Breve)
├── assets/
│   ├── Modelo Conceitual.png
│   └── Modelo Logico.png
├── docs/
└── RESUMO EXPANDIDO EDUARDO BATISTA
└── README.md
```

## 📜 Licença
Este projeto é de uso acadêmico e está disponível sem restrições para fins educacionais.

