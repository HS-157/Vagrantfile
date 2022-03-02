# postgresql-replicat

Test streaming replication for PostgreSQL.

## Run vagrant

The Vagrantfile create two VM, one master and one salve and provision with Ansible.

```
vagrant up
```

### Master

Install, configure and restore test database for PostgreSQL.

### Slave

Install, configure and stopped PostgreSQL service.


## Test replication

Connect to slave :

```
vagrant ssh slave
```

Remove old database :

```
sudo rm -rv /var/lib/postgresql/13/main
```

Sync database with master and « azertyuiop » as password :

```
sudo -u postgres pg_basebackup -h 10.42.0.10 -D /var/lib/postgresql/13/main -U replication -v -P --wal-method=stream --write-recovery-conf
```

Start in standy mode :

```
sudo touch /var/lib/postgresql/13/main/standby.signal
sudo systemctl start postgresql@13-main.service
```

Connection on database and list tables :

```
sudo -u postgres psql -d "dvdrental" -c "\dt"
```

For test streamong replication, you can remove table on master :

```
vagrant ssh master
sudo -u postgres psql -d "dvdrental" -c "DROP TABLE IF EXISTS store, staff CASCADE;"
```

And show on slave the dropped tables :

```
sudo -u postgres psql -d "dvdrental" -c "\dt"
```

# Reference

* https://www.qunsul.com/posts/postgresql-13-streaming-replication-on-ubuntu.html
