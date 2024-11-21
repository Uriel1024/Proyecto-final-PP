--drop database pp
--create database pp
/*De la base de datos que me implemente con el profesor Blanco, 
tienda de videjuegos
21 de noviembre de 2024

Los queries están divididos en:
A)crear tipos de datos,
B)crear tablas con los foreing Keys,
C)ingresar los datos a las tablas.

-- A) Crear variables
--rol: cliente, administrador
--Estado: pendiente, enviado, entregado
--estado_dev: pendiente, aceptada, rechazada*/

CREATE TYPE rol
AS ENUM ('cliente', 'administrador');

CREATE TYPE Estado
AS ENUM ('pendiente', 'enviado', 'entregado');

CREATE TYPE tipo_pago
AS ENUM ('tarjeta', 'paypal', 'otros');

CREATE TYPE estado_dev
AS ENUM ('pendiente', 'aceptada', 'rechazada');


--- B) Crear tablas con pk,fk
--- B1) usuarios
create table usuarios
(
id_usuario serial primary key, 
nombre varchar(50) not null, 
primer_apellido varchar(50) not null, 
segundo_apellido varchar(50), 
email varchar(100) unique,
contrasena varchar(20), 
direccion varchar(255), 
telefono varchar(15), 
rol rol default 'cliente', 
id_carrito_compras integer -- fk
);

--B2)
create table Videojuegos(
id_videojuego serial primary key,
titulo varchar(75), 
plataforma varchar(50), 
precio numeric(10,2),
stock integer, 
desarrollador varchar(100),
fecha_lanzamiento date
);

--B3) 
create table generos(
id_genero serial primary key,
nombre_genero varchar(50) unique not null
);

--B4)
create table videojuego_genero(
id_videojuego integer not null, 
id_genero integer not null, 
primary key (id_videojuego, id_genero),
foreign key (id_videojuego) references Videojuegos(id_videojuego),
foreign key (id_genero) references Generos(id_genero)
);

--B5)
create table CarritoCompras(
id_carrito serial primary key,
id_usuario integer, 
fecha_creacion date,
foreign key (id_usuario) references Usuarios(id_usuario)
);

---B6)
create table DetallesCarrito(
id_detalle_carrito serial primary key,
id_carrito integer, 
id_videojuego integer, 
cantidad integer, 
precio_total numeric(10,2),
foreign key (id_carrito) references CarritoCompras(id_carrito),
foreign key (id_videojuego) references Videojuegos(id_videojuego)
);

--B7)
create table Pedidos(
id_pedido serial primary key, 
id_usuario integer, 
fecha_pedido date, 
estado Estado default 'pendiente',
foreign key (id_usuario) references Usuarios(id_usuario)
);

--B8)
create table DetallesPedido(
id_detalle_pedido serial primary key,
id_pedido integer,
id_videojuego integer,
cantidad integer,
precio_total numeric(10,2),
foreign key (id_pedido) references Pedidos(id_pedido),
foreign key (id_videojuego) references Videojuegos(id_videojuego)
);

--B9) 
create table MetodosPago(
id_pago serial primary key,
id_pedido integer,
tipo_pago tipo_pago,
total numeric(10,2),--fk
foreign key (id_pedido) references Pedidos(id_pedido)
);

--B10)
create table Devoluciones(
id_devolucion serial primary key,
id_pedido integer,
fecha_devolucion date,
motivo varchar(255), 
estado estado_dev default 'pendiente', 
monto_reembolso numeric(10,2),
foreign key (id_pedido) references Pedidos(id_pedido)	
);

--B11)
create table ExtensionesVideojuegos(
id_extension serial primary key,
id_videojuego integer,
nombre_extension varchar(100),
precio numeric(10,2), 
descripcion text,
fecha_lanzamiento date,
foreign key (id_videojuego) references Videojuegos(id_videojuego)
);

--B12)
create table DetallesCompraExtensiones(
id_detalle_extension serial primary key,
id_usuario integer,
id_extension integer,
fecha_compra date,
cantidad integer,
precio_total numeric(10,2),
foreign key (id_usuario) references Usuarios(id_usuario),
foreign key (id_extension) references ExtensionesVideojuegos(id_extension)
);


