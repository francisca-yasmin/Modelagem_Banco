-- ==========================================================================
-- INTEGRANTES DO GRUPO
-- Arthur Maia
-- Arthur Amorim
-- Francisca Yasmin
-- ==========================================================================

-- ========================================
-- PASSO 1 — Criando o banco de dados
-- ========================================
-- (Executar como usuário com permissão de criar DB)
DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE biblioteca;

-- ========================================
-- PASSO 2 — Criação das tabelas
-- ========================================
-- Usamos nomes em inglês conforme especificado: author, category, book, student, loan

-- Tabela authors
CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL
);

-- Tabela categories
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE  -- restrição de unicidade em name
);

-- Tabela books
CREATE TABLE book (
    id SERIAL PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    year_publication INTEGER,
    author_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    CONSTRAINT fk_book_author FOREIGN KEY (author_id)
        REFERENCES author(id) ON DELETE CASCADE,
    CONSTRAINT fk_book_category FOREIGN KEY (category_id)
        REFERENCES category(id) ON DELETE CASCADE
);

-- Tabela students
CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE  -- restrição de unicidade em email
);

-- Tabela loans (empréstimos)
CREATE TABLE loan (
    id SERIAL PRIMARY KEY,
    book_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    date_withdrawal DATE NOT NULL,       -- data de retirada
    date_expected DATE NOT NULL,         -- data de devolução prevista
    date_return DATE,                    -- data de devolução real (pode ser NULL)
    CONSTRAINT fk_loan_book FOREIGN KEY (book_id)
        REFERENCES book(id) ON DELETE CASCADE,
    CONSTRAINT fk_loan_student FOREIGN KEY (student_id)
        REFERENCES student(id) ON DELETE CASCADE
);

-- ========================================
-- Reflexão curta sobre ON DELETE CASCADE
-- ========================================
/*
ON DELETE CASCADE é útil para manter integridade referencial automaticamente,
porém pode ser perigoso porque:
- Uma exclusão "acidental" de um registro pai (ex: autor) pode remover muitos registros filhos (livros) e esses, por sua vez, cascatar para empréstimos etc.
- Em sistemas reais é comum preferir marcar como inativo ou derrubar a restrição, ou exigir exclusão em várias etapas para evitar perda de dados.
*/

-- ========================================
-- PASSO 3 — Inserindo dados
-- ========================================
-- Inserir 10 autores
INSERT INTO author (id, name) VALUES
(1, 'Machado de Assis'),
(2, 'J. K. Rowling'),
(3, 'George Orwell'),
(4, 'Clarice Lispector'),
(5, 'Isaac Asimov'),
(6, 'J.R.R. Tolkien'),
(7, 'Jane Austen'),
(8, 'Gabriel García Márquez'),
(9, 'Toni Morrison'),
(10, 'Yuval Noah Harari');

-- Inserir 5 categorias
INSERT INTO category (id, name) VALUES
(1, 'Romance'),
(2, 'Fantasia'),
(3, 'Distopia'),
(4, 'Ciências'),
(5, 'Clássico');

-- Inserir 30 livros (cada um com author_id e category_id)
-- Observação: os IDs de author/category correspondem aos inseridos acima.
INSERT INTO book (id, title, year_publication, author_id, category_id) VALUES
(1, 'Dom Casmurro', 1899, 1, 5),
(2, 'Memórias Póstumas de Brás Cubas', 1881, 1, 5),
(3, 'Harry Potter and the Philosopher''s Stone', 1997, 2, 2),
(4, 'Harry Potter and the Chamber of Secrets', 1998, 2, 2),
(5, '1984', 1949, 3, 3),
(6, 'Animal Farm', 1945, 3, 3),
(7, 'The Hour of the Star', 1977, 4, 1),
(8, 'A Paixão Segundo G.H.', 1964, 4, 5),
(9, 'Foundation', 1951, 5, 4),
(10, 'I, Robot', 1950, 5, 4),
(11, 'The Hobbit', 1937, 6, 2),
(12, 'The Lord of the Rings', 1954, 6, 2),
(13, 'Pride and Prejudice', 1813, 7, 5),
(14, 'Emma', 1815, 7, 5),
(15, 'One Hundred Years of Solitude', 1967, 8, 1),
(16, 'Love in the Time of Cholera', 1985, 8, 1),
(17, 'Beloved', 1987, 9, 1),
(18, 'Sula', 1973, 9, 1),
(19, 'Sapiens: A Brief History of Humankind', 2011, 10, 4),
(20, 'Homo Deus: A Brief History of Tomorrow', 2015, 10, 4),
(21, 'Minor Works - Short Stories', 1900, 1, 5),
(22, 'Fantastic Beasts and Where to Find Them', 2001, 2, 2),
(23, 'Down and Out in Paris and London', 1933, 3, 5),
(24, 'Selected Stories', 1971, 4, 5),
(25, 'Robots and Empire', 1985, 5, 4),
(26, 'The Silmarillion', 1977, 6, 2),
(27, 'Mansfield Park', 1814, 7, 5),
(28, 'The General in His Labyrinth', 1989, 8, 5),
(29, 'Home', 2012, 9, 1),
(30, '21 Lessons for the 21st Century', 2018, 10, 4);

