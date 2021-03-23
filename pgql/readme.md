# Postgresql

Prise en main de Postresql pour comprendre son fonctionnement ainsi que la sauvegarde sur S3.

## Initialisation

Exporter sa clef publique GPG dans le fichier `psql/public_key.gpg` :

~~~
gpg --export --output psql/public_key.gpg --armor <gpg_key>
~~~

Créer un fichier contenant les variables pour Ansible dans `psql/vars.yml` :
~~~
---
s3_id: "<id_access>"
s3_key: "<key_access>"
s3_path: "s3://toto-roberto"
~~~