-- C)Inserciones a las tablas
/*Insercion de datos en la tabla de usuarios (46)*/
INSERT INTO Usuarios (nombre, primer_apellido, segundo_apellido, email, contrasena, direccion, telefono, rol)
VALUES 
('Luis', 'Gomez', 'Perez', 'luis.gomez1@example.com', 'Contra12345!', '123 Main St, New York, NY', '1234567890', 'cliente'),
('Ana', 'Lopez', 'Garcia', 'ana.lopez2@example.com', 'SecureP@ssw0rd', '456 Elm St, Los Angeles, CA', '1234567891', 'cliente'),
('Pedro', 'Martinez', 'Sanchez', 'pedro.martinez3@example.com', 'Passw0rd!98', '789 Maple Ave, Chicago, IL', '1234567892', 'administrador'),
('Marta', 'Diaz', 'Gomez', 'marta.diaz4@example.com', 'P@ssword#2021', '321 Oak Dr, Houston, TX', '1234567893', 'cliente'),
('Jorge', 'Fernandez', 'Lopez', 'jorge.fernandez5@example.com', 'Admin123$', '654 Pine Rd, Philadelphia, PA', '1234567894', 'cliente'),
('Laura', 'Garcia', 'Martinez', 'laura.garcia6@example.com', 'Pa$$w0rd2022', '987 Birch Ln, Phoenix, AZ', '1234567895', 'administrador'),
('Carlos', 'Santos', 'Ramirez', 'carlos.santos7@example.com', 'MyP@ss123!', '432 Cedar St, San Antonio, TX', '1234567896', 'cliente'),
('Patricia', 'Morales', 'Hernandez', 'patricia.morales8@example.com', 'SuperP@ss!', '876 Redwood Blvd, San Diego, CA', '1234567897', 'administrador'),
('Raul', 'Torres', 'Jimenez', 'raul.torres9@example.com', 'Welcome2023!', '543 Aspen Ave, Dallas, TX', '1234567898', 'cliente'),
('Carmen', 'Nunez', 'Perez', 'carmen.nunez10@example.com', 'S@fePass2023', '210 Spruce Way, San Jose, CA', '1234567899', 'cliente'),
('Antonio', 'Vargas', 'Castro', 'antonio.vargas11@example.com', 'Pa$$word2024!', '190 Sequoia St, Austin, TX', '1234567800', 'administrador'),
('Isabel', 'Reyes', 'Sanchez', 'isabel.reyes12@example.com', 'AdminPass!456', '280 Chestnut Rd, Jacksonville, FL', '1234567801', 'cliente'),
('Manuel', 'Hernandez', 'Gomez', 'manuel.hernandez13@example.com', 'P@$$w0rd!', '370 Willow St, Columbus, OH', '1234567802', 'cliente'),
('Gloria', 'Ruiz', 'Lopez', 'gloria.ruiz14@example.com', 'Secur3P@ss', '460 Cypress Ave, Indianapolis, IN', '1234567803', 'administrador'),
('Jose', 'Mendoza', 'Diaz', 'jose.mendoza15@example.com', 'Mypass123#', '120 Fir St, San Francisco, CA', '1234567804', 'cliente'),
('Sara', 'Medina', 'Fernandez', 'sara.medina16@example.com', 'SaFe$Pa$$', '260 Poplar Rd, Fort Worth, TX', '1234567805', 'cliente'),
('David', 'Romero', 'Garcia', 'david.romero17@example.com', 'Password123$', '310 Olive Dr, Charlotte, NC', '1234567806', 'cliente'),
('Sonia', 'Rojas', 'Santos', 'sonia.rojas18@example.com', 'Secure#4567', '230 Magnolia Ln, Detroit, MI', '1234567807', 'cliente'),
('Alejandro', 'Paredes', 'Morales', 'alejandro.paredes19@example.com', 'Passw0rd@2022', '140 Dogwood Ct, El Paso, TX', '1234567808', 'cliente'),
('Maria', 'Leon', 'Vargas', 'maria.leon20@example.com', 'MyS@fe123', '320 Hickory St, Memphis, TN', '1234567809', 'cliente'),
('Ricardo', 'Ortega', 'Nunez', 'ricardo.ortega21@example.com', 'P@ssw0rd!2023', '220 Redwood Blvd, Denver, CO', '1234567810', 'cliente'),
('Veronica', 'Gil', 'Reyes', 'veronica.gil22@example.com', 'MysafeP@$$', '410 Dogwood Way, Boston, MA', '1234567811', 'cliente'),
('Luis', 'Cruz', 'Perez', 'luis.cruz23@example.com', 'P@ssword!2024', '520 Hemlock St, Nashville, TN', '1234567812', 'cliente'),
('Elena', 'Castillo', 'Vargas', 'elena.castillo24@example.com', 'SafePass@2024', '650 Maple Ave, Portland, OR', '1234567813', 'cliente'),
('Fernando', 'Flores', 'Garcia', 'fernando.flores25@example.com', 'MySafeP@ss!', '710 Oak Dr, Oklahoma City, OK', '1234567814', 'cliente'),
('Claudia', 'Martin', 'Diaz', 'claudia.martin26@example.com', 'P@ssword@2025', '890 Pine Rd, Las Vegas, NV', '1234567815', 'cliente'),
('Javier', 'Moreno', 'Santos', 'javier.moreno27@example.com', 'MyPa$$w0rd!', '110 Cedar St, Albuquerque, NM', '1234567816', 'cliente'),
('Monica', 'Vega', 'Hernandez', 'monica.vega28@example.com', 'Secure@2025!', '470 Spruce Way, Tucson, AZ', '1234567817', 'cliente'),
('Andres', 'Campos', 'Gomez', 'andres.campos29@example.com', 'P@ssword#789', '240 Aspen Ave, Fresno, CA', '1234567818', 'cliente'),
('Cristina', 'Iglesias', 'Ramirez', 'cristina.iglesias30@example.com', 'MyP@$$w0rd!', '680 Birch Ln, Sacramento, CA', '1234567819', 'cliente'),
('Miguel', 'Serrano', 'Martinez', 'miguel.serrano31@example.com', 'Safe#Password', '870 Maple Ct, Kansas City, MO', '1234567820', 'cliente'),
('Beatriz', 'Alvarez', 'Morales', 'beatriz.alvarez32@example.com', 'P@$$Secure789', '980 Oak Dr, Mesa, AZ', '1234567821', 'cliente'),
('Oscar', 'Guerrero', 'Santos', 'oscar.guerrero33@example.com', 'SecureP@ssw0rd', '120 Elm St, Atlanta, GA', '1234567822', 'cliente'),
('Natalia', 'Herrera', 'Perez', 'natalia.herrera34@example.com', 'S@fePass2023', '560 Dogwood Blvd, Omaha, NE', '1234567823', 'cliente'),
('Adrian', 'Ramos', 'Diaz', 'adrian.ramos35@example.com', 'MyP@ss123', '310 Cypress Ln, Raleigh, NC', '1234567824', 'cliente'),
('Alicia', 'Molina', 'Fernandez', 'alicia.molina36@example.com', 'P@ssword#456', '620 Fir St, Miami, FL', '1234567825', 'cliente'),
('Daniel', 'Blanco', 'Garcia', 'daniel.blanco37@example.com', 'Mypass@Secure', '430 Magnolia Rd, Tampa, FL', '1234567826', 'cliente'),
('Rosa', 'Benitez', 'Vargas', 'rosa.benitez38@example.com', 'P@ssw0rd789', '740 Redwood Ave, Aurora, CO', '1234567827', 'cliente'),
('Felipe', 'Espinosa', 'Lopez', 'felipe.espinosa39@example.com', 'Secur3P@ss!', '850 Poplar Dr, Orlando, FL', '1234567828', 'cliente'),
('Lucia', 'Prieto', 'Perez', 'lucia.prieto40@example.com', 'SafePa$$123', '960 Sequoia St, Cleveland, OH', '1234567829', 'cliente'),
('Gonzalo', 'Lara', 'Castro', 'gonzalo.lara41@example.com', 'Pass#2023!', '180 Hickory Rd, Minneapolis, MN', '1234567830', 'cliente'),
('Celia', 'Duran', 'Santos', 'celia.duran42@example.com', 'P@ssword!2023', '570 Dogwood Ln, St. Louis, MO', '1234567831', 'cliente'),
('Ramiro', 'Rivas', 'Gomez', 'ramiro.rivas43@example.com', 'MyS@fe2023!', '680 Elm Blvd, New Orleans, LA', '1234567832', 'administrador'),
('Sofia', 'Cano', 'Sanchez', 'sofia.cano44@example.com', 'Admin#Pass!', '780 Pine Ct, Cincinnati, OH', '1234567833', 'administrador'),
('Pablo', 'Gallardo', 'Martinez', 'pablo.gallardo45@example.com', 'MyS@fePa$$!', '890 Birch St, Pittsburgh, PA', '1234567834', 'cliente'),
('Olga', 'Perez', 'Garcia', 'olga.perez46@example.com', 'P@ss123456!', '190 Maple Ave, Buffalo, NY', '1234567835', 'cliente');

