--- creer une nouvelle table des donnees a telecharge c'est un bonne practique avec un query optimise
create table unload_test as ( 
    --utiliser un select * c'est un mauvaise practique mais ici c'est juste un example
    select * from nom_table 
)

-- le command unload 
UNLOAD ('SELECT * FROM nom_table')
TO 's3://nom-de-votre-bucket/dossier_unload/nom_fichier_/'
IAM_ROLE 'arn:aws:iam::votre-compte:role/nom-du-role'
ALLOWOVERWRITE --ECRASER FICHIER ACTUEL
DELIMITER ';' -- DELIMITEUR DE FICHIER
HEADER -- DONE UN HEADER A BD
MAXFILESIZE 500 mb -- taille MAX DU FICHIER
GZIP -- COMPRESSE LES FICHIER GZIP, BZIP2 OU ZSTD
MANIFEST -- CREER UN FICHIER JASON AVEC LES SHEMIN OU SPECIFICATION DE LA QUERY
PARTITION BY (nom_column) INCLUDE -- Creer de fichier agrupe por la column selectione
;


-- Export avec compression GZIP
UNLOAD ('SELECT * FROM sales')
TO 's3://mon-bucket/ventes/data_'
IAM_ROLE 'arn:aws:iam::compte:role/mon-role'
GZIP
PARALLEL OFF;

-- Export par date
UNLOAD ('SELECT * FROM sales WHERE date = CURRENT_DATE')
TO 's3://mon-bucket/ventes/date_partition='
IAM_ROLE 'arn:aws:iam::compte:role/mon-role'
MANIFEST;