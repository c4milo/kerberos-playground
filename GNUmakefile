keytab: clean
	docker-compose exec krb5-kdc \
		/usr/sbin/kadmin.local -q "ktadd -k /var/lib/ingestion/ingestion.keytab INGESTION/asm.enigma.com"

clean:
	rm -rf ingestion.keytab

.PHONY: keytab