/*Insercion de datos en la tabla de videojuegos (65)*/
INSERT INTO Videojuegos (titulo, plataforma, precio, stock, desarrollador, fecha_lanzamiento)
VALUES 
('The Legend of Zelda: Breath of the Wild', 'Nintendo Switch', 1399.00, 25, 'Nintendo', '2017-03-03'),
('Super Mario Odyssey', 'Nintendo Switch', 1299.00, 30, 'Nintendo', '2017-10-27'),
('Red Dead Redemption 2', 'PlayStation 4', 999.00, 20, 'Rockstar Games', '2018-10-26'),
('Grand Theft Auto V', 'PlayStation 4', 499.00, 40, 'Rockstar Games', '2014-11-18'),
('Fortnite', 'PC', 0.00, 50, 'Epic Games', '2017-07-21'),
('Minecraft', 'PC', 549.00, 35, 'Mojang', '2011-11-18'),
('The Witcher 3: Wild Hunt', 'PC', 699.00, 28, 'CD Projekt Red', '2015-05-19'),
('Cyberpunk 2077', 'PC', 899.00, 15, 'CD Projekt Red', '2020-12-10'),
('Call of Duty: Modern Warfare', 'PlayStation 4', 1399.00, 22, 'Infinity Ward', '2019-10-25'),
('Animal Crossing: New Horizons', 'Nintendo Switch', 1299.00, 45, 'Nintendo', '2020-03-20'),
('God of War', 'PlayStation 4', 699.00, 38, 'Santa Monica Studio', '2018-04-20'),
('Horizon Zero Dawn', 'PlayStation 4', 599.00, 29, 'Guerrilla Games', '2017-02-28'),
('FIFA 21', 'PlayStation 4', 1399.00, 50, 'EA Sports', '2020-10-09'),
('Assassins Creed Valhalla', 'PlayStation 4', 1399.00, 18, 'Ubisoft', '2020-11-10'),
('Doom Eternal', 'PC', 999.00, 12, 'id Software', '2020-03-20'),
('Apex Legends', 'PC', 0.00, 48, 'Respawn Entertainment', '2019-02-04'),
('League of Legends', 'PC', 0.00, 50, 'Riot Games', '2009-10-27'),
('Valorant', 'PC', 0.00, 42, 'Riot Games', '2020-06-02'),
('Overwatch', 'PC', 699.00, 27, 'Blizzard Entertainment', '2016-05-24'),
('The Last of Us Part II', 'PlayStation 4', 1399.00, 10, 'Naughty Dog', '2020-06-19'),
('Ghost of Tsushima', 'PlayStation 4', 1299.00, 32, 'Sucker Punch', '2020-07-17'),
('Spider-Man: Miles Morales', 'PlayStation 5', 1499.00, 25, 'Insomniac Games', '2020-11-12'),
('Among Us', 'PC', 79.00, 40, 'InnerSloth', '2018-11-16'),
('Fall Guys', 'PC', 399.00, 19, 'Mediatonic', '2020-08-04'),
('Resident Evil Village', 'PlayStation 5', 1499.00, 20, 'Capcom', '2021-05-07'),
('Far Cry 6', 'PC', 1399.00, 22, 'Ubisoft', '2021-10-07'),
('Battlefield 2042', 'PlayStation 5', 1499.00, 12, 'DICE', '2021-11-19'),
('Halo Infinite', 'Xbox Series X', 1499.00, 30, '343 Industries', '2021-12-08'),
('Ratchet & Clank: Rift Apart', 'PlayStation 5', 1599.00, 17, 'Insomniac Games', '2021-06-11'),
('Elden Ring', 'PlayStation 4', 1399.00, 10, 'FromSoftware', '2022-02-25'),
('Dying Light 2', 'PC', 1299.00, 28, 'Techland', '2022-02-04'),
('Diablo II: Resurrected', 'PC', 999.00, 15, 'Blizzard Entertainment', '2021-09-23'),
('Forza Horizon 5', 'Xbox Series X', 1499.00, 16, 'Playground Games', '2021-11-09'),
('Mario Kart 8 Deluxe', 'Nintendo Switch', 1399.00, 37, 'Nintendo', '2017-04-28'),
('Super Smash Bros. Ultimate', 'Nintendo Switch', 1399.00, 29, 'Nintendo', '2018-12-07'),
('Metroid Dread', 'Nintendo Switch', 1299.00, 20, 'Nintendo', '2021-10-08'),
('Hades', 'PC', 399.00, 15, 'Supergiant Games', '2020-09-17'),
('Cuphead', 'PC', 299.00, 25, 'Studio MDHR', '2017-09-29'),
('Control', 'PlayStation 4', 899.00, 18, 'Remedy Entertainment', '2019-08-27'),
('Sekiro: Shadows Die Twice', 'PlayStation 4', 1199.00, 14, 'FromSoftware', '2019-03-22'),
('Dark Souls III', 'PC', 599.00, 28, 'FromSoftware', '2016-04-12'),
('NBA 2K22', 'PlayStation 5', 1499.00, 11, 'Visual Concepts', '2021-09-10'),
('Mortal Kombat 11', 'PlayStation 4', 999.00, 32, 'NetherRealm Studios', '2019-04-23'),
('Crash Bandicoot 4: Its About Time', 'PlayStation 4', 999.00, 23, 'Toys for Bob', '2020-10-02'),
('Tales of Arise', 'PlayStation 5', 1499.00, 10, 'Bandai Namco', '2021-09-10'),
('Final Fantasy VII Remake', 'PlayStation 4', 1399.00, 12, 'Square Enix', '2020-04-10'),
('NieR: Automata', 'PC', 799.00, 30, 'PlatinumGames', '2017-03-17'),
('Dragon Quest XI S', 'Nintendo Switch', 999.00, 15, 'Square Enix', '2019-09-27'),
('Monster Hunter Rise', 'Nintendo Switch', 1399.00, 14, 'Capcom', '2021-03-26'),
('Persona 5 Royal', 'PlayStation 4', 999.00, 19, 'Atlus', '2020-03-31'),
('Yakuza: Like a Dragon', 'PlayStation 4', 1299.00, 20, 'Ryu Ga Gotoku Studio', '2020-11-10'),
('Shin Megami Tensei V', 'Nintendo Switch', 1499.00, 10, 'Atlus', '2021-11-12'),
('Gears 5', 'Xbox Series X', 799.00, 20, 'The Coalition', '2019-09-10'),
('Borderlands 3', 'PlayStation 4', 899.00, 25, 'Gearbox Software', '2019-09-13'),
('Death Stranding', 'PlayStation 4', 999.00, 16, 'Kojima Productions', '2019-11-08'),
('Resident Evil 3', 'PlayStation 4', 1299.00, 10, 'Capcom', '2020-04-03'),
('Nioh 2', 'PlayStation 4', 1299.00, 20, 'Team Ninja', '2020-03-13'),
('The Outer Worlds', 'PC', 999.00, 22, 'Obsidian Entertainment', '2019-10-25'),
('Ghostrunner', 'PC', 699.00, 35, 'One More Level', '2020-10-27'),
('Disco Elysium', 'PC', 499.00, 29, 'ZA/UM', '2019-10-15'),
('Ori and the Will of the Wisps', 'PC', 599.00, 18, 'Moon Studios', '2020-03-11'),
('Fire Emblem: Three Houses', 'Nintendo Switch', 1399.00, 27, 'Intelligent Systems', '2019-07-26'),
('Luigis Mansion 3', 'Nintendo Switch', 1399.00, 23, 'Nintendo', '2019-10-31'),
('Splatoon 2', 'Nintendo Switch', 1199.00, 32, 'Nintendo', '2017-07-21'),
('The Sims 4', 'PC', 499.00, 40, 'Maxis', '2014-09-02');

