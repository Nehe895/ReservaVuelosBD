CREATE TABLE aerolineas (
    id_aerolinea serial NOT NULL,
    nombre       VARCHAR(50),
    pais         VARCHAR(25),
    codigo_iata  VARCHAR(3)
);

ALTER TABLE aerolineas ADD CONSTRAINT aerolineas_pk PRIMARY KEY ( id_aerolinea );

CREATE TABLE boletos (
    boleto_id               serial NOT NULL,
    clase                   VARCHAR(10),
    precio                  INTEGER,
    pasajeros_pasajero_id   VARCHAR(10) NOT NULL,
    vuelos_vuelo_id         INTEGER NOT NULL,
    aerolineas_id_aerolinea INTEGER NOT NULL
);

CREATE UNIQUE INDEX boletos__idx ON
    boletos (
        pasajeros_pasajero_id
    ASC,
        aerolineas_id_aerolinea
    ASC,
        vuelos_vuelo_id
    ASC );

CREATE UNIQUE INDEX boletos__idxv3 ON
    boletos (
        pasajeros_pasajero_id
    ASC );

CREATE UNIQUE INDEX boletos__idxv4 ON
    boletos (
        aerolineas_id_aerolinea
    ASC );



ALTER TABLE boletos ADD CONSTRAINT boletos_pk PRIMARY KEY ( boleto_id );

CREATE TABLE checkin (
    id_checkin   serial NOT NULL,
    hora_checkin DATE,
    estado       VARCHAR(10)
);

ALTER TABLE checkin ADD CONSTRAINT checkin_pk PRIMARY KEY ( id_checkin );

CREATE TABLE destinos (
    destino_id       serial NOT NULL,
    nombre           VARCHAR(25),
    longitud_destino numeric(9, 6),
    latitud_destino  numeric(9, 6)
);

ALTER TABLE destinos ADD CONSTRAINT destinos_pk PRIMARY KEY ( destino_id );

CREATE TABLE origen (
    origen_id       serial NOT NULL,
    nombre          VARCHAR(20),
    longitud_origen numeric(9, 6),
    latitud_origen  numeric(9, 6)
);

ALTER TABLE origen ADD CONSTRAINT origen_pk PRIMARY KEY ( origen_id );

CREATE TABLE pasajeros (
    pasajero_id  VARCHAR(10) NOT NULL,
    nombre       VARCHAR(50),
    apellido     VARCHAR(50),
    edad         INTEGER,
    genero       VARCHAR(1),
    nacionalidad VARCHAR(20),
    telefono     VARCHAR(15),
    correo       VARCHAR(60)
);

ALTER TABLE pasajeros ADD CONSTRAINT pasajeros_pk PRIMARY KEY ( pasajero_id );

CREATE TABLE pasajeros_atrasados (
    pasajero_a_id     serial NOT NULL,
    motivo            text,
    hora_registro     DATE,
    boletos_boleto_id INTEGER NOT NULL
);

ALTER TABLE pasajeros_atrasados ADD CONSTRAINT pasajeros_atrasados_pk PRIMARY KEY ( pasajero_a_id );

CREATE TABLE ruta_destino (
    r_destino_id        INTEGER NOT NULL,
    km_recorido         numeric(9, 2),
    pais                VARCHAR(20),
    origen_origen_id    INTEGER NOT NULL,
    destinos_destino_id INTEGER NOT NULL,
    destino_id          INTEGER NOT NULL
);

ALTER TABLE ruta_destino ADD CONSTRAINT ruta_destino_pk PRIMARY KEY ( r_destino_id );

