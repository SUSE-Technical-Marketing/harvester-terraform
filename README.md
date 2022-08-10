# Testing terraform provider for Harvester
Harvester is ain HCI open source project based in Linux, Kubernetes, Kubevirt and Longhorn developed by SUSE. It is a great platform for Edge, small data centers or home labs. If you want to know more go and check https://harvesterhci.io/ or the SUSE blog. In Harvester's GitHub repo you can find the code for a Terraform provider in order to manage Harvester as IaC. You can find also the module in Terraform's registry. 

## Useful links
https://www.terraform.io/
https://github.com/hashicorp/terraform 
https://github.com/harvester/terraform-provider-harvester
https://registry.terraform.io/providers/harvester/harvester/latest

# This repo, what to expect
This repo is meant to help people to learn the basics of the Harvester terraform module, in case you are looking for more content you can look into the examples in the terraform doc. I'm not a terraform expert and probably there are many things to improve, so feel free to send PRs to improve the repo.
There is no standard structure when it comes to a Terraform repo, however it is good practice to have separated files for different items or vars. In this way is easier to understand what happens and which resources you need.

## The repo structure
![Alt text](https://github.com/avaleror/harvester-terraform/blob/master/pictures/repo-tree.png "Terraform repo structure")

In many Terraform repos you'll find a main.tf file but not in this one, you can use as many .tf files as you want to keep the repo clean and tidy. However, when Terraform executes de `terraform plan xxxx` command it will parse all the .tf files all together.

- First of all is important to a .gitignore file, in case you don't know what this is, please read this article https://git-scm.com/docs/gitignore. Basically in this file you define the files that won't be uploaded to git. Once you run terraform it creates different files used by terraform like terraform.tfstate (where it keeps track of the changes made by the modules) or .terraform where when you run `terraform init` the different modules are downloaded, also you can use a .tfvars file to assign value to different vars and where usually there are sensitive information, so it is important to not upload this file to git.
  
- In versions.tf we define which terraform modules are needed to complete the tasks and the concrete versions. Also, in this file you can define extra args or info needed for the different modules. In this example it is needed to provide the path for the Kubeconfig file needed to access Harvester. 

- In terraform repos is usual to find a file calles variables.tf in this file you define the variables needed to run the terrafom job, in here you can also initialize the value for those vars. However, in this case I did not use any extra definitions.

- In harvester_images.tf file we define the images we want to donwload in Harvester. 

- In vm_resource.tf we provide the definition of a VM that we want to have present in harvester. Inside this definition you'll find some "hardcoded" values, this is because I want to use networks or images already present in Harvester instead of creating new ones. For instance, if you want to deploy a new network alongside the VM you can define a variable inside the variables.tf file and then consume it from the vm_resource.tf file or just create a file (something like network.tf) where you define the network you want to create.

