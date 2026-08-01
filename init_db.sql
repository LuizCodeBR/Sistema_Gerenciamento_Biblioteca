-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS BIBLIOTECA;
USE BIBLIOTECA;

-- Create usuario table
CREATE TABLE IF NOT EXISTS usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    login VARCHAR(50) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    tipo_usuario ENUM('administrador', 'funcionario', 'cliente') NOT NULL,
    ra VARCHAR(20) NOT NULL UNIQUE,
    INDEX idx_login (login),
    INDEX idx_ra (ra)
);

-- Create livro table
CREATE TABLE IF NOT EXISTS livro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    TOPICOS VARCHAR(200),
    categoria VARCHAR(50),
    ano_publicacao INT,
    cod_livro VARCHAR(50),
    cod_interno VARCHAR(50),
    quantidade INT DEFAULT 1,
    INDEX idx_titulo (titulo),
    INDEX idx_autor (autor),
    INDEX idx_cod_livro (cod_livro),
    INDEX idx_cod_interno (cod_interno)
);

-- Create emprestimo table
CREATE TABLE IF NOT EXISTS emprestimo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_id INT NOT NULL,
    usuario_id INT NOT NULL,
    data_emprestimo DATE NOT NULL,
    data_validade DATE NOT NULL,
    devolvido BOOLEAN DEFAULT FALSE,
    multa DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (livro_id) REFERENCES livro(id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    INDEX idx_livro_id (livro_id),
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_devolvido (devolvido)
);

-- Create reserva table
CREATE TABLE IF NOT EXISTS reserva (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_id INT NOT NULL,
    usuario_id INT NOT NULL,
    data_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_reserva ENUM('ATIVA', 'AGUARDANDO_RETIRADA', 'ATENDIDA') DEFAULT 'ATIVA',
    data_notificacao_disponibilidade TIMESTAMP NULL,
    data_limite_retirada TIMESTAMP NULL,
    FOREIGN KEY (livro_id) REFERENCES livro(id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    INDEX idx_livro_id (livro_id),
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_status_reserva (status_reserva),
    INDEX idx_data_reserva (data_reserva)
);

-- Insert some sample data for testing
INSERT IGNORE INTO usuario (nome, login, senha, tipo_usuario, ra) VALUES
('Administrador Sistema', 'admin', 'admin123', 'administrador', '0000001'),
('Funcionario Sistema', 'funcionario', 'func123', 'funcionario', '0000002'),
('Cliente Sistema', 'cliente', 'cli123', 'cliente', '0000003');

INSERT IGNORE INTO livro (titulo, autor, TOPICOS, categoria, ano_publicacao, cod_livro, cod_interno, quantidade) VALUES
('Dom Casmurro', 'Machado de Assis', 'Romance, Realismo', 'Literatura', 1899, '978-85-00-00001-1', 'LIV001', 3),
('O Senhor dos Anéis', 'J.R.R. Tolkien', 'Fantasia, Aventura', 'Fantasia', 1954, '978-85-00-00002-2', 'LIV002', 2),
('Clean Code', 'Robert C. Martin', 'Engenharia de Software, Boas Práticas', 'Tecnologia', 2008, '978-85-00-00003-3', 'LIV003', 4),
('A Brief History of Time', 'Stephen Hawking', 'Cosmologia, Física', 'Ciências', 1988, '978-85-00-00004-4', 'LIV004', 2),
('Orgulho e Preconceito', 'Jane Austen', 'Romance, Clássico', 'Literatura', 1813, '978-85-00-00005-5', 'LIV005', 3);