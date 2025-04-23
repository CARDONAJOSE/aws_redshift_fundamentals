--Creando la tabla cartesian_venue
create table cartesian_venue(
venueid smallint not null distkey sortkey,
venuename varchar(100),
venuecity varchar(30),
venuestate char(2),
venueseats integer);

--Creando la tabla encodingvenue
create table encodingvenue (
venueraw varchar(100) encode raw,
venuebytedict varchar(100) encode bytedict,
venuelzo varchar(100) encode lzo,
venuerunlength varchar(100) encode runlength,
venuetext255 varchar(100) encode text255,
venuetext32k varchar(100) encode text32k,
venuezstd varchar(100) encode zstd);

-- creation dun example de table comprime

CREATE TABLE ventas_optimizadas (
    -- ID y cles
    venta_id BIGINT ENCODE RAW,                     -- Sans compression pour etre un SORTKEY
    cliente_id INTEGER ENCODE DELTA,                -- IDs secuenciale
    producto_sku VARCHAR(20) ENCODE BYTEDICT,       -- SKUs pas beacuop de variations
    
    -- dates et temps
    fecha_venta DATE ENCODE AZ64,                   -- dates comprime eficassement 
    hora_venta TIME ENCODE DELTA32K,                -- dates comprime avec Delta
    
    -- Donnes geographiques
    ciudad VARCHAR(50) ENCODE ZSTD,                 -- Texte avec diversite moyenne
    estado CHAR(2) ENCODE BYTEDICT,                -- Seul 2 caracteristiques avec pas beacoup de valeurs
    codigo_postal VARCHAR(10) ENCODE RUNLENGTH,     -- valeurs repetes pour área
    
    -- Donnes  financiers
    monto_total DECIMAL(12,2) ENCODE AZ64,          -- cifres decimales
    descuento_porcentaje SMALLINT ENCODE RUNLENGTH, -- Porcentages typiques repetes
    
    -- Texte libre
    notas_venta VARCHAR(500) ENCODE LZO,            -- Texto largo con patrones
    metodo_pago VARCHAR(30) ENCODE TEXT255,         -- Pocos métodos de pago distintos
    
    -- Flags y categoríes
    es_recurrente BOOLEAN ENCODE RUNLENGTH,         -- Valeurs booleanos repetes
    categoria_venta VARCHAR(15) ENCODE BYTEDICT,    -- Pocas categoríes
    
    -- Donnes JSON
    atributos_extra SUPER ENCODE ZSTD               -- Datos semiestructurados
    
) DISTKEY(cliente_id) SORTKEY(venta_id);


-- query pour compare la 

SELECT
   column,
   encoding,
   blocks,
   mb 
FROM svv_diskusage 
WHERE name = 'ventas_optimizadas' AND col = 0
ORDER BY mb;
-- ou 
SELECT
    column,
    encoding,
    block_count,
    size_mb
FROM svv_diskusage
WHERE table_name = 'ventas_optimizadas'
ORDER BY size_mb DESC;

-- change de compression sur un columne

ALTER TABLE ventas_optimizadas ALTER COLUMN ciudad ENCODE ZSTD;

-- analyse de compression d'un table 

ANALYZE COMPRESSION ventas_optimizadas;

