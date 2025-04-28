# Scripts de Déchargement Redshift (Redshift Unload Scripts)

## Contenu du Dossier
Ce dossier contient les scripts SQL et les configurations pour décharger des données depuis Amazon Redshift vers S3.


## Options Importantes
- `PARALLEL`: Contrôle l'écriture en parallèle (ON/OFF)
- `DELIMITER`: Spécifie le séparateur de champs
- `ADDQUOTES`: Ajoute des guillemets autour des champs
- `GZIP`: Compresse les fichiers de sortie
- `MANIFEST`: Crée un fichier manifest


## Notes Importantes
- Assurez-vous d'avoir les permissions IAM appropriées
- Vérifiez l'espace disponible dans S3
- Utilisez MANIFEST pour le suivi des fichiers
- Préférez la compression pour les grands volumes