/*Insercion de datos en la tabla de genero (20)*/
INSERT INTO Generos (nombre_genero)
VALUES 
('Accion'),
('Aventura'),
('Rol'),
('Simulacion'),
('Estrategia'),
('Deportes'),
('Carreras'),
('Plataformas'),
('Lucha'),
('Terror'),
('Puzles'),
('Mundo Abierto'),
('Musica'),
('Survival Horror'),
('Metroidvania'),
('Ciencia Ficcion'),
('Fantasia'),
('Shooter'),
('MMORPG'),
('Sandbox');


-- Inserción de todas las asignaciones entre Videojuegos y Géneros (135)
INSERT INTO Videojuego_Genero (id_videojuego, id_genero)
VALUES
(1, 1),  -- The Legend of Zelda: Breath of the Wild - Accion
(1, 2),  -- The Legend of Zelda: Breath of the Wild - Aventura
(2, 2),  -- Super Mario Odyssey - Aventura
(2, 8),  -- Super Mario Odyssey - Plataformas
(3, 1),  -- Red Dead Redemption 2 - Accion
(3, 2),  -- Red Dead Redemption 2 - Aventura
(3, 12), -- Red Dead Redemption 2 - Mundo Abierto
(4, 1),  -- Grand Theft Auto V - Accion
(4, 12), -- Grand Theft Auto V - Mundo Abierto
(4, 17), -- Grand Theft Auto V - Shooter
(5, 18), -- Fortnite - Shooter
(5, 1),  -- Fortnite - Accion
(6, 4),  -- Minecraft - Simulacion
(6, 12), -- Minecraft - Mundo Abierto
(6, 19), -- Minecraft - Sandbox
(7, 3),  -- The Witcher 3: Wild Hunt - Rol
(7, 2),  -- The Witcher 3: Wild Hunt - Aventura
(7, 16), -- The Witcher 3: Wild Hunt - Fantasia
(8, 16), -- Cyberpunk 2077 - Ciencia Ficcion
(8, 12), -- Cyberpunk 2077 - Mundo Abierto
(8, 3),  -- Cyberpunk 2077 - Rol
(9, 17), -- Call of Duty: Modern Warfare - Shooter
(9, 1),  -- Call of Duty: Modern Warfare - Accion
(10, 5), -- Animal Crossing: New Horizons - Simulacion
(10, 13), -- Animal Crossing: New Horizons - Musica
(11, 1), -- God of War - Accion
(11, 2), -- God of War - Aventura
(11, 16), -- God of War - Fantasia
(12, 1), -- Horizon Zero Dawn - Accion
(12, 12), -- Horizon Zero Dawn - Mundo Abierto
(12, 17), -- Horizon Zero Dawn - Shooter
(13, 6), -- FIFA 21 - Deportes
(14, 1), -- Assassins Creed Valhalla - Accion
(14, 2), -- Assassins Creed Valhalla - Aventura
(14, 12), -- Assassins Creed Valhalla - Mundo Abierto
(15, 1), -- Doom Eternal - Accion
(15, 17), -- Doom Eternal - Shooter
(16, 18), -- Apex Legends - Shooter
(16, 1),  -- Apex Legends - Accion
(17, 20), -- League of Legends - MMORPG
(17, 3),  -- League of Legends - Rol
(18, 18), -- Valorant - Shooter
(19, 1),  -- Overwatch - Accion
(19, 18), -- Overwatch - Shooter
(20, 1),  -- The Last of Us Part II - Accion
(20, 2),  -- The Last of Us Part II - Aventura
(20, 10), -- The Last of Us Part II - Terror
(21, 1),  -- Ghost of Tsushima - Accion
(21, 2),  -- Ghost of Tsushima - Aventura
(21, 12), -- Ghost of Tsushima - Mundo Abierto
(22, 1),  -- Spider-Man: Miles Morales - Accion
(22, 2),  -- Spider-Man: Miles Morales - Aventura
(23, 4),  -- Among Us - Simulacion
(23, 10), -- Among Us - Terror
(24, 4),  -- Fall Guys - Simulacion
(24, 13), -- Fall Guys - Musica
(25, 10), -- Resident Evil Village - Terror
(25, 1),  -- Resident Evil Village - Accion
(26, 1),  -- Far Cry 6 - Accion
(26, 12), -- Far Cry 6 - Mundo Abierto
(26, 17), -- Far Cry 6 - Shooter
(27, 17), -- Battlefield 2042 - Shooter
(27, 1),  -- Battlefield 2042 - Accion
(28, 1),  -- Halo Infinite - Accion
(28, 17), -- Halo Infinite - Shooter
(29, 1),  -- Ratchet & Clank: Rift Apart - Accion
(29, 2),  -- Ratchet & Clank: Rift Apart - Aventura
(30, 1),  -- Elden Ring - Accion
(30, 3),  -- Elden Ring - Rol
(31, 1),  -- Dying Light 2 - Accion
(31, 12), -- Dying Light 2 - Mundo Abierto
(31, 10), -- Dying Light 2 - Terror
(32, 1),  -- Diablo II: Resurrected - Accion
(32, 3),  -- Diablo II: Resurrected - Rol
(33, 7),  -- Forza Horizon 5 - Carreras
(34, 1),  -- Mario Kart 8 Deluxe - Accion
(34, 7),  -- Mario Kart 8 Deluxe - Carreras
(35, 1),  -- Super Smash Bros. Ultimate - Accion
(35, 9),  -- Super Smash Bros. Ultimate - Lucha
(36, 1),  -- Metroid Dread - Accion
(36, 8),  -- Metroid Dread - Plataformas
(37, 13), -- Hades - Musica
(37, 3),  -- Hades - Rol
(38, 1),  -- Cuphead - Accion
(38, 8),  -- Cuphead - Plataformas
(39, 1),  -- Control - Accion
(39, 16), -- Control - Ciencia Ficcion
(40, 1),  -- Sekiro: Shadows Die Twice - Accion
(40, 16), -- Sekiro: Shadows Die Twice - Fantasia
(41, 1),  -- Dark Souls III - Accion
(41, 3),  -- Dark Souls III - Rol
(42, 6),  -- NBA 2K22 - Deportes
(43, 9),  -- Mortal Kombat 11 - Lucha
(43, 1),  -- Mortal Kombat 11 - Accion
(44, 1),  -- Crash Bandicoot 4: Its About Time - Accion
(44, 8),  -- Crash Bandicoot 4: Its About Time - Plataformas
(45, 3),  -- Tales of Arise - Rol
(45, 16), -- Tales of Arise - Fantasia
(46, 1),  -- Final Fantasy VII Remake - Accion
(46, 3),  -- Final Fantasy VII Remake - Rol
(47, 3),  -- NieR: Automata - Rol
(47, 16), -- NieR: Automata - Ciencia Ficcion
(48, 3),  -- Dragon Quest XI S - Rol
(49, 1),  -- Monster Hunter Rise - Accion
(49, 12), -- Monster Hunter Rise - Mundo Abierto
(50, 3),  -- Persona 5 Royal - Rol
(51, 1),  -- Yakuza: Like a Dragon - Accion
(51, 3),  -- Yakuza: Like a Dragon - Rol
(52, 3),  -- Shin Megami Tensei V - Rol
(52, 16), -- Shin Megami Tensei V - Ciencia Ficcion
(53, 1),  -- Demon’s Souls - Accion
(53, 3),  -- Demon’s Souls - Rol
(54, 1),  -- Deathloop - Accion
(54, 17), -- Deathloop - Shooter
(55, 1),  -- Returnal - Accion
(55, 16), -- Returnal - Ciencia Ficcion
(56, 3),  -- Bravely Default II - Rol
(56, 16), -- Bravely Default II - Fantasia
(57, 1),  -- Scarlet Nexus - Accion
(57, 16), -- Scarlet Nexus - Ciencia Ficcion
(58, 1),  -- Kena: Bridge of Spirits - Accion
(58, 2),  -- Kena: Bridge of Spirits - Aventura
(59, 1),  -- Biomutant - Accion
(59, 12), -- Biomutant - Mundo Abierto
(60, 1),  -- It Takes Two - Accion
(60, 2),  -- It Takes Two - Aventura
(61, 9),  -- Guilty Gear -Strive- - Lucha
(61, 1),  -- Guilty Gear -Strive- - Accion
(62, 6),  -- F1 2021 - Deportes
(62, 7),  -- F1 2021 - Carreras
(63, 7),  -- Hot Wheels Unleashed - Carreras
(64, 4),  -- Microsoft Flight Simulator - Simulacion
(64, 7),  -- Microsoft Flight Simulator - Carreras
(65, 10), -- The Medium - Terror
(65, 1);  -- The Medium - Accion

