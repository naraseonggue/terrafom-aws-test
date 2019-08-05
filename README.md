```bash
# You can pass backend configuration file with relative path.
$ terraform init -backend-config=backend.tfvars

# Also you can combine file and key/value parameters like this.
$ terraform init -backend-config backend.tfvars -backend-config="profile=tf-admin"
```

# Plan / Apply blueprint
```bash
# Using variable file & var parameter example
$ terraform plan -var-file dev.tfvars -var='prefix=canary'
```
# terrafom-aws-test
