## Comprenssion

## Algorithmes de compression disponibles dans Redshift

| Algorithme   | Meilleur pour                          | Description                                                                 |
|--------------|----------------------------------------|-----------------------------------------------------------------------------|
| **RAW**      | Colonnes petites ou déjà compressées   | Aucune compression                                                         |
| **BYTEDICT** | Colonnes avec peu de valeurs uniques   | Dictionnaire de bytes pour valeurs répétitives                             |
| **DELTA**    | Données séquentielles (dates, IDs)     | Stocke les différences entre valeurs consécutives                          |
| **LZO**      | Texte, données semi-structurées        | Compression rapide avec bon ratio pour les textes                          |
| **RUNLENGTH**| Colonnes avec nombreuses répétitions   | Stocke la valeur + nombre de répétitions                                   |
| **ZSTD**     | Usage général                          | Excellent équilibre entre vitesse et taux de compression                   |
| **AZ64**     | Données numériques (entiers, décimaux) | Algorithme avancé d'Amazon optimisé pour les nombres                       |

### Recommandations d'utilisation :

- **Clés de tri** : Toujours utiliser `RAW` pour les SORTKEY
- **Données catégorielles** : `BYTEDICT` pour moins de 256 valeurs uniques
- **Séquences numériques** : `DELTA` pour les IDs ou dates séquentielles
- **Texte long** : `ZSTD` ou `LZO` selon les besoins vitesse/compression
- **Valeurs booléennes** : `RUNLENGTH` très efficace pour les TRUE/FALSE répétés
- **Données numériques** : `AZ64` offre les meilleurs résultats pour les nombres

Explication des analyses des colonnes

column	Nom de la colonne analysée
encoding	Schéma de compression actuel (RAW, ZSTD, DELTA, etc.)
blocks	Nombre de blocs de stockage utilisés (1 bloc = 1MB)
mb/size_mb	Espace total occupé en mégaoctets
block_count	Nombre de blocs (nom plus descriptif dans la version récente)

## Types de données optimisés

| Type de données       | Utilisation recommandée                     | Avantage                          |
|-----------------------|--------------------------------------------|-----------------------------------|
| **SMALLINT**          | Pour les IDs (au lieu de INTEGER)          | Économise de l'espace de stockage |
| **VARCHAR(n)**        | Avec des longueurs spécifiques (100, 30)   | Évite le gaspillage d'espace      |
| **CHAR(2)**           | Pour les codes d'état (longueur fixe)      | Stockage plus efficace            |

### Explications :

1. **SMALLINT** (2 octets) au lieu de INTEGER (4 octets) :
   - Gain de 50% d'espace pour les colonnes d'ID
   - Suffisant pour la plupart des tables (<32,767 valeurs)

2. **VARCHAR avec taille spécifique** :
   - `VARCHAR(100)` pour les noms de produits
   - `VARCHAR(30)` pour les villes
   - Éviter `VARCHAR(MAX)` inutilement large

3. **CHAR pour longueurs fixes** :
   - Idéal pour les codes pays (CHAR(2))
   - Plus efficace que VARCHAR pour ces cas
   - Exemple : 'FR', 'ES', 'DE'