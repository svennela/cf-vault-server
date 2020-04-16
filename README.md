## cf push vault server in "Dev" Server Mode
### To download vault binary 
run install_vault.sh

cf push

you can do cf logs vault --recent to copy unseal key to the file

Unseal Key: VYLraWsViEw8jm4ZmMhUkdMWeBrmsJqicxmCPswx0Vs=

Root Token: 00000000-0000-0000-0000-000000000000

### env variales for vault cli

export VAULT_ADDR='https://vault.apps.<domainname>'

export VAULT_DEV_ROOT_TOKEN_ID=00000000-0000-0000-0000-000000000000

export VAULT_SKIP_VERIFY=1

export VAULT_TOKEN=00000000-0000-0000-0000-000000000000


### Writing a Secret

vault kv put secret/hello foo=world

vault kv get secret/hello


### Writing a Secret

vault kv get secret/hello

### Deleting a Secret

vault kv delete secret/hello