-- Inserciones en la tabla CarritoCompras con fechas entre el 01 de abril de 2023 y la fecha actual. (47)
INSERT INTO CarritoCompras (id_usuario, fecha_creacion)
VALUES
(37, '2023-04-01'),
(10, '2023-04-10'),
(26, '2023-04-15'),
(38, '2023-04-20'),
(35, '2023-04-25'),
(04, '2023-05-02'),
(40, '2023-05-10'),
(13, '2023-05-18'),
(05, '2023-05-27'),
(19, '2023-06-01'),
(15, '2023-06-15'),
(32, '2023-06-23'),
(12, '2023-07-03'),
(34, '2023-07-10'),
(17, '2023-07-18'),
(46, '2023-07-25'),
(29, '2023-08-02'),
(36, '2023-08-10'),
(31, '2023-08-15'),
(39, '2023-08-20'),
(22, '2023-08-25'),
(25, '2023-09-05'),
(20, '2023-09-10'),
(42, '2023-09-15'),
(23, '2023-09-25'),
(01, '2023-10-01'),
(21, '2023-10-05'),
(02, '2023-10-07'),
(16, '2023-10-08'),
(24, '2023-10-10'),
(07, '2023-10-12'),
(28, '2023-10-13'),
(27, '2023-10-14'),
(41, '2023-10-15'),
(09, '2023-10-16'),
(45, '2023-10-17'),
(30, '2023-10-18'),
(18, '2023-10-19'),
(33, '2023-10-20'),
(29, '2023-10-21'),
(25, '2023-10-22'),
(04, '2023-10-23'),
(02, '2023-10-24'),
(33, '2023-10-25'),
(30, '2023-10-26'),
(16, '2023-10-27'),
(13, '2023-10-28');

