-- Criação do banco
DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;
SET SQL_SAFE_UPDATES = 0;

-- Tabela de níveis de associação
CREATE TABLE nivel_associacao (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(50) NOT NULL
);

-- Tabela de usuários
CREATE TABLE usuario (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 identificacao VARCHAR(20) UNIQUE NOT NULL,
 email VARCHAR(100) NOT NULL,
 data_cadastro DATE NOT NULL,
 nivel_id INT,
 FOREIGN KEY (nivel_id) REFERENCES nivel_associacao(id)
);
-- Tabela de autores
CREATE TABLE autor (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 data_nascimento DATE,
 biografia TEXT
);

-- Tabela de categorias
CREATE TABLE categoria (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(50) NOT NULL
);

-- Tabela de livros
CREATE TABLE livro (
 id INT AUTO_INCREMENT PRIMARY KEY,
 titulo VARCHAR(200) NOT NULL,
 isbn VARCHAR(20) UNIQUE NOT NULL,
 descricao TEXT
);

-- Relacionamento N:N entre livros e autores
CREATE TABLE livro_autor (
 livro_id INT,
 autor_id INT,
 PRIMARY KEY (livro_id, autor_id),
 FOREIGN KEY (livro_id) REFERENCES livro(id),
 FOREIGN KEY (autor_id) REFERENCES autor(id)
);

