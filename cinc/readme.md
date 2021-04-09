# CINC

# Chef-serveur

## Installation

Copier la configuration du serveur dans `/etc/opscode/chef-server.rb`.

Installer le serveur Chef CINC :

~~~
sudo apt install ./cinc-server-core_14.2.2-1_amd64.deb
~~~

Une fois installer, il faut reconfigurer le serveur Chef :

~~~
sudo chef-server-ctl reconfigure
~~~

## Création de l'organisation

À partir de là, il faut créer une organisation pour nos utilisateurs

~~~
sudo chef-server-ctl org-create roberto "Roberto LOVE"
~~~

## Créer un utilisateur et le rajouter dans l'organisation

On crée un utilisateur avec les informations nécessaire :

~~~
sudo chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL PASSWORD
sudo chef-server-ctl user-create toto Toto Roberto toto@rober.to "123456"
~~~

C'est mieux d'importer une clef publique donnée par l'utilisateur que lui envoyer la clef privée générée par le serveur.

On génére la pair de clef :
~~~
openssl genrsa -out key.pem 4096
openssl rsa -in toto.pem -outform PEM -pubout -out toto.pub
~~~

On peut stocker la clef privée dans `~.cinc/` pour knife et donner la publique au serveur chef :
~~~
sudo chef-server-ctl delete-user-key toto default
sudo chef-server-ctl add-user-key toto -p toto.pub
~~~

Puis on le rajoute à l'organisation :

~~~
sudo chef-server-ctl org-user-add <org> <user>
~~~

Si on veut qu'il soit admin dans l'organisation, il fait rajouter l'option `--admin` :

~~~
sudo chef-server-ctl org-user-add <org> <user> --admin
~~~


### Rajouter comme admin

Il est possible de le rajouter pour qu'il a le droit de créer d'autres utilisateurs :

~~~
sudo chef-server-ctl grant-server-admin-permissions toto
~~~

## Cookbook upload

Maitenant que l'utilisateur à accès, on peut envoyer les cookbooks dans le serveur :
~~~
cd ~/cookbooks
knife cookbook upload --cookbook-path . *
~~~


## Bootstrap serveur

À partir de maintenant, il est possible de rajouter des serveurs dans le serveur Chef :

~~~
knife bootstrap --node-name $(hostname -f) -U vagrant --sudo --run-list 1-test,2-tata,3-foo 127.0.0.1
knife bootstrap --node-name $(hostname -f) -U vagrant --sudo 127.0.0.1
~~~

Référence :

- https://docs.chef.io/workstation/getting_started/#without-webui
- https://docs.chef.io/workstation/config_rb/
- https://docs.chef.io/server/ctl_chef_server/
- https://docs.chef.io/server/config_rb_server/
- https://docs.chef.io/install_bootstrap/


# Astuce

Rajouter knife dans le PATH :

~~~
export PATH=/opt/cinc-project/bin:$PATH
~~~

Accpeter un certificat auto-signé :

~~~
knife ssl fetch
~~~