-- Inserciones en la tabla DetalleCarritoCompras (93)
INSERT INTO DetallesCarrito (id_carrito, id_videojuego, cantidad, precio_total)
VALUES
(1, 15, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 15) * 2),  -- Carrito 1, Videojuego 15, Cantidad 2
(1, 23, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 23) * 1),  -- Carrito 1, Videojuego 23, Cantidad 1
(2, 9, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 9) * 3),    -- Carrito 2, Videojuego 9, Cantidad 3
(2, 35, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 35) * 2),  -- Carrito 2, Videojuego 35, Cantidad 2
(3, 11, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 11) * 1),  -- Carrito 3, Videojuego 11, Cantidad 1
(3, 42, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 42) * 1),  -- Carrito 3, Videojuego 42, Cantidad 1
(4, 5, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 5) * 2),    -- Carrito 4, Videojuego 5, Cantidad 2
(4, 7, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 7) * 3),    -- Carrito 4, Videojuego 7, Cantidad 3
(5, 18, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 18) * 1),  -- Carrito 5, Videojuego 18, Cantidad 1
(5, 28, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 28) * 2),  -- Carrito 5, Videojuego 28, Cantidad 2
(6, 12, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 12) * 1),  -- Carrito 6, Videojuego 12, Cantidad 1
(6, 30, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 30) * 1),  -- Carrito 6, Videojuego 30, Cantidad 1
(7, 6, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 6) * 2),    -- Carrito 7, Videojuego 6, Cantidad 2
(7, 3, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 3) * 3),    -- Carrito 7, Videojuego 3, Cantidad 3
(8, 17, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 17) * 1),  -- Carrito 8, Videojuego 17, Cantidad 1
(8, 31, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 31) * 2),  -- Carrito 8, Videojuego 31, Cantidad 2
(9, 14, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 14) * 3),  -- Carrito 9, Videojuego 14, Cantidad 3
(9, 8, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 8) * 2),    -- Carrito 9, Videojuego 8, Cantidad 2
(10, 40, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 40) * 1), -- Carrito 10, Videojuego 40, Cantidad 1
(10, 25, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 25) * 1), -- Carrito 10, Videojuego 25, Cantidad 1
(11, 16, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 16) * 2),  -- Carrito 11, Videojuego 16, Cantidad 2
(11, 29, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 29) * 1),  -- Carrito 11, Videojuego 29, Cantidad 1
(12, 34, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 34) * 3),  -- Carrito 12, Videojuego 34, Cantidad 3
(12, 45, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 45) * 2),  -- Carrito 12, Videojuego 45, Cantidad 2
(13, 13, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 13) * 1),  -- Carrito 13, Videojuego 13, Cantidad 1
(13, 24, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 24) * 2),  -- Carrito 13, Videojuego 24, Cantidad 2
(14, 21, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 21) * 1),  -- Carrito 14, Videojuego 21, Cantidad 1
(14, 33, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 33) * 1),  -- Carrito 14, Videojuego 33, Cantidad 1
(15, 4, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 4) * 2),    -- Carrito 15, Videojuego 4, Cantidad 2
(15, 27, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 27) * 3),  -- Carrito 15, Videojuego 27, Cantidad 3
(16, 10, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 10) * 1),  -- Carrito 16, Videojuego 10, Cantidad 1
(16, 37, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 37) * 2),  -- Carrito 16, Videojuego 37, Cantidad 2
(17, 20, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 20) * 3),  -- Carrito 17, Videojuego 20, Cantidad 3
(17, 41, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 41) * 1),  -- Carrito 17, Videojuego 41, Cantidad 1
(18, 36, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 36) * 2),  -- Carrito 18, Videojuego 36, Cantidad 2
(18, 19, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 19) * 1),  -- Carrito 18, Videojuego 19, Cantidad 1
(19, 22, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 22) * 2),  -- Carrito 19, Videojuego 22, Cantidad 2
(19, 44, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 44) * 3),  -- Carrito 19, Videojuego 44, Cantidad 3
(20, 32, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 32) * 1),  -- Carrito 20, Videojuego 32, Cantidad 1
(20, 39, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 39) * 2),  -- Carrito 20, Videojuego 39, Cantidad 2
(21, 26, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 26) * 1),  -- Carrito 21, Videojuego 26, Cantidad 1
(21, 43, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 43) * 2),  -- Carrito 21, Videojuego 43, Cantidad 2
(22, 38, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 38) * 3),  -- Carrito 22, Videojuego 38, Cantidad 3
(22, 46, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 46) * 1),  -- Carrito 22, Videojuego 46, Cantidad 1
(23, 47, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 47) * 2),  -- Carrito 23, Videojuego 47, Cantidad 2
(23, 48, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 48) * 3),  -- Carrito 23, Videojuego 48, Cantidad 3
(24, 49, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 49) * 1),  -- Carrito 24, Videojuego 49, Cantidad 1
(24, 50, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 50) * 2),  -- Carrito 24, Videojuego 50, Cantidad 2
(25, 3, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 3) * 2),    -- Carrito 25, Videojuego 3, Cantidad 2
(25, 8, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 8) * 1),    -- Carrito 25, Videojuego 8, Cantidad 1
(26, 7, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 7) * 3),    -- Carrito 26, Videojuego 7, Cantidad 3
(26, 5, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 5) * 1),    -- Carrito 26, Videojuego 5, Cantidad 1
(27, 14, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 14) * 2),  -- Carrito 27, Videojuego 14, Cantidad 2
(27, 19, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 19) * 1),  -- Carrito 27, Videojuego 19, Cantidad 1
(28, 9, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 9) * 3),    -- Carrito 28, Videojuego 9, Cantidad 3
(28, 15, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 15) * 2),  -- Carrito 28, Videojuego 15, Cantidad 2
(29, 20, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 20) * 1),  -- Carrito 29, Videojuego 20, Cantidad 1
(29, 12, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 12) * 2),  -- Carrito 29, Videojuego 12, Cantidad 2
(30, 30, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 30) * 1),  -- Carrito 30, Videojuego 30, Cantidad 1
(30, 18, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 18) * 3),  -- Carrito 30, Videojuego 18, Cantidad 3
(31, 31, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 31) * 2),  -- Carrito 31, Videojuego 31, Cantidad 2
(31, 24, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 24) * 1),  -- Carrito 31, Videojuego 24, Cantidad 1
(32, 33, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 33) * 3),  -- Carrito 32, Videojuego 33, Cantidad 3
(32, 16, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 16) * 1),  -- Carrito 32, Videojuego 16, Cantidad 1
(33, 35, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 35) * 2),  -- Carrito 33, Videojuego 35, Cantidad 2
(33, 29, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 29) * 1),  -- Carrito 33, Videojuego 29, Cantidad 1
(34, 34, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 34) * 1),  -- Carrito 34, Videojuego 34, Cantidad 1
(34, 25, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 25) * 2),  -- Carrito 34, Videojuego 25, Cantidad 2
(35, 17, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 17) * 1),  -- Carrito 35, Videojuego 17, Cantidad 1
(35, 10, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 10) * 3),  -- Carrito 35, Videojuego 10, Cantidad 3
(36, 21, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 21) * 2),  -- Carrito 36, Videojuego 21, Cantidad 2
(36, 6, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 6) * 1),    -- Carrito 36, Videojuego 6, Cantidad 1
(37, 4, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 4) * 3),    -- Carrito 37, Videojuego 4, Cantidad 3
(37, 11, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 11) * 1),  -- Carrito 37, Videojuego 11, Cantidad 1
(38, 13, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 13) * 2),  -- Carrito 38, Videojuego 13, Cantidad 2
(38, 28, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 28) * 1),  -- Carrito 38, Videojuego 28, Cantidad 1
(39, 27, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 27) * 3),  -- Carrito 39, Videojuego 27, Cantidad 3
(39, 37, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 37) * 1),  -- Carrito 39, Videojuego 37, Cantidad 1
(40, 36, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 36) * 2),  -- Carrito 40, Videojuego 36, Cantidad 2
(40, 38, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 38) * 3),  -- Carrito 40, Videojuego 38, Cantidad 3
(41, 32, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 32) * 1),  -- Carrito 41, Videojuego 32, Cantidad 1
(41, 45, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 45) * 2),  -- Carrito 41, Videojuego 45, Cantidad 2
(42, 39, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 39) * 1),  -- Carrito 42, Videojuego 39, Cantidad 1
(42, 41, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 41) * 3),  -- Carrito 42, Videojuego 41, Cantidad 3
(43, 40, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 40) * 2),  -- Carrito 43, Videojuego 40, Cantidad 2
(43, 42, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 42) * 1),  -- Carrito 43, Videojuego 42, Cantidad 1
(44, 43, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 43) * 3),  -- Carrito 44, Videojuego 43, Cantidad 3
(44, 22, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 22) * 2),  -- Carrito 44, Videojuego 22, Cantidad 2
(45, 46, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 46) * 1),  -- Carrito 45, Videojuego 46, Cantidad 1
(45, 47, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 47) * 2),  -- Carrito 45, Videojuego 47, Cantidad 2
(46, 48, 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 48) * 3),  -- Carrito 46, Videojuego 48, Cantidad 3
(46, 49, 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 49) * 1),  -- Carrito 46, Videojuego 49, Cantidad 1
(47, 50, 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 50) * 2);  -- Carrito 47, Videojuego 50, Cantidad 2

