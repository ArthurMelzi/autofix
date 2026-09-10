CREATE TABLE clientes (
	id SERIAL PRIMARY KEY,

	nome TEXT NOT NULL,

	email TEXT UNIQUE NOT NULL,

	telefone TEXT NOT NULL,
	
	cpf VARCHAR(11) UNIQUE NOT NULL,

	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE mecanicos (
	id SERIAL PRIMARY KEY,

	nome TEXT NOT NULL,

	especialidade TEXT NOT NULL

	valor_hora NUMERIC CHECK (valor_hora > 0)
);

CREATE TABLE veiculos (
	id SERIAL PRIMARY KEY,

	cliente_id INT REFERENCES clientes(id),

	placa VARCHAR(7) UNIQUE NOT NULL,

	modelo TEXT NOT NULL,

	marca TEXT NOT NULL,

	ano INT NOT NULL
);

CREATE TABLE ordens_servico (
	id SERIAL PRIMARY KEY,

	veiculo_id INT REFERENCES veiculos(id),

	mecanico_id INT REFERENCES mecanicos(id),

	data_abertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	valor_mao_obra NUMERIC NOT NULL CHECK (valor_mao_obra >= 0),

	status TEXT DEFAULT 'Em Aberto' CHECK (status = 'Em Aberto' or status = 'Em Andamento' or status = 'Concluida' or status = 'Cancelada')
);

CREATE TABLE pecas_os (
	id SERIAL PRIMARY KEY,

	os_id INT REFERENCES ordens_servico(id),

	nome_peca TEXT NOT NULL,

	quantidade INT NOT NULL CHECK (quantidade > 0),

	valor_unitario NUMERIC NOT NULL CHECK (valor_unitario > 0)
);

INSERT INTO clientes (nome, email, telefone, cpf) VALUES
('Fernanda Lima', 'fernandalima@gmail.com','(48) 99603-0732' ,'23254898311')
('Adrian Christian Hernandez', 'adrian_c_hernandez@gmail.com','(48) 92738-4002' ,'13239804991')
('Eduardo Feijó', 'feijo@gmail.com','(48) 92378-1231' ,'32498765432')

INSERT INTO mecanicos (nome, especialidade, valor_hora) VALUES
('Arthur Melzi', 'Motor', '122.23'),
('Artur Hipólito', 'Suspensão', '232.67'),
('Gabriel Limão', 'Injeção Eletrônica', '212.41')

INSERT INTO veiculos(cliente_id, placa, modelo, marca, ano) VALUES
('1', '67SON41', 'Chevrolet Onix', 'Chevrolet', '2019'),
('2', '500C1G4', 'Fiat Strada', 'Fiat', '1999'),
('3', '6767676', 'Volkswagen Polo', 'Volkswagen', '1975')

INSERT INTO ordens_servico (veiculo_id, mecanico_id, valor_mao_obra, status) VALUES
(1, 1, '545.28', DEFAULT),
(2, 3, 234.23, 'Cancelada'),
(2, 2, 543.67, DEFAULT),
(3, 2, 342.99, 'Em Andamento')
