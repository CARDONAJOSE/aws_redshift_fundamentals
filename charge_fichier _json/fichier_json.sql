-- creer le table en redshift

create  table  estudiante
( id  int2,
nombre  varchar(20),
apellido  varchar(20),
edad  int2,
fecha_ingreso  date );

-- charge les donnees depuis S3

COPY estudiante (id, nombre, apellido, edad, fecha_ingreso, metadata)
FROM 's3://tu-bucket-datos/estudiantes/estudiantes.json'
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftLoadRole'
FORMAT AS JSON 'auto'
DATEFORMAT 'YYYY-MM-DD';