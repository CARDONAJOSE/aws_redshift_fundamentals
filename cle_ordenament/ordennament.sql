-- Table avec une clé de tri composée (COMPOUND SORTKEY)
CREATE TABLE ventes_composée (
    id INT,
    date_vente DATE,
    montant DECIMAL(10,2),
    client_id INT
)
COMPOUND SORTKEY (date_vente, client_id);

-- Table avec une clé de tri entrelacée (INTERLEAVED SORTKEY)
CREATE TABLE ventes_entrelacee (
    id INT,
    date_vente DATE,
    montant DECIMAL(10,2),
    client_id INT
)
INTERLEAVED SORTKEY (date_vente, client_id);

--Insertion de donnees
INSERT INTO ventes_composée VALUES
(1, '2024-06-01', 100.00, 101),
(2, '2024-06-02', 150.00, 102);

INSERT INTO ventes_entrelacee VALUES
(1, '2024-06-01', 200.00, 201),
(2, '2024-06-03', 250.00, 202);


-- Afficher les colonnes de clé de tri pour toutes les tables
SELECT
    sk.schemaname,
    sk.tablename,
    sk.column,
    sk."column" AS position_dans_sortkey
FROM
    svv_sortkey_columns sk
WHERE
    sk.tablename IN ('ventes_composée', 'ventes_entrelacee')
ORDER BY
    sk.schemaname, sk.tablename, sk."column";