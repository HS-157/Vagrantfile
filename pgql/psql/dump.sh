#/usr/bin/env bash

DB=("ville_france" "world" "iso-3166" "usda" "sports")

sudo -u postgres mkdir -p /tmp/dump/plain
sudo -u postgres mkdir -p /tmp/dump/gpg

for db in ${DB[@]} ; do 
  echo "Dumping $db"
  sudo -u postgres pg_dump -C -F plain -f /tmp/dump/plain/$db.sql $db
  sudo -u postgres gpg --yes --encrypt --recipient-file /var/lib/postgresql/public_key.gpg --output /tmp/dump/gpg/${db}.sql.gpg /tmp/dump/plain/${db}.sql
  sudo -u postgres aws s3 cp /tmp/dump/gpg/${db}.sql.gpg {{ s3_path }}/$db-$(date '+%Y-%m-%d_%H%M%S').sql.gpg
done
