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