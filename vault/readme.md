# Vault

Prise en main de Vault pour comprendre son fonctionnement.

## Initialisation

On commence par lancer le serveur à la main avec la conf souhaité.

~~~
sudo su -s /bin/bash -c "vault server -config=/etc/vault.d/vault.hcl" vault
~~~

Puis, dans un nouveau terminal, on créer les clefs permettant de dévérouiller Vault au démarrage :

~~~
export VAULT_ADDR='https://127.0.0.1:8200'
export VAULT_SKIP_VERIFY="true" # Pour ne pas voir les erreur de TLS
vault operator init
~~~

Sauvegarder et distribuer les clefs à différentes personnes.

Ensuite, il est possible de dévérouiller en donnant 3 des 5 clefs (par défaut) :

~~~
vault operator unseal # ×3
~~~

Maintenant, on peut faire des actions pour gérer les secrets, les *policies* et les jetons.

D'abord se connecter avec le jeton *root* qui nous a été donné :
~~~
vault login
~~~

Activer les secret pour le chemin `secret` :
~~~
vault secrets enable -path=secret/ kv
~~~

On peut peupler les secrets avec le script `/tmp/vault/provision.sh` :
~~~
/tmp/vault/provision.sh
~~~

~~~
vault kv list secret/
vault kv list secret/postgresql/
~~~

On peut créer des *policies* pour limité l'accès à certain secret en lecture / écriture :
~~~
vault policy write postgresql /tmp/vault/policies/postgresql.hcl
vault token create -policy=postgresql
~~~

On peut se connecter avec ce token et tester les différentes routes :
~~~
vault login
vault kv list secret/postgresql/ # OK
vault kv list secret/ # Fail
~~~

Maintenant, on peut arrêter Vault depuis le premier terminal.

## Production

Lancer la prod !

On commence par activer et lancer le service :
~~~
sudo systemctl enable --now vault
~~~

Une fois le service démarrer, il faut dévérouiller Vault et le faire à chaque fois que la machine redémarre :
~~~
vault operator unseal
vault status
~~~

À partir de maintenant, les services ayant besoin de secret peuvent utiliser Vault !

## Test avec Ansible

Exemple d'utilisation de Vault avec un playbook Ansible, il suffit de donner le jeton de *postgresql* pour accèder au secret :
~~~
/tmp/ansible/provision.sh
~~~
