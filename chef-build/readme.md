# Chef-serveur

Comment build le Chef Infra Server et sa version CINC

Les actions suivantent doivent être fait en root.

## CINC

Dans un premier temps, il faut installer `omnibus` qui va permettre de construire le paquet, il suffit de lancer le script :

~~~
./omnibus.sh
~~~

Il faut maintenant patch le serveur Chef avec les modifications apportées par CINC :
~~~
cd ./cinc
./patch.sh
~~~

À partir de maitenant, on peut commencer à compiler le paquet !
~~~
cd ./server
./build.sh
~~~

Il faut attendre.

À la fin, le `.deb` se situe dans `./chef-server/omnibus/pkg`


## Chef serveur (le vrai)

Dans un premier, il faut aussi installer `omnibus` :

~~~
./omnibus.sh
~~~

Et on peut après lancer le build et attendre :

~~~
cd ./chef-server
./build.sh
~~~

Pareil, à la fin, le `.deb` se situe dans `./chef-server/omnibus/pkg`
