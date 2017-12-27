import requests
from requests_kerberos import HTTPKerberosAuth, REQUIRED

kerberos_auth = HTTPKerberosAuth(mutual_authentication=REQUIRED, sanitize_mutual_error_response=False)
r = requests.get("http://files.enigma.com:8080/blah", auth=kerberos_auth)

print(r.status_code)
print(r.content)
