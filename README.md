### Kerberos playground

1. `docker-compose up`
2. `make keytab`
3. `docker-compose exec krb5-kdc kinit -kt /var/lib/ingestion/ingestion.keytab 'INGESTION/asm.enigma.com'`
4. `docker-compose exec krb5-kdc python3 /var/lib/ingestion/test.py`