CREATE TABLE vuelos (
    vuelo_id                  INTEGER NOT NULL,
    codigo                    VARCHAR(13),
    hora_salida               TIMESTAMP,
    hora_llegada              TIMESTAMP,
    ruta_destino_r_destino_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX vuelos__idx ON
    vuelos (
        ruta_destino_r_destino_id
    ASC );

ALTER TABLE vuelos ADD CONSTRAINT vuelos_pk PRIMARY KEY ( vuelo_id );

ALTER TABLE boletos
    ADD CONSTRAINT boletos_aerolineas_fk FOREIGN KEY ( aerolineas_id_aerolinea )
        REFERENCES aerolineas ( id_aerolinea );


ALTER TABLE boletos
    ADD CONSTRAINT boletos_pasajeros_fk FOREIGN KEY ( pasajeros_pasajero_id )
        REFERENCES pasajeros ( pasajero_id );

ALTER TABLE boletos
    ADD CONSTRAINT boletos_vuelos_fk FOREIGN KEY ( vuelos_vuelo_id )
        REFERENCES vuelos ( vuelo_id );

ALTER TABLE pasajeros_atrasados
    ADD CONSTRAINT pasajeros_atrasados_boletos_fk FOREIGN KEY ( boletos_boleto_id )
        REFERENCES boletos ( boleto_id );

ALTER TABLE ruta_destino
    ADD CONSTRAINT ruta_destino_destinos_fk FOREIGN KEY ( destinos_destino_id )
        REFERENCES destinos ( destino_id );

ALTER TABLE ruta_destino
    ADD CONSTRAINT ruta_destino_origen_fk FOREIGN KEY ( origen_origen_id )
        REFERENCES origen ( origen_id );

ALTER TABLE vuelos
    ADD CONSTRAINT vuelos_ruta_destino_fk FOREIGN KEY ( ruta_destino_r_destino_id )
        REFERENCES ruta_destino ( r_destino_id );


INSERT INTO pasajeros (pasajero_id, nombre, apellido, edad, genero, nacionalidad, telefono, correo)
VALUES
    ('P001', 'John', 'Doe', 30, 'M', 'USA', '123456789', 'john.doe@example.com'),
    ('P002', 'Jane', 'Smith', 25, 'F', 'Canada', '987654321', 'jane.smith@example.com'),
    ('P003', 'Michael', 'Johnson', 45, 'M', 'UK', '555555555', 'michael.johnson@example.com'),
    ('P004', 'Emily', 'Brown', 28, 'F', 'Australia', '111111111', 'emily.brown@example.com'),
    ('P005', 'Daniel', 'Miller', 35, 'M', 'Germany', '222222222', 'daniel.miller@example.com'),
    ('P006', 'Sophia', 'Anderson', 31, 'F', 'Sweden', '333333333', 'sophia.anderson@example.com'),
    ('P007', 'Matthew', 'Wilson', 50, 'M', 'USA', '444444444', 'matthew.wilson@example.com'),
    ('P008', 'Olivia', 'Taylor', 27, 'F', 'Canada', '555555555', 'olivia.taylor@example.com'),
    ('P009', 'William', 'Thomas', 33, 'M', 'UK', '666666666', 'william.thomas@example.com'),
    ('P010', 'Ava', 'Robinson', 24, 'F', 'Australia', '777777777', 'ava.robinson@example.com'),
    ('P011', 'James', 'Clark', 42, 'M', 'Germany', '888888888', 'james.clark@example.com'),
    ('P012', 'Isabella', 'Harris', 29, 'F', 'Sweden', '999999999', 'isabella.harris@example.com'),
    ('P013', 'Benjamin', 'Lewis', 37, 'M', 'USA', '111122223', 'benjamin.lewis@example.com'),
    ('P014', 'Mia', 'Walker', 26, 'F', 'Canada', '444433332', 'mia.walker@example.com'),
    ('P015', 'Alexander', 'White', 39, 'M', 'UK', '999988887', 'alexander.white@example.com'),
    ('P016', 'Sofia', 'Lee', 23, 'F', 'Australia', '111122223', 'sofia.lee@example.com'),
    ('P017', 'Henry', 'Green', 32, 'M', 'Germany', '333344445', 'henry.green@example.com'),
    ('P018', 'Charlotte', 'Taylor', 31, 'F', 'Sweden', '666655554', 'charlotte.taylor@example.com'),
    ('P019', 'Joseph', 'Martin', 35, 'M', 'USA', '999966665', 'joseph.martin@example.com'),
    ('P020', 'Harper', 'Hall', 28, 'F', 'Canada', '222211110', 'harper.hall@example.com');


INSERT INTO aerolineas (id_aerolinea, nombre, pais, codigo_iata)
VALUES
    (1, 'American Airlines', 'Estados Unidos', 'ANC'),
    (2, 'Delta Air Lines', 'Estados Unidos', 'ATL'),
    (3, 'United Airlines', 'Estados Unidos', 'BOS'),
    (4, 'Air France', 'Francia', 'SXB'),
    (5, 'Lufthansa', 'Alemania', 'BER'),
    (6, 'British Airways', 'Reino Unido', 'LHR'),
    (7, 'Emirates', 'Emiratos Árabes Unidos', 'DXB'),
    (8, 'Qatar Airways', 'Qatar', 'QR'),
    (9, 'Singapore Airlines', 'Singapur', 'SIN'),
    (10, 'Cathay Pacific Airways', 'Hong Kong', 'HKG');
--  select * from pasajeros;

INSERT INTO destinos (destino_id, nombre, longitud_destino, latitud_destino)
VALUES
    (1, 'Ciudad de México', 19.4326, -99.1332),
    (2, 'Nueva York', 40.7128, -74.0060),
    (3, 'París', 48.8566, 2.3522),
    (4, 'Tokio', 35.6895, 139.6917),
    (5, 'Sídney', -33.8651, 151.2099),
    (6, 'Roma', 41.9028, 12.4964),
    (7, 'Londres', 51.5074, -0.1278),
    (8, 'Dubái', 25.2048, 55.2708),
    (9, 'Sao Paulo', -23.5505, -46.6333),
    (10, 'Toronto', 43.6519, -79.3817),
    (11, 'Berlín', 52.5200, 13.4050),
    (12, 'Buenos Aires', -34.6037, -58.3816),
    (13, 'Cairo', 30.0444, 31.2357),
    (14, 'Estambul', 41.0082, 28.9784),
    (15, 'Ámsterdam', 52.3702, 4.8952);
    
INSERT INTO origen (origen_id, nombre, longitud_origen, latitud_origen)
VALUES
    (1, 'San Salvador', -89.18718, 13.68935);
    
INSERT INTO ruta_destino (r_destino_id, pais, origen_origen_id, destinos_destino_id, destino_id)
VALUES
    (1, 'México', 1, 2, 2),
    (2, 'Estados Unidos', 1, 3, 3),
    (3, 'Francia', 1, 4, 4),
    (4, 'Japon', 1, 5, 5),
    (5, 'Australia', 1, 6, 6);
    
INSERT INTO vuelos (vuelo_id, codigo, hora_salida, hora_llegada, ruta_destino_r_destino_id)
VALUES
    (1, 'FLIGHT001', NOW() + INTERVAL '45 minutes', NOW() + INTERVAL '2 hours', 1),
    (2, 'FLIGHT002', NOW() + INTERVAL '1 hour', NOW() + INTERVAL '3 hours', 2),
    (3, 'FLIGHT003', NOW() + INTERVAL '1 hour 15 minutes', NOW() + INTERVAL '3 hours 30 minutes', 3),
    (4, 'FLIGHT004', NOW() + INTERVAL '1 hour 30 minutes', NOW() + INTERVAL '4 hours', 4),
    (5, 'FLIGHT005', NOW() + INTERVAL '1 hour 45 minutes', NOW() + INTERVAL '4 hours 30 minutes', 5);

INSERT INTO boletos ( clase, precio, pasajeros_pasajero_id, vuelos_vuelo_id, aerolineas_id_aerolinea)
VALUES
	( 'Economy', 400, 'P001', 2, 1),
    ( 'Business', 1000, 'P002', 2, 2),
    ( 'Economy', 600, 'P003', 3, 3),
    ( 'Economy', 550, 'P004', 4, 4),
    ( 'Business', 1200, 'P005', 5, 5);
    

--==SELECT S

 SELECT vuelo_id ,hora_salida::time,hora_llegada::time,km_recorido ,pais  FROM vuelos INNER JOIN ruta_destino
 ON vuelos.ruta_destino_r_destino_id  = ruta_destino.r_destino_id ;
 ;
--==END SELECT S


--=====|| TRIGGER DE CALCULO DE LA DISTANCIA  || =======--
CREATE OR REPLACE FUNCTION calcular_kilometros_recorridos()
RETURNS TRIGGER AS $$
DECLARE
  lon_origen FLOAT;
  lat_origen FLOAT;
  lon_destino FLOAT;
  lat_destino FLOAT;
    delta_lat FLOAT;
    delta_lon FLOAT;
    a FLOAT;
    c FLOAT;
    d FLOAT;
    radius FLOAT := 6371; -- Radio de la Tierra en kilómetros
BEGIN
    --  coordenadas de origen
    lon_origen:= 
    (SELECT longitud_origen
    FROM origen
    WHERE origen_id = NEW.origen_origen_id);

    lat_origen:= 
    (SELECT latitud_origen
    FROM origen
    WHERE origen_id = NEW.origen_origen_id);
    --  coordenadas de destino
    lon_destino:= 
    (SELECT longitud_destino
    FROM destinos
    WHERE destino_id = NEW.destinos_destino_id);

    lat_destino:= 
    (SELECT latitud_destino
    FROM destinos
    WHERE destino_id = NEW.destinos_destino_id);

 -- Cálculo de la distancia utilizando la fórmula Haversine
  delta_lat := radians(lat_destino - lat_origen);
  delta_lon := radians(lon_destino - lon_origen);
  a := sin(delta_lat / 2) * sin(delta_lat / 2) +
       cos(radians(lat_origen)) * cos(radians(lat_destino)) *
       sin(delta_lon / 2) * sin(delta_lon / 2);
  c := 2 * atan2(sqrt(a), sqrt(1 - a));
  d := radius * c;
	 NEW.km_recorido := d;
	--raise notice 'lat_origen:  % , lon origen:  %',lat_origen,lon_origen;
	--raise notice 'lat_destino:  % , lon destino:  %',lat_destino,lon_destino;
	--raise notice 'Kilometros recorridos: %', d;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER calcular_kilometros_trigger
BEFORE INSERT OR UPDATE ON ruta_destino
FOR EACH ROW
EXECUTE FUNCTION calcular_kilometros_recorridos();

--=====|| TRIGGER DE CALCULO DE LA DISTANCIA  || =======--


--========= FUNCION PASAJEROSM A(RE)TRASADOS ======--
CREATE OR REPLACE FUNCTION hacer_checkin()
RETURNS TRIGGER AS $$
DECLARE
vuelo_hora_salida TIMESTAMP;
BEGIN
    -- Obtener la hora de salida del vuelo correspondiente al boleto
    SELECT hora_salida INTO vuelo_hora_salida
    FROM vuelos
    WHERE vuelo_id = NEW.vuelos_vuelo_id;
    
    -- Verificar si falta una hora o menos para el despegue
    IF vuelo_hora_salida - INTERVAL '1 hour' <= NOW() THEN
        -- Insertar el registro en la tabla pasajeros_atrasados
        INSERT INTO pasajeros_atrasados (motivo, hora_registro, boletos_boleto_id)
        VALUES ('Falta de tiempo para el check-in', NOW(), NEW.boleto_id);
   
    
    -- Actualizar el estado del check-in en la tabla checkin
    INSERT INTO checkin (id_checkin,hora_checkin, estado)
    VALUES (New.boleto_id,NOW(), 'Atrasado');
	
	else
	INSERT INTO checkin (id_checkin,hora_checkin, estado)
    VALUES (New.boleto_id,NOW(), 'pendiente');
    
	 END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_hacer_checkin
AFTER INSERT ON boletos
FOR EACH ROW
EXECUTE FUNCTION hacer_checkin();

--========= FUNCION PASAJEROSM A(RE)TRASADOS ======--

select * from vuelos;
SELECT * FROM boletos;
SELECT * FROM checkin;
SELECT * from pasajeros_atrasados;
select * from pasajeros;
select * from ruta_destino;

Select
    t1.TABLE_NAME AS tabla_nombre,
    t1.COLUMN_NAME AS columna_nombre,
    t1.COLUMN_DEFAULT AS columna_defecto,
    t1.IS_NULLABLE AS columna_nulo,
    t1.DATA_TYPE AS columna_tipo_dato,
    COALESCE(t1.NUMERIC_PRECISION,
    t1.CHARACTER_MAXIMUM_LENGTH) AS columna_longitud,
    PG_CATALOG.COL_DESCRIPTION(t2.OID,
    t1.DTD_IDENTIFIER::int) AS columna_descripcion,
    t1.DOMAIN_NAME AS columna_dominio
FROM 
    INFORMATION_SCHEMA.COLUMNS t1
    INNER JOIN PG_CLASS t2 ON (t2.RELNAME = t1.TABLE_NAME)
WHERE 
    t1.TABLE_SCHEMA = 'public'
ORDER BY
    t1.TABLE_NAME;