-- Inserción de 20 pedidos donde el id_usuario sea un administrador
-- Asumiendo que los administradores tienen el rol 'Administrador' en la tabla Usuarios
-- La fecha del pedido es a partir del 1 de abril de 2023

INSERT INTO Pedidos (id_usuario, fecha_pedido, estado)
VALUES
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 0), '2023-04-05', 'pendiente'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 1), '2023-05-12', 'enviado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 2), '2023-06-18', 'entregado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 3), '2023-07-22', 'pendiente'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 4), '2023-08-09', 'enviado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 0), '2023-09-05', 'entregado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 1), '2023-10-01', 'pendiente'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 2), '2023-04-17', 'enviado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 3), '2023-05-30', 'entregado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 4), '2023-06-10', 'pendiente'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 0), '2023-07-14', 'enviado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 1), '2023-08-22', 'entregado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 2), '2023-09-01', 'pendiente'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 3), '2023-10-03', 'enviado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 4), '2023-04-25', 'entregado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 0), '2023-05-06', 'pendiente'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 1), '2023-06-21', 'enviado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 2), '2023-07-19', 'entregado'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 3), '2023-08-11', 'pendiente'),
((SELECT id_usuario FROM Usuarios WHERE rol = 'administrador' LIMIT 1 OFFSET 4), '2023-09-28', 'enviado');

-- Inserción en la tabla DetallePedido.
INSERT INTO DetallesPedido (id_pedido, id_videojuego, cantidad, precio_total)
VALUES
-- Pedido 1
(1, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 1), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 1) * 2),
(1, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 3), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 3) * 1),
-- Pedido 2
(2, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 2), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 2) * 1),
(2, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 4), 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 4) * 3),
-- Pedido 3
(3, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 5), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 5) * 2),
(3, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 6), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 6) * 1),
-- Pedido 4
(4, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 7), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 7) * 1),
(4, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 8), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 8) * 2),
-- Pedido 5
(5, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 9), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 9) * 1),
(5, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 10), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 10) * 2),
-- Pedido 6
(6, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 11), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 11) * 1),
(6, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 12), 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 12) * 3),
-- Pedido 7
(7, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 13), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 13) * 2),
(7, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 14), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 14) * 1),
-- Pedido 8
(8, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 15), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 15) * 1),
(8, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 16), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 16) * 2),
-- Pedido 9
(9, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 17), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 17) * 1),
(9, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 18), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 18) * 2),
-- Pedido 10
(10, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 19), 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 19) * 3),
(10, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 20), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 20) * 1),
-- Pedido 11
(11, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 21), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 21) * 1),
(11, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 22), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 22) * 2),
-- Pedido 12
(12, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 23), 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 23) * 3),
(12, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 24), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 24) * 1),
-- Pedido 13
(13, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 25), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 25) * 2),
(13, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 26), 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 26) * 3),
-- Pedido 14
(14, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 27), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 27) * 1),
(14, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 28), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 28) * 2),
-- Pedido 15
(15, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 29), 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 29) * 3),
(15, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 30), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 30) * 1),
-- Pedido 16
(16, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 31), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 31) * 2),
(16, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 32), 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 32) * 3),
-- Pedido 17
(17, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 33), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 33) * 1),
(17, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 34), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 34) * 2),
-- Pedido 18
(18, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 35), 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 35) * 3),
(18, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 36), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 36) * 1),
-- Pedido 19
(19, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 37), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 37) * 2),
(19, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 38), 3, (SELECT precio FROM Videojuegos WHERE id_videojuego = 38) * 3),
-- Pedido 20
(20, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 39), 1, (SELECT precio FROM Videojuegos WHERE id_videojuego = 39) * 1),
(20, (SELECT id_videojuego FROM Videojuegos WHERE id_videojuego = 40), 2, (SELECT precio FROM Videojuegos WHERE id_videojuego = 40) * 2);

-- Inserción de métodos de pago para los pedidos
INSERT INTO MetodosPago (id_pedido, tipo_pago, total)
VALUES
-- Pedido 1
(1, 'tarjeta', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 1)),
-- Pedido 2
(2, 'paypal', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 2)),
-- Pedido 3
(3, 'otros', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 3)),
-- Pedido 4
(4, 'tarjeta', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 4)),
-- Pedido 5
(5, 'paypal', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 5)),
-- Pedido 6
(6, 'otros', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 6)),
-- Pedido 7
(7, 'tarjeta', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 7)),
-- Pedido 8
(8, 'paypal', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 8)),
-- Pedido 9
(9, 'otros', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 9)),
-- Pedido 10
(10, 'tarjeta', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 10)),
-- Pedido 11
(11, 'paypal', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 11)),
-- Pedido 12
(12, 'otros', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 12)),
-- Pedido 13
(13, 'tarjeta', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 13)),
-- Pedido 14
(14, 'paypal', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 14)),
-- Pedido 15
(15, 'otros', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 15)),
-- Pedido 16
(16, 'tarjeta', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 16)),
-- Pedido 17
(17, 'paypal', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 17)),
-- Pedido 18
(18, 'otros', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 18)),
-- Pedido 19
(19, 'tarjeta', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 19)),
-- Pedido 20
(20, 'paypal', (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 20));