-- Inserir 30 alunos (students) com emails únicos
INSERT INTO student (id, name, email) VALUES
(1, 'Alice Silva', 'alice.silva@example.com'),
(2, 'Bruno Souza', 'bruno.souza@example.com'),
(3, 'Carla Pereira', 'carla.pereira@example.com'),
(4, 'Diego Almeida', 'diego.almeida@example.com'),
(5, 'Eduarda Rocha', 'eduarda.rocha@example.com'),
(6, 'Felipe Costa', 'felipe.costa@example.com'),
(7, 'Gabriela Martins', 'gabriela.martins@example.com'),
(8, 'Helena Ferreira', 'helena.ferreira@example.com'),
(9, 'Igor Nascimento', 'igor.nascimento@example.com'),
(10, 'Joana Lopes', 'joana.lopes@example.com'),
(11, 'Kleber Dias', 'kleber.dias@example.com'),
(12, 'Laura Gomes', 'laura.gomes@example.com'),
(13, 'Marcos Pinto', 'marcos.pinto@example.com'),
(14, 'Natália Barros', 'natalia.barros@example.com'),
(15, 'Otávio Moura', 'otavio.moura@example.com'),
(16, 'Patrícia Melo', 'patricia.melo@example.com'),
(17, 'Quésia Andrade', 'quesia.andrade@example.com'),
(18, 'Rafael Rocha', 'rafael.rocha@example.com'),
(19, 'Sara Teixeira', 'sara.teixeira@example.com'),
(20, 'Tiago Cardoso', 'tiago.cardoso@example.com'),
(21, 'Úrsula Brito', 'ursula.brito@example.com'),
(22, 'Vivian Castro', 'vivian.castro@example.com'),
(23, 'Wagner Neves', 'wagner.neves@example.com'),
(24, 'Xênia Carvalho', 'xenia.carvalho@example.com'),
(25, 'Yuri Falcão', 'yuri.falcao@example.com'),
(26, 'Zoe Pereira', 'zoe.pereira@example.com'),
(27, 'André Lima', 'andre.lima@example.com'),
(28, 'Bianca Rocha', 'bianca.rocha@example.com'),
(29, 'Cauã Mendes', 'caua.mendes@example.com'),
(30, 'Diana Santos', 'diana.santos@example.com');

