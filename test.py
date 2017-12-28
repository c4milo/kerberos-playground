import requests
from krbcontext import krbContext

from requests_kerberos import HTTPKerberosAuth, OPTIONAL 

with krbContext(using_keytab=True,
           principal='INGESTION/asm.enigma.com',
           keytab_file='ingestion.keytab'):
  pass

kerberos_auth = HTTPKerberosAuth(mutual_authentication=OPTIONAL, sanitize_mutual_error_response=False)
r = requests.get("http://files.enigma.com/mydata.csv", auth=kerberos_auth)
#r = requests.get("https://www.petmd.com/sites/default/files/petmd-cat-happy-10.jpg", auth=kerberos_auth)

print(r.status_code)
print(r.content)