-- Relacionamento N:N entre livros e categorias
CREATE TABLE livro_categoria (
 livro_id INT,
 categoria_id INT,
 PRIMARY KEY (livro_id, categoria_id),
 FOREIGN KEY (livro_id) REFERENCES livro(id),
 FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

-- Tabela de empréstimos
CREATE TABLE emprestimo (
 id INT AUTO_INCREMENT PRIMARY KEY,
 usuario_id INT,
 livro_id INT,
 data_emprestimo DATE NOT NULL,
 data_limite DATE NOT NULL,
 data_devolucao DATE,
 FOREIGN KEY (usuario_id) REFERENCES usuario(id),
 FOREIGN KEY (livro_id) REFERENCES livro(id)
);

-- Inserindo dados em nivel_associacao
INSERT INTO nivel_associacao (nome) VALUES
('Regular'),
('Premium'),
('Estudante'),
('Professor'),
('Visitante'),
('Parceiro');

-- Inserindo dados em usuario (10 registros)
INSERT INTO usuario (nome, identificacao, email, data_cadastro, nivel_id) VALUES
('Ana Souza', 'USR001', 'ana@email.com', '2023-01-10', 1),
('Carlos Lima', 'USR002', 'carlos@email.com', '2023-02-15', 2),
('Juliana Rocha', 'USR003', 'juliana@email.com', '2023-03-05', 3),
('Lucas Martins', 'USR004', 'lucas@email.com', '2023-04-20', 4),
('Fernanda Alves', 'USR005', 'fernanda@email.com', '2023-05-30', 5),
('Rafael Pinto', 'USR006', 'rafael@email.com', '2023-06-18', 6),
('Mariana Costa', 'USR007', 'mariana@email.com', '2023-07-22', 1),
('Pedro Gomes', 'USR008', 'pedro@email.com', '2023-08-13', 2),
('Bianca Dias', 'USR009', 'bianca@email.com', '2023-09-05', 3),
('Thiago Souza', 'USR010', 'thiago@email.com', '2023-10-01', 4);

-- Inserindo dados em autor (10 registros)
INSERT INTO autor (nome, data_nascimento, biografia) VALUES
('José Saramago', '1922-11-16', 'Autor português vencedor do Nobel.'),
('Clarice Lispector', '1920-12-10', 'Autora modernista brasileira.'),
('George Orwell', '1903-06-25', 'Famoso por 1984 e A Revolução dos Bichos.'),
('Machado de Assis', '1839-06-21', 'Autor realista brasileiro.'),
('Agatha Christie', '1890-09-15', 'Rainha do crime.'),
('J. K. Rowling', '1965-07-31', 'Autora da saga Harry Potter.'),
('Paulo Coelho', '1947-08-24', 'Autor brasileiro famoso mundialmente.'),
('Isaac Asimov', '1920-01-02', 'Autor de ficção científica.'),
('Stephen King', '1947-09-21', 'Mestre do horror e suspense.'),
('Virginia Woolf', '1882-01-25', 'Importante escritora modernista.');

-- Inserindo dados em categoria (10 registros)
INSERT INTO categoria (nome) VALUES
('Ficção'),
('Não-ficção'),
('Romance'),
('Mistério'),
('Ficção Científica'),
('Biografia'),
('Técnico'),
('História'),
('Fantasia'),
('Drama');

-- Inserindo dados em livro (10 registros)
INSERT INTO livro (titulo, isbn, descricao) VALUES
('Ensaio sobre a Cegueira', '978-85-01-00000-1', 'Romance sobre uma epidemia de cegueira.'),
('1984', '978-85-01-00000-2', 'Distopia sobre um regime totalitário.'),
('Dom Casmurro', '978-85-01-00000-3', 'Romance de Bentinho e Capitu.'),
('Harry Potter e a Pedra Filosofal', '978-85-01-00000-4', 'Aventura mágica do jovem bruxo.'),
('O Caso dos Dez Negrinhos', '978-85-01-00000-5', 'Mistério com assassinatos em série.'),
('Perto do Coração Selvagem', '978-85-01-00000-6', 'Romance introspectivo de estreia de Clarice.'),
('Python', '123-45-67-00000-2', 'Linguagem de programação Python'),
('O Alquimista', '978-85-01-00000-7', 'Fábula espiritual de Paulo Coelho.'),
('Fundação', '978-85-01-00000-8', 'Clássico de ficção científica de Isaac Asimov.'),
('It - A Coisa', '978-85-01-00000-9', 'Romance de horror de Stephen King.');

-- Relacionando livros com autores
INSERT INTO livro_autor (livro_id, autor_id) VALUES
(1, 1),
(2, 3),
(3, 4),
(4, 6),
(5, 5),
(6, 2),
(7, 7),
(8, 7),
(9, 8),
(10, 9);

-- Relacionando livros com categorias
INSERT INTO livro_categoria (livro_id, categoria_id) VALUES
(1, 1), (1, 3),
(2, 1), (2, 5),
(3, 1), (3, 3),
(4, 1), (4, 5),
(5, 1), (5, 4),
(6, 1), (6, 3),
(7, 7),
(8, 9),
(9, 5),
(10, 1);

-- Inserindo dados em emprestimo
INSERT INTO emprestimo (usuario_id, livro_id, data_emprestimo, data_limite, 
data_devolucao) VALUES
(1, 1, '2025-03-01', '2025-03-15', NULL),
(2, 2, '2025-02-20', '2025-03-05', '2025-03-02'),
(3, 3, '2025-02-25', '2025-03-10', NULL),
(4, 4, '2025-03-05', '2025-03-20', NULL),
(5, 5, '2025-03-10', '2025-03-25', NULL),
(6, 6, '2025-03-12', '2025-03-27', NULL);

-- listar todos os livros
SELECT * FROM Livro;

-- adicionar publicado 
ALTER TABLE livro
ADD COLUMN publicado DATE;

-- cadsatrar livro 
INSERT INTO livro (titulo, isbn, descricao, publicado) 
VALUES
	('Python', '123-45-67-00000-9', 'Linguagem de programação Python', '2000-10-10');

INSERT INTO autor (nome, data_nascimento, biografia)
VALUES
	('Eric Matthers', '1990-10-16', 'Autor porto riquenho sobre linguagens de programação em python.' );

INSERT INTO categoria (nome)
VALUES
	('técnico');

-- UPDATE 
UPDATE
	usuario
SET email = 'teste2email.com' WHERE id = 1;

-- corrigindo o titulo
UPDATE
	livro
SET titulo = 'Curso intensivo de Python: uma introdução prática e baseada em projetos de programação.' WHERE id = 7;

-- marcar os livros de 2000
ALTER TABLE livro
ADD COLUMN status varchar(30);

UPDATE 
	livro
SET status = 'inativo' WHERE publicado < '2000-01-01';

UPDATE livro
SET publicado = '1980-10-10' WHERE id = 1;

UPDATE livro
SET publicado = '1990-10-10' WHERE id = 2;

UPDATE livro
SET publicado = '1960-10-10' WHERE id = 3;

UPDATE livro
SET publicado = '2010-10-10' WHERE id = 4;

UPDATE livro
SET publicado = '2020-10-10' WHERE id = 5;

UPDATE livro
SET publicado = '2012-10-10' WHERE id = 6;

-- listar os livros ocm status inativo
SELECT * FROM livro
WHERE status = 'inativo';

-- delete
DELETE FROM emprestimo WHERE livro_id =2;
DELETE FROM livro_categoria WHERE livro_id = 2;
DELETE FROM livro_autor WHERE livro_id = 2;
DELETE FROM livro WHERE id =2;

-- cadastrar usuario e deletar
INSERT INTO usuario (nome, identificacao, email, data_cadastro, nivel_id) 
VALUES
	('Teste testador', 'USR0011', 'teste@email.com', '2025-04-11', 6);

DELETE FROM usuario WHERE id = 8;
SELECT * FROM usuario;

-- deletar com status danificado
UPDATE livro
SET status = 'danificado' WHERE id IN (1,4);

-- Excluir os empréstimos relacionados aos livros danificados
DELETE FROM emprestimo
WHERE livro_id IN (SELECT id FROM livro WHERE status = 'danificado');

-- Excluir os vínculos com autores
DELETE FROM livro_autor
WHERE livro_id IN (SELECT id FROM livro WHERE status = 'danificado');

-- Excluir os vínculos com categorias (se houver)
DELETE FROM livro_categoria
WHERE livro_id IN (SELECT id FROM livro WHERE status = 'danificado');

-- Agora sim, excluir os livros danificados
DELETE FROM livro
WHERE status = 'danificado';