-- Inserir 20 empréstimos (loan)
-- Para gerar cenários "atrasados" e "em dia", alguns têm date_return maior que date_expected ou NULL.
-- Usa formato 'YYYY-MM-DD'
INSERT INTO loan (id, book_id, student_id, date_withdrawal, date_expected, date_return) VALUES
(1, 1, 1, '2025-09-01', '2025-09-15', '2025-09-14'), -- devolvido em dia
(2, 3, 2, '2025-09-05', '2025-09-20', NULL),          -- ainda com o aluno (em dia se hoje <= 2025-09-20)
(3, 5, 3, '2025-08-01', '2025-08-15', '2025-08-20'),  -- devolvido atrasado
(4, 6, 4, '2025-05-10', '2025-05-24', '2025-05-23'),
(5, 9, 5, '2025-10-01', '2025-10-15', NULL),         -- em empréstimo (pode estar em dia)
(6, 11, 6, '2025-07-20', '2025-08-03', '2025-08-02'),
(7, 12, 7, '2025-06-01', '2025-06-15', '2025-06-16'), -- devolvido 1 dia atrasado
(8, 13, 8, '2025-09-10', '2025-09-24', '2025-09-20'),
(9, 15, 9, '2025-09-12', '2025-09-26', NULL),
(10, 16, 10, '2025-08-20', '2025-09-03', '2025-09-02'),
(11, 17, 11, '2025-07-01', '2025-07-15', '2025-07-14'),
(12, 18, 12, '2025-09-01', '2025-09-15', '2025-09-30'), -- devolvido muito atrasado
(13, 19, 13, '2025-10-01', '2025-10-10', NULL),
(14, 20, 14, '2025-09-15', '2025-09-29', '2025-09-28'),
(15, 21, 15, '2025-08-05', '2025-08-19', '2025-08-25'), -- devolvido atrasado
(16, 22, 16, '2025-09-20', '2025-10-04', NULL),
(17, 24, 17, '2025-06-20', '2025-07-04', '2025-07-03'),
(18, 25, 18, '2025-07-10', '2025-07-24', '2025-07-24'),
(19, 27, 19, '2025-08-01', '2025-08-15', '2025-08-16'), -- 1 dia atrasado
(20, 30, 20, '2025-10-01', '2025-10-08', NULL);

-- ========================================
-- PASSO 4 — Consultas (SELECTs) solicitadas
-- ========================================

-- 4.1 Liste todos os livros com seus autores e categorias.
-- Usa JOIN entre book, author e category
SELECT
    b.id AS book_id,
    b.title AS book_title,
    b.year_publication,
    a.id AS author_id,
    a.name AS author_name,
    c.id AS category_id,
    c.name AS category_name
FROM book b
JOIN author a ON b.author_id = a.id
JOIN category c ON b.category_id = c.id
ORDER BY b.id;

-- 4.2 Liste os empréstimos mostrando: aluno, título do livro e datas.
SELECT
    l.id AS loan_id,
    s.id AS student_id,
    s.name AS student_name,
    b.id AS book_id,
    b.title AS book_title,
    l.date_withdrawal,
    l.date_expected,
    l.date_return
FROM loan l
JOIN student s ON l.student_id = s.id
JOIN book b ON l.book_id = b.id
ORDER BY l.date_withdrawal DESC;

-- 4.3 Liste apenas os empréstimos atrasados (onde date_return > date_expected OR 
--      quando ainda não devolvido e hoje > date_expected).
-- Usamos CURRENT_DATE para avaliar empréstimos em aberto.
SELECT
    l.id AS loan_id,
    s.name AS student_name,
    b.title AS book_title,
    l.date_withdrawal,
    l.date_expected,
    l.date_return,
    CASE
        WHEN l.date_return IS NULL AND CURRENT_DATE > l.date_expected THEN 'Atrasado (não devolvido)'
        WHEN l.date_return IS NOT NULL AND l.date_return > l.date_expected THEN 'Atrasado (devolvido)'
        ELSE 'Em dia'
    END AS status
FROM loan l
JOIN student s ON l.student_id = s.id
JOIN book b ON l.book_id = b.id
WHERE
    (l.date_return IS NOT NULL AND l.date_return > l.date_expected)
    OR
    (l.date_return IS NULL AND CURRENT_DATE > l.date_expected)
ORDER BY l.date_expected;

-- 4.4 Mostre os autores que têm mais de um livro na biblioteca.
SELECT
    a.id AS author_id,
    a.name AS author_name,
    COUNT(b.id) AS books_count
FROM author a
JOIN book b ON b.author_id = a.id
GROUP BY a.id, a.name
HAVING COUNT(b.id) > 1
ORDER BY books_count DESC;

-- ========================================
-- Reflexão curta sobre JOINs
-- ========================================
/*
Por que precisamos de JOINs?
- Informação relevante está normalizada em tabelas diferentes (ex: livros, autores, categorias).
- JOIN permite combinar essas tabelas para obter respostas completas (ex: "título + autor + categoria").
- Sem JOINs teríamos dados duplicados ou dificuldade em manter integridade/consistência.
*/

-- ========================================
-- PASSO 5 — Atualizações e exclusões
-- ========================================

