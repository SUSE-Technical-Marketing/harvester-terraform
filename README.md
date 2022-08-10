# Testing terraform provider for Harvester
![Alt text](https://github.com/avaleror/harvester-terraform/blob/master/pictures/harvester_logo.png "Harvester logo")

Harvester is ain HCI open source project based in Linux, Kubernetes, Kubevirt and Longhorn developed by SUSE. It is a great platform for Edge, small data centers or home labs. If you want to know more go and check https://harvesterhci.io/ or the SUSE blog. In Harvester's GitHub repo you can find the code for a Terraform provider in order to manage Harvester as IaC. You can find also the module in Terraform's registry. 

## Pre requisites
- Access to a Harvester cluster
- Install terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Git cli

## How to use this repo
Following the steps described before you'll download an Ubuntu 20.04 image to harverster, you'll create a new network, and deploy a VM with two disks using the image you just downloaded. 
´´´
git clone https://github.com/avaleror/harvester-terraform.git
cd /whateverpath/harvester-terraform
vim versions.tf #update the path for your Harvester Kubeconfig
terraform init
terraform plan -out "tfplan"
terraform apply "tfplan"
´´´
Just wait a couple of minutes and you'll have a VM deployed in Harvester.

## Useful links
In these links you can find a fair amount of information about Terraform and the Harvester module.

https://www.terraform.io/
https://github.com/hashicorp/terraform 
https://github.com/harvester/terraform-provider-harvester
https://registry.terraform.io/providers/harvester/harvester/latest

# This repo, what to expect
This repo is meant to help people to learn the basics of the Harvester terraform module, in case you are looking for more content you can look into the examples in the terraform doc. I'm not a terraform expert and probably there are many things to improve, so feel free to send PRs to improve the repo.
There is no standard structure when it comes to a Terraform repo, however it is good practice to have separated files for different items or vars. In this way is easier to understand what happens and which resources you need.

## The repo structure
![Alt text](https://github.com/avaleror/harvester-terraform/blob/master/pictures/repo-tree.png "Terraform repo structure")

In many Terraform repos you'll find a main.tf file but not in this one, you can use as many .tf files as you want to keep the repo clean and tidy. However, when Terraform executes the `terraform plan xxxx` command it will parse all the .tf files all together.

- First of all is important to create and maintain a .gitignore file, in case you don't know what this is, please read this article https://git-scm.com/docs/gitignore. Basically in this file you define the files that won't be uploaded to git. Once you run terraform it creates different files used by terraform like terraform.tfstate (where it keeps track of the changes made by the modules) or the .terraform folder, where when you run `terraform init` the different modules are downloaded, also you can use a .tfvars file to assign value to different vars and where there can be present passwords, tokens, etc. As you can imagine, it is important to maintain the .gitignore file avoiding upload unncessary or sensitive content to the git repo.
  
- In versions.tf we define which terraform modules are needed to complete the tasks and the concrete versions. Also, in this file you can define extra args or info needed for the different modules. In this example, we provide as an argument the path for the Kubeconfig local file needed to access Harvester. 

- In terraform repos is usual to find a file calles variables.tf in this file you define the variables needed to run the terrafom job, in here you can also initialize the value for those vars. However, in this case I did not use any extra variable definitions.

- In harvester_images.tf file we define the images we want to donwload in Harvester. 

- In network.tf it is defined a vlan net without any network parameters, you can also use one of the nets present in Harvester replacing the variable in the vms.tf for "namespace/network-name" and deleting or comenting the content in this file"

- In vms.tf we provide the definition of a VM that we want to have present in harvester. 

## The output
An ubuntu 20.04 VM deployed using the image downloaded and with the cloud init configuration defined in vms.tf. Depending on if you used and existing vlan or using the definition provided in this repo the network may not work since the network parameters are not defined in vlan created by the network.tf. Since we are using KubeVirt all need a namespace to be deployed, in this case to make it simple the dafult namespace in the K8s cluster has been used.

## Cleanup
With this command all the resources created shoul be destroyed.
```
terraform destroy
```