-- Inserción de dos devoluciones para pedidos entregados
-- Primera devolución
INSERT INTO Devoluciones (id_pedido, fecha_devolucion, monto_reembolso, estado, motivo)
VALUES
(
  -- Seleccionamos un pedido con estado "entregado"
  (SELECT id_pedido FROM Pedidos WHERE estado = 'entregado' LIMIT 1),
  -- Fecha de devolución (posterior a la fecha del pedido)
  (SELECT DATE_ADD(fecha_pedido, INTERVAL '5 DAY')::DATE FROM Pedidos WHERE estado = 'entregado' LIMIT 1),
  -- Monto de reembolso (igual al total de los detalles del pedido)
  (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 
    (SELECT id_pedido FROM Pedidos WHERE estado = 'entregado' LIMIT 1)), 
  -- Estado de la devolución (aleatorio entre pendiente, aceptada, rechazada)
  'aceptada',
  -- Motivo de la devolución (aleatorio)
  'Producto defectuoso'
),
-- Segunda devolución
(
  -- Seleccionamos otro pedido con estado "entregado"
  (SELECT id_pedido FROM Pedidos WHERE estado = 'entregado' LIMIT 1 OFFSET 1),
  -- Fecha de devolución (posterior a la fecha del pedido)
  (SELECT DATE_ADD(fecha_pedido, INTERVAL '7 DAY')::DATE FROM Pedidos WHERE estado = 'entregado' LIMIT 1 OFFSET 1),
  -- Monto de reembolso (igual al total de los detalles del pedido)
  (SELECT SUM(precio_total) FROM DetallesPedido WHERE id_pedido = 
    (SELECT id_pedido FROM Pedidos WHERE estado = 'entregado' LIMIT 1 OFFSET 1)),
  -- Estado de la devolución (aleatorio entre pendiente, aceptada, rechazada)
  'rechazada',
  -- Motivo de la devolución (aleatorio)
  'No era lo que esperaba'
);


-- Inserción de 20 extensiones de videojuegos realistas tomando como referencia videojuegos ya existentes
INSERT INTO ExtensionesVideojuegos (id_videojuego, nombre_extension, precio, fecha_lanzamiento, descripcion)
VALUES
-- Para un videojuego de carreras
(33, 'Speedsters Pack', 149.99, '2023-07-12', 'Añade nuevos autos de alta velocidad y circuitos desafiantes.'),
(33, 'Night Riders Expansion', 199.99, '2024-01-05', 'Expansión con modos de carrera nocturnos y nuevas pistas.'),
(9, 'Armored Warfare Expansion', 249.99, '2023-05-20', 'Incluye tanques pesados y armas de asalto en nuevas misiones.'),
(9, 'Battle Royale Mode', 299.99, '2023-10-11', 'Modo de juego Battle Royale con hasta 100 jugadores en un mapa abierto.'),
(14, 'Ancient Gods Pack', 199.99, '2023-08-22', 'Expande el mundo del juego con deidades mitológicas y poderes especiales.'),
(14, 'The Forbidden Realm', 279.99, '2023-12-30', 'Explora un reino prohibido lleno de desafíos épicos y tesoros ocultos.'),
(16, 'Fighter Legends DLC', 399.99, '2023-06-07', 'Incluye nuevos personajes legendarios con habilidades exclusivas.'),
(28, 'Galactic Conquest Expansion', 349.99, '2023-11-15', 'Añade nuevos planetas y misiones espaciales en una guerra intergaláctica.'),
(30, 'Jungle Warfare Expansion', 229.99, '2024-02-14', 'Nuevas misiones en selvas peligrosas, con enemigos furtivos y trampas.'),
(46, 'Stealth Operations Pack', 179.99, '2023-09-05', 'Modo de juego sigiloso con nuevas herramientas y habilidades tácticas.'),
(62, 'Ultimate Fighter Pack', 299.99, '2023-10-01', 'Añade cinco nuevos luchadores con estilos de combate únicos.'),
(56, 'Zombie Survival Mode', 149.99, '2023-07-18', 'Enfrenta hordas interminables de zombis en este nuevo modo de supervivencia.'),
(6, 'Legends of the Abyss', 199.99, '2023-12-02', 'Aventura submarina en lo más profundo del océano con criaturas míticas.'),
(6, 'The Sunken Kingdom', 289.99, '2024-01-25', 'Explora un reino submarino olvidado lleno de ruinas y tesoros.'),
(8, 'Cyberpunk City Expansion', 349.99, '2024-03-10', 'Añade una nueva ciudad futurista con misiones de alta tecnología.'),
(30, 'Mystical Forest Pack', 199.99, '2023-08-18', 'Explora bosques místicos llenos de criaturas mágicas y secretos.'),
(49, 'Winter Assault Expansion', 249.99, '2023-11-25', 'Combate en terrenos nevados y sobrevive a las duras condiciones climáticas.'),
(62, 'Pirates of the High Seas', 269.99, '2024-01-12', 'Embárcate en aventuras piratas con nuevos barcos, armas y misiones.'),
(4, 'Desert Warfare Pack', 319.99, '2023-10-30', 'Misiones de combate en el desierto con vehículos y tácticas especiales.'),
(7, 'The Dark Fortress', 399.99, '2023-09-17', 'Enfrenta los horrores de una fortaleza oscura llena de trampas y enemigos.');
--hasta aqui arriba todo bein 
-- Inserción de 5 registros en la tabla DetallesCompraExtensiones
INSERT INTO DetallesCompraExtensiones (id_usuario, id_extension, fecha_compra, cantidad, precio_total)
VALUES
-- Cliente con id_usuario = 10 comprando la extensión 'Night Fury DLC'
(10, 1, '2023-09-01', 1, 199.99),  -- Compró 1 unidad por el precio total de 199.99 MXN
-- Cliente con id_usuario = 12 comprando la extensión 'Stealth Operation Mode'
(12, 4, '2024-01-10', 2, 399.98),  -- Compró 2 unidades por el precio total de 399.98 MXN
-- Cliente con id_usuario = 15 comprando la extensión 'Ultimate Fighters'
(15, 13, '2023-12-05', 1, 229.99),  -- Compró 1 unidad por el precio total de 229.99 MXN
-- Cliente con id_usuario = 20 comprando la extensión 'Lost Treasures Expansion'
(20, 18, '2023-10-01', 1, 259.99),  -- Compró 1 unidad por el precio total de 259.99 MXN
-- Cliente con id_usuario = 18 comprando la extensión 'Galactic Outlaws Expansion'
(18, 9, '2023-12-10', 3, 1049.97);  -- Compró 3 unidades por el precio total de 1049.97 MXN
/*
SELECT * FROM usuarios;--1
SELECT * FROM Videojuegos;--2
SELECT * FROM generos;--3
SELECT * FROM videojuego_genero;--4
SELECT * FROM CarritoCompras;--5
SELECT * FROM DetallesCarrito;--6
SELECT * FROM Pedidos;--7
SELECT * FROM DetallesPedido;--8
SELECT * FROM MetodosPago;--9 
SELECT * FROM Devoluciones;--10
SELECT * FROM ExtensionesVideojuegos;--11
SELECT * FROM DetallesCompraExtensiones;--12
*/


-- Por Said Carbot Cruz Trejo,
--Oscar Alejandro Garza Villastrigo et
--Ivan Eduardo Blanco Almazan,ESCOM-IPN-MEX