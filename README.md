# Descriptions
- to bootstrap the whole pubsub infrastructure

# Usage
- generate RSA key-pair

```
cp ./terraform/aws.sample ./terraform/aws.tf
terraform get
terraform plan
terraform apply
```

- debug
```
ansible -i plugins/inventory/terraform.py --list
```

- bootstrap

```
 ansible-playbook -i plugins/inventory/terraform.py ansible-playbook.yml -vvv --private-key /home/vagrant/.ssh/pubsub
```

# Contact
- Binh Nguyen
