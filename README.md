# Testing terraform provider for Harvester
Harvester is a virtualization open source project based in Linux, Kubernetes, Kubevirt and Longhorn developed by SUSE. It is a great platform for Edge, small data centers or home labs. If you want to know more go and check https://harvesterhci.io/ or the SUSE blog. In Harvester's GitHub repo you can find the code for a Terraform provides in order to manage Harvester as IaC. You can find also the module in Terraform's repo. 

## Useful links
https://github.com/harvester/terraform-provider-harvester
https://registry.terraform.io/providers/harvester/harvester/latest

# This repo, what to expect
This repo is meant to learn the basics of the Harvester terraform module, in case you are looking for more content you can look into the examples in the terraform doc. I'm not a terraform expert and probably there are many things to improve, so feel free to send PRs to improve the repo.
There is no standard structure when it comes to a Terraform repo, however it is good practice to have separated files for different items or vars. Terraform will put all together when you run terraform apply but it is way more easy to understand what happens if you do it  this way.

## The repo structure
![Alt text](https://github.com/avaleror/harvester-terraform/blob/master/pictures/repo-tree.png "Terraform repo structure")

In many Terraform repos you'll find a main.tf file but not in this one, you can use as many .tf files as you want to keep the repo clean and tidy. However, when Terraform executes de `terraform plan xxxx` command it will parse all the .tf files all together.

- First of all there is the providers.tf where we define which terraform provers are going to use,  and the versions we want to use.

- In variables.tf we define all the vars needed in main.tf.

- In versions.tf we define which terraform modules are needed to complete the tasks and the concrete versions.
