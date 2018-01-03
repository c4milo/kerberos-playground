### Kerberos playground

0. Add the following to your development machine `/etc/hosts` file
```
127.0.0.1       krb5-admin.enigma.com
127.0.0.1       krb5-kdc.enigma.com
127.0.0.1       files.enigma.com
127.0.0.1       enigma.com
```
1. `docker-compose up`
2. `make keytab`
3. `docker-compose exec krb5-kdc kinit -kt /var/lib/ingestion/ingestion.keytab 'INGESTION/asm.enigma.com'`
4. `docker-compose exec krb5-kdc python3 /var/lib/ingestion/test.py`


### Debugging

KRB5_TRACE=/dev/stdout kinit -kt ingestion.keytab INGESTION/asm.enigma.com