-- 5.1 Atualize a categoria de um livro (ex: mudar livro id=1 de 'Romance' para 'Clássico').
-- Primeiro, certifique-se de que exista a categoria 'Clássico' (já inserimos id=5 'Clássico' acima).
-- Vamos mudar book id=1 (Dom Casmurro) para category_id = 5 (Clássico)
UPDATE book
SET category_id = 5
WHERE id = 1;

-- Verificar alteração:
SELECT b.id, b.title, c.name AS category_name
FROM book b JOIN category c ON b.category_id = c.id
WHERE b.id = 1;

-- 5.2 Altere o e-mail de um aluno (ex: student id=2)
UPDATE student
SET email = 'bruno.souza2025@example.com'
WHERE id = 2;

-- Verificar alteração:
SELECT id, name, email FROM student WHERE id = 2;

-- 5.3 Exclua um autor e observe o efeito com ON DELETE CASCADE.
-- Ex: excluir author id=10 (Yuval Noah Harari) — isso deve remover os livros desse autor,
-- e por consequência quaisquer empréstimos relacionados a esses livros (devido ao ON DELETE CASCADE nas FK).
-- Antes de excluir, veja quais livros pertencem a esse autor:
SELECT id, title FROM book WHERE author_id = 10;

-- Excluir o autor:
DELETE FROM author WHERE id = 10;

-- Verificar que os livros desse autor foram removidos:
SELECT * FROM book WHERE author_id = 10;

-- Verificar empréstimos que referiam books previamente ligados a esse author (se existiram) — devem ter sido removidos:
SELECT * FROM loan WHERE book_id NOT IN (SELECT id FROM book);

-- ========================================
-- PASSO 6 — Desafio extra: VIEW e consultas agregadas
-- ========================================

-- 6.1 O que é uma VIEW em SQL?
/*
Uma VIEW é uma "tabela virtual" definida por uma consulta. Ela encapsula uma query complexa e pode ser consultada como se fosse uma tabela.
Vantagens: simplificar consultas frequentes, reutilização, abstração da complexidade.
*/

-- 6.2 Crie a VIEW vw_loans que mostre: título do livro, aluno, data prevista e status (Em dia ou Atrasado).
DROP VIEW IF EXISTS vw_loans;
CREATE VIEW vw_loans AS
SELECT
    l.id AS loan_id,
    b.title AS book_title,
    s.name AS student_name,
    l.date_expected,
    CASE
        WHEN l.date_return IS NULL AND CURRENT_DATE > l.date_expected THEN 'Atrasado'
        WHEN l.date_return IS NOT NULL AND l.date_return > l.date_expected THEN 'Atrasado'
        ELSE 'Em dia'
    END AS status
FROM loan l
JOIN book b ON l.book_id = b.id
JOIN student s ON l.student_id = s.id;

-- Exemplo de uso da VIEW:
SELECT * FROM vw_loans ORDER BY date_expected;

-- 6.3 Consulta que mostre a quantidade de livros emprestados por categoria.
-- Interpretação: contar número de empréstimos (loan) por categoria do livro emprestado.
SELECT
    c.id AS category_id,
    c.name AS category_name,
    COUNT(l.id) AS total_loans
FROM loan l
JOIN book b ON l.book_id = b.id
JOIN category c ON b.category_id = c.id
GROUP BY c.id, c.name
ORDER BY total_loans DESC;

-- Alternativa: contar quantos títulos (distinct books) de cada categoria já foram emprestados
SELECT
    c.id AS category_id,
    c.name AS category_name,
    COUNT(DISTINCT b.id) AS distinct_books_loaned
FROM loan l
JOIN book b ON l.book_id = b.id
JOIN category c ON b.category_id = c.id
GROUP BY c.id, c.name
ORDER BY distinct_books_loaned DESC;

-- ========================================
-- TESTES E VALIDAÇÕES ADICIONAIS (opcional)
-- ========================================

-- Verificar integridade: listar todas as FK orfãs (não deve retornar linhas)
-- (Se houver, indica problema)
SELECT l.*
FROM loan l
LEFT JOIN book b ON l.book_id = b.id
WHERE b.id IS NULL;

-- FIM DO SCRIPT




