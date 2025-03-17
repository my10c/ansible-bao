# UNDER CONSTRUCTION

## ansible
The ansible setup use by our devops/sre team

### Background
- we use [letsencrypt](https://letsencrypt.org/) for our LDAP and other certs
 
### Notes
- the directory .ssh and .vault should be set to mode 0700
- the files .ssh/id* and .vault/passwd.vault should be set to mode 0400
- suggestions are *very* welcome! always love to improve our code
- we are looking to us IPv6 once the cloud providers supports [RFC 4193](https://datatracker.ietf.org/doc/html/rfc4193)
- the script `create_random_password` (under bin) can be use to generate random string to be use fro password

### State
- work in progress

### The End
Your friendly BOFH 🦄 😈          
