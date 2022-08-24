# Testing Terraform provider for Harvester
![Alt text](https://github.com/avaleror/harvester-terraform/blob/master/pictures/harvester_logo.png "Harvester logo")

Harvester is an HCI open source project based in Linux, Kubernetes, Kubevirt, and Longhorn developed by SUSE. It is an excelent platform for Edge, Cloud Native Data Centers, development environments, or labs. If you want to know more, go and check https://harvesterhci.io/ , [SUSE´s blog](https://www.suse.com/c/?s=harvester) or [SUSE's Harvester Product Page](https://www.suse.com/es-es/products/harvester/). 

On Harvester's GitHub repo, you can find the code for a Terraform provider that can be used to manage Harvester as Infrastructure-as-Code (IaC). You can also find the module on [Terraform's registry](https://registry.terraform.io/providers/harvester/harvester/). 

In case you want to have a better understanding of what it is needed to set up a Harvester lab take a look to this blog post: [Getting Hands on with Harvester HCI](https://www.suse.com/c/rancher_blog/getting-hands-on-with-harvester-hci/)

## Prerequisites
- Access to a Harvester cluster using a Kubeconfig file
- Terraform installed (https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Git cli

## This repo, what to expect
This repo is meant to help people to learn the basics of the Harvester Terraform module. You can review the Terraform provider documentation if you are looking for more examples. I'm not a Terraform expert, and there are probably many things to improve, so feel free to send PRs to improve the repo.

## How to use this repo

```
git clone https://github.com/avaleror/harvester-terraform.git
cd /whateverpath/harvester-terraform
vim versions.tf #update the path for your Harvester Kubeconfig
vim networks.tf #Add the network parameters for your cluster, otherwise the network and the VM will be created, but the VM won't have an IP
terraform init
terraform plan -out "tfplan"
terraform apply "tfplan"
```
Just wait a few minutes, and you'll have a VM deployed in Harvester.

## Useful links
You can find a fair amount of information about Harvester, Terraform, and the Harvester module in these links:

- https://harvesterhci.io/
- https://github.com/harvester/harvester 
- https://www.terraform.io/
- https://github.com/hashicorp/terraform 
- https://github.com/harvester/terraform-provider-harvester
- https://registry.terraform.io/providers/harvester/harvester/latest


## The repo structure
![Alt text](https://github.com/avaleror/harvester-terraform/blob/master/pictures/repo-tree.png "Terraform repo structure")

There is no standard structure when it comes to a Terraform repo; however, it is good practice to have separated files for different items or vars. This way, it is easier to understand what happens and which resources you need.
In many Terraform repos, you'll find a "main.tf" file but not in this one; you can use as many .tf files as you want to keep the repo clean and tidy. However, when Terraform executes the "terraform plan ..." command, it will parse all the .tf files together.

- First of all is important to create and maintain a .gitignore file, in case you don't know what this is, please read this article https://git-scm.com/docs/gitignore. Basically in this file you define the files that won't be uploaded to git. Once you run Terraform it creates different files used by Terraform like terraform.tfstate (where it keeps track of the changes made by the modules) or the .terraform folder, where when you run `terraform init` the different modules are downloaded, also you can use a .tfvars file to assign value to different vars and where there can be present passwords, tokens, etc. As you can imagine, it is important to maintain the .gitignore file avoiding upload unncessary or sensitive content to the git repo.
  
- In versions.tf we define which Terraform modules are needed to complete the tasks and the concrete versions. Also, in this file you can define extra args or info needed for the different modules. In this example, we provide as an argument the path for the Kubeconfig local file needed to access Harvester. 

- In Terraform repos is usual to find a file called variables.tf in this file you define the variables needed to run the terrafom jobs, in this file you can also initialize the value for those vars as a default value, this value can be override using a .tfvars file. However, in this case I did not use any extra variable definitions.

- In images.tf file we define the images we want to donwload in Harvester. 

- In network.tf it is defined a vlan net without any network parameters here you should define all the networks you need. If you want also it is possible to use one of the nets present in Harvester replacing the variable value in the vms.tf for "namespace/network-name" and deleting or comenting the content in this file". For this vlan definition to work configure your network parameters on it.

- In vms.tf we provide the definition of a VM that we want to have present in harvester. 

## The output
An Ubuntu 20.04 image will be downloaded, a vlan created in Harvester, and a VM deployed using the image previously downloaded and the cloud init configuration as defined in vms.tf. 
Depending if you are using an existing vlan or the definition provided in this repo, the network may not work since the network parameters are not defined in vlan created by the network.tf.
Since we are using KubeVirt all need a namespace to be deployed, in this case to make it simple the default namespace in the K8s cluster will used to deploy all the items defines in Terraform.

## Cleanup
With this command, all the resources created will be destroyed after you confirm with yes.
```
terraform destroy
```
