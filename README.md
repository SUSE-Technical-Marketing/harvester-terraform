# Testing Terraform provider for Harvester
![Alt text](https://github.com/avaleror/harvester-terraform/blob/master/pictures/harvester_logo.png "Harvester logo")

Harvester is an HCI open source project based in Linux, Kubernetes, Kubevirt, and Longhorn developed by SUSE. It is an excelent platform for Edge, Cloud Native Data Centers, development environments, or labs. If you want to know more, go and check https://harvesterhci.io/ , [SUSE´s blog](https://www.suse.com/c/?s=harvester) or [SUSE's Harvester Product Page](https://www.suse.com/es-es/products/harvester/). 

On Harvester's GitHub repo, you can find the code for a Terraform provider that can be used to manage Harvester as Infrastructure-as-Code (IaC). You can also find the module on [Terraform's registry](https://registry.terraform.io/providers/harvester/harvester/). 

In case you want to have a better understanding of what it is needed to set up a Harvester lab take a look to this blog post: [Getting Hands on with Harvester HCI](https://www.suse.com/c/rancher_blog/getting-hands-on-with-harvester-hci/)

The code in this repo has been created as part of a blog post that fully describes the process of using Terraform and Harvester and can be reviewed here: [Managing Harvester with Terraform ](https://www.suse.com/c/rancher_blog/managing-harvester-with-terraform/)

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
```
$ tree
.
├── LICENSE
├── README.md
├── images.tf
├── network.tf
├── pictures
│   ├── harvester_logo.png
├── providers.tf
├── terraform.tfstate
├── terraform.tfvars_example
├── variables.tf
└── vms.tf
```

There is no standard structure when it comes to a Terraform repo; however, it is good practice to have separated files for different items or vars. This way, it is easier to understand what happens and which resources you need.

In many Terraform repos, you'll find a "main.tf" file but not in this one; you can use as many .tf files as you want to keep the repo clean and tidy. However, when Terraform executes the "terraform plan ..." command, it will parse all the .tf files together.

- First of all, it is important to create and maintain a .gitignore file; in case you don't know what this is, please read this article https://git-scm.com/docs/gitignore. There is where you define the files that won't be uploaded to git. Once you run Terraform, it creates several files (like "terraform.tfstate" where it keeps track of the changes made by the modules) and a folder called ".terraform" (where downloaded modules are stored after running "terraform init"). You can also use a ".tfvars" file to assign values to different vars, and may you may need to store sensitive information like passwords, tokens, etc. As you can imagine, keeping all those files and folders listed in the .gitignore file is crucial to avoid uploading unnecessary or sensitive content to the git repo.
  
- In "providers.tf" we define which Terraform modules are needed to complete the tasks and the concrete versions. Also, in this file, you can define extra args or information required by the different modules. In this example, we provide as an argument the path for the Kubeconfig local file needed to access Harvester.

- In Terraform repos is usual to find a file called "variables.tf" where you define the variables needed to run the Terraform jobs; there, you can also initialize the value for those vars with a default value. The default values can be overridden using a ".tfvars" file with your configuration values. Check file "terraform.tfvars_example" for some example values.

- In "images.tf" file, we define the OS image we want to create in Harvester. 

- In "network.tf" we define which of the existing networks will be used for our virtual machine. If you want to create a custom network, just replace the "data" block with a "resource" block with your new network definition.

- Finally, "vms.tf" contains the definition of the VM that is going to be created in Harvester. There is where we control VM-specific parameters (CPU, disks, etc.) and link to the OS image and network definitions described above.

## The output
An openSUSE 15 SP4 image will be downloaded, a VM will be deployed using that image for the OS disk, and the network interface will be connected to the defined VLAN. Deployment time OS configuration relies on the well-known cloud-init model, and you can see an example within the "vms.tf" file.
Since we are using KubeVirt on top of Kubernetes, all created objects need a namespace to be deployed. We used the "default" namespace to keep things simple, but you can just play with the Terraform variables and select your own namespace definition.

## Cleanup
This command will destroy all the resources created after you confirm with "yes".
```
terraform destroy
```
