# AWS Instance Automation

This is the configuration I use in mine I my website https://www.galere.se, using Apache/2.4.41 (Ubuntu).

## **System Requirements**:

- Terraform v0.14.5 ([Install Terraform](https://www.terraform.io/downloads.html))
- Ansible 2.9.6 ([Install Ansible](https://www.terraform.io/downloads.html))

Since I use AWS provider, we need the AWS CLI installed in our host machine the AWS command line interface to authenticate our account and to be able to create an EC2 Instance.

For the AWS CLI I used Linux 2.1.23 version, together with Python 3.7.3. Amazon recommends the direct download from the repository, instead of using some package mannager like *apt* or *yum*. 

In my case, version 2 for Linux x86_64 architecture was downloaded, using the following commands:

```shell
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \ 
    unzip awscliv2.zip && \
    sudo ./aws/install
```

To check if the installation succeded, type:

```shell
$ aws --version
```

## **AWS Authentication**:

Before we configure my local machine with aws-cli, we need to create an **AWS Access Key** and an **AWS Secret Key**, the former serves as an ID and the latter as an password. In this [article](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html) you will be able to follow each step to generate both keys.

After you get hold of the keys, open a terminal and run the aws-cli binary, following the instructions in the prompt:

```shell
$ aws configure
AWS Access Key ID []: $(ENTER_YOUR_ACCESS_KEY)
AWS Secret Access Key []: $(ENTER_YOUR_SECRET_KEY)
Default region name []:
Default output format []: 
```

For my default region I set *us-east-1* and for default output format I set *None*.

It is important to remember that those keys will be stored in plain text in your user home directory, under ~/.aws/credentials. Maybe is a good idea to change permissions in the folder, with *sudo chmod 700 /home/$(YOUR_USER)/.aws*.


## **Creating the EC2 Instance with Terraform**:

Now that our local machine have all the credential set up, we can initialize Terraform with this simple command:

```shell
$ sudo terraform init
```

The init command will download every plugin needed for that provider, along with a .terraform.lock.

The next step is to log you plan:

```shell
$ sudo terraform plan -out=./terraform.plan.out
```
This command will specify all the changes that your main.tf file will implement.

After that, we only need to type the apply command:

```shell
$ sudo terraform apply -auto-approve
```

And Terraform will do all the work.

### **Environment Varibles...**

In you local machine you will have to have a *terraform.tfvars* in order to load all of you env variables to the main.tf file. Note that **object/hash table** variables should be writen as follows:

```yml
instance_tags = {
    Name = "name"
    Type = "type"
}
```

## **Using Ansible to Configure Instance**:

To check if ansible is working, *cd* to ansible folder and type the *ad hoc* command:

```shell
$ cd ansible
$ sudo ansible all -i hosts -m command -a "hostname"
The authenticity of host '3.140.250.42 (3.140.250.42)' can't be established.
ECDSA key fingerprint is (...).
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
3.140.250.42 | CHANGED | rc=0 >>
ip-172-31-17-246
```

You should get your instance public IP in AWS EC2 Console, in the **Instance** section.

Make sure to change you ansible.cfg file to match you needs, and run the playbook with all the roles:

```shell
$ sudo ansible-playbook -i hosts -K playbook.yml  
```

## I don't like that, what should I do?

Simple! Terraform is able to connect with your AWS account and destroy all the changes your plan has made.

```shell
$ sudo terraform destroy -force
```