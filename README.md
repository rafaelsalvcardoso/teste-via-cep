# 📌 CRUD de Endereços em Delphi com MVC, MSSQL e Integração ViaCEP

Este é um projeto de exemplo desenvolvido em **Delphi** com foco em boas práticas de arquitetura, design patterns e integração com serviços externos. A aplicação realiza o **CRUD de endereços** e permite o preenchimento automático de dados via consulta ao **ViaCEP**, suportando **retorno em JSON ou XML**.

---

## 🚀 Funcionalidades

- ✅ Cadastro de endereços (CEP, Logradouro, Bairro, Cidade, Estado)
- ✅ Inserção e listagem com grid visual
- ✅ Consulta de CEP com integração à API ViaCEP
- ✅ Suporte a retorno JSON e XML
- ✅ Conexão dinâmica com MSSQL via FireDAC
- ✅ Arquitetura limpa com **MVC**
- ✅ Uso dos padrões de projeto:
  - `Factory Method` (para conexão com banco)
  - `Strategy` (para desserialização de JSON/XML)
  - `DAO` + `Interfaces` para acesso a dados
- ✅ Projeto orientado a objetos

---

## 🧱 Estrutura do Projeto

```
TesteViaCEP.exe/
│
├── Model/                → Classes de domínio (ex: TEndereco)
├── DAO/                  → Interface e implementação do DAO
├── Controller/           → Interface e implementação dos controllers
├── Factory/              → Conexão dinâmica com padrão Factory Method
├── Service/              → Consulta ViaCEP + desserialização (Strategy)
├── View/                 → Formulário principal com interação de usuário
├── Main/                 → Arquivo .dpr e inicialização
```

---

## 🛠️ Tecnologias Utilizadas

- **Delphi 12.3** 
- **FireDAC** (acesso ao MSSQL)
- **MSSQL** como banco de dados relacional
- **Design Patterns** (Strategy, Factory, DAO, MVC)

---

## 🧪 Banco de Dados

### Script SQL para MSSQL:

```sql
-- Criação do banco de dados
CREATE DATABASE TesteDB;
GO

-- Seleciona o banco
USE TesteDB;
GO

-- Criação da tabela 'enderecos'
CREATE TABLE enderecos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cep VARCHAR(9) NOT NULL,
    logradouro VARCHAR(255) NOT NULL,
    complemento VARCHAR(255) NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL
);
GO
```

---

## ⚙️ Configuração

1. Clone este repositório:
   ```bash
   git clone https://github.com/rafaelsalvcardoso/teste-via-cep.git
   ```

2. Abra o projeto `ViaCEP` em  `\teste-via-cep\componente`
 
3. Compilar e instalar.

4. Adicionar ao Library Path o caminho até o diretório `\teste-via-cep\componente\src`

5. Abra o projeto `.dpr` no Delphi.

6. Ajuste os parâmetros de conexão com o banco em `.\src\Factor\Teste.Connection.Factory\TConnectionFactory.ConfigureConnection`:
   ```delphi
   procedure TConnectionFactory.ConfigureConnection;
   begin
     try
       FConnection.ConnectionName := 'ConnectionObj';
       FConnection.DriverName := 'MSSQL';
       FConnection.LoginPrompt := False;
       FConnection.Connected := False;
       FConnection.Params.Values['DataBase'] := 'TesteDB';
       FConnection.Params.Values['User_Name'] := 'sa';
       FConnection.Params.Values['Password'] := 'SuperPassword@25';
       FConnection.Params.Values['Server'] := 'localhost';
       FConnection.Params.Values['DriverID'] := 'MSSQL';
       FConnection.Connected := True;
     except
       raise Exception.Create('Erro ao conectar o banco de dados!');
     end;
   end;
   ```
7. DLL do diretório dlls devem ser copiados junto ao executável da aplicação.

8. Compile e execute!

---

## 🔍 Como funciona a integração ViaCEP?

O projeto utiliza o padrão **Strategy** para selecionar dinamicamente o tipo de desserialização de acordo com o formato (JSON ou XML).

### Exemplo:
```delphi
Endereco := TViaCEPService.ConsultarPorCEP(CepEdit.Text, vcJSON); // ou vcXML
```
