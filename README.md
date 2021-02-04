# vm-aws-automation


I use this configuration in my website https://www.galere.se.

```shellS
$ sudo terraform init
```

```shell
$ sudo terraform plan -out=./terraform.plan.out
```

```shell
$ sudo terraform apply -auto-approve
```

To check if ansible is working, cd to ansible folder and type the *ad hoc* command:
```shell
$ cd ansible
$ sudo ansible all -i hosts -m command -a "hostname"
3.140.194.253 | CHANGED | rc=0 >>
ip-172-31-27-90
```