CREATE TABLE fin_categoria (
cat_id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
cat_nome VARCHAR(50) NOT NULL

)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO fin_categoria (cat_nome) VALUES ('LAZER');
INSERT INTO fin_categoria (cat_nome) VALUES ('ALIMENTAÇÃO');
INSERT INTO fin_categoria (cat_nome) VALUES ('SUPERMERCADO');
INSERT INTO fin_categoria (cat_nome) VALUES ('FARMACIA');
INSERT INTO fin_categoria (cat_nome) VALUES ('OUTROS');
INSERT INTO fin_categoria (cat_nome) VALUES ('VESTUARIO');
