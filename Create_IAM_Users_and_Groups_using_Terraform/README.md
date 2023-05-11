# Create IAM Users and Groups using Terraform
## What is Terraform?
Terraform is an open-source infrastructure-as-code (IaC) tool developed by HashiCorp. 
It allows users to define and manage infrastructure resources (such as virtual machines, networks, and storage) in a declarative manner, 
using a high-level configuration language.

With Terraform, you define your desired infrastructure state in code, which can be version-controlled and collaboratively developed. 
Terraform then compares your code with the current state of the infrastructure and determines what changes are necessary to bring it to the desired state. 
It then applies those changes in a safe and efficient manner, minimizing downtime and avoiding human error.

Terraform supports a wide range of infrastructure providers, including public cloud providers like AWS, Azure, and Google Cloud, 
as well as private cloud providers and on-premises infrastructure. 
It also has a large ecosystem of plugins and modules, which can extend its functionality and allow you to reuse common infrastructure patterns.

## Prerequisites
a. Install Terraform in your local machine using this officiall guide by Hashicorp

b. To install Terraform using CLI, use this guide: https://learn.hashicorp.com/tutorials/terraform/install-cli

c. To install Terraform by downloading, use this guide: https://www.terraform.io/downloads.html 

d. Download and Install Visual Studio code editor using this guide: https://code.visualstudio.com/download

## Architectural Diagram
![Create_IAM_Users_And_Groups](https://user-images.githubusercontent.com/105270837/224870078-96af7626-9701-4aa7-afef-170f1a7a1f37.png)

## Task Details
1. Sign into AWS Management Console
2. Setup Visual Studio Code
3. Create a variable file
4. Create IAM users in main.tf file
5. Create IAM group and add IAM users in main.tf file
6. Create an output file
7. Confirm the installation of Terraform by checking the version.
8. Apply terraform configurations
9. Check the resources in AWS Console
10. Delete AWS Resources

### Task 1: Sign into AWS Management Console
1. Click on this link to log into the AWS console: https://aws.amazon.com/console/
2. On the AWS sign-in page provide your IAM Username and Password and click on the Sign in button.
3. Once signed in to the AWS management console, make the default AWS region as US East (N. Virginia) us-east-1.

### Task 2: Setup Visual Studio Code
1. Open the visual studio code.
2. If you have already installed and using Visual studio code, open a new window.
3. A new window will open a new file and release notes page (only if you have installed or updated Visual Studio Code recently). Close the Release notes tab.
4. Open Terminal by selecting View from the Menu bar and choose Terminal. 
5. It may take up to 2 minutes to open the terminal window.
6. Once the terminal is ready, let us navigate to the Desktop.
```.sh
cd Desktop
```
7.Create a new folder by running the below command.
```.sh
mkdir task_IAMUsers
```
8. Change your present working directory to use the newly created folder by running the below command:
```.sh
cd task_IAMUsers
```
9. Get the location of the present working directory by running the below command:
```.sh
pwd
```
10. Note down the location, as you will open the same in the next steps.
11. Now click on the first icon Eplorer present on the left sidebar.
12. Click on the button called Open Folder and navigate to the location of the folder **task_IAMUsers**.

![vscode_Screenshot_Open_Folder](https://user-images.githubusercontent.com/105270837/225067791-cef70a8b-43dd-458e-a359-679fa0171edd.jpg)

13. (Optional) Click on **"Yes, I trust the authors"** button for allowing Visual Studio code to use the task_IAMUsers folder. This will only be asked when you
have been using Cisual Studio code for a while as you are allowing a new folder to be accessed by VSC.
14. Visual Studio Code is now ready to use.

### Task 3: Create a variable file
In this task, you will create variable files where you will declare all the global variables with a short description and a default value.

1. To create a variable file, expand the folder **task_IAMUsers** and click on the **New File** icon to add the file.
2. Name the file as **variables.tf** and press **Enter** to save it.
3. **Note:** Don't change the location of the new file, keep it default, i.e. inside the **task_IAMUsers** folder.
4. Paste the below contents in **variables.tf** file.
```.tf
variable "access_key" {
    description = "Access key to AWS console"
}
variable "secret_key" {
    description = "Secret key to AWS console"
}
variable "region" {
    description = "AWS region"
}
```
5. In the above content, you are declaring a variable called, access_key, secret_key, and region with a short description of all 3.
6. After pasting the above contents, save the file by pressing **ctrl + S**.
7. Now expand the folder **task_IAMUsers** and click on the **New File** icon to add the file.
8. Name the file as **terraform.tfvars** and press **Enter** to save it.
9. Paste the below content into the **terraform.tfvars** file.
```.tf
region = "us-east-1"
access_key = "<YOUR AWS CONSOLE ACCESS ID>"
secret_key = "<YOUR AWS CONSOLE SECRET KEY>"
```
10. In the above code, you are defining the dynamic values of variables declared earlier.
11. Replace the values of access_key and secret_key with your own credentials.
12. After replacing the values of access_key and secret_key, save the file by pressing **Ctrl + S**.
![terraformtfvars](https://user-images.githubusercontent.com/105270837/225074018-eca65456-6b49-4347-a17e-a1fc2e583bcc.jpg)

### Task 4: Create IAM Users in main.tf file
In this task, you will create a main.tf file where you will add details of the provider and resources.
1. To create a **main.tf** file, expand the folder **task_IAMUsers** and click on the **New File** icon to add the file.
2. Name the file as **main.tf** and press **Enter** to save it.
3. Paste the below content into the **main.tf** file.
```.tf
provider "aws" {
    region     = "${var.region}"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}
```
4. In the above code, you are defining the provider as aws.
5. Next, we want to tell Terraform to create 4 IAM users.
6. To create IAM Users Paste the below content into the **main.tf** file after the provider
```.tf
#################### Creating 4 IAM Users ######################
resource "aws_iam_user" "user1" {
  name = "Jane"
  path = "/"
  tags = {
    tag-key = "Dev-Team"
  }
}
resource "aws_iam_user" "user2" {
  name = "Peter"
  path = "/"
  tags = {
    tag-key = "Dev-Team"
  }
}
resource "aws_iam_user" "user3" {
  name = "Paul"
  path = "/"
  tags = {
    tag-key = "Finance-Team"
  }
}
resource "aws_iam_user" "user4" {
  name = "Zippy"
  path = "/"
  tags = {
    tag-key = "Finance-Team"
  }
}

```
![createIAMUsers](https://user-images.githubusercontent.com/105270837/225075498-96b0a0a9-62d6-41db-bb9e-6c317c83248e.jpg)

7. This code will create four IAM users in your AWS account with the specified names, paths, and tags.

### Task 5: Create IAM group and add IAM users in main.tf file 
In this task, you will create 2 IAM groups and add IAM users in the main.tf file.
1. To create IAM groups add another block of code just below the IAM user code into the **main.tf** file
```.tf
####################  Create New IAM Group and add IAM Users ######################
resource "aws_iam_group" "group1" {
  name = "DevTeam"
}
resource "aws_iam_group_membership" "member1" {
  name = "user1"
  users = [
    aws_iam_user.user1.name,
    aws_iam_user.user2.name,
  ]
  group = aws_iam_group.group1.name
}
resource "aws_iam_group" "group2" {
  name = "FinanceTeam"
}
resource "aws_iam_group_membership" "member2" {
  name = "user2"
  users = [
    aws_iam_user.user3.name,
    aws_iam_user.user4.name,
  ]
  group = aws_iam_group.group2.name
}

```
![creategroups](https://user-images.githubusercontent.com/105270837/225077008-a817c880-227b-4cd8-bdfa-591ec5578df0.jpg)

2. This code will create two IAM groups in your AWS account with the specified names and add the specified users to each group.
3. Save the file by pressing Ctrl + S. 

### Task 6: Create an Output file
In this task, you will create an **output.tf** file where you will add details of the provider and resources.
1. To create an **output.tf** file, expand the folder **task_IAMUsers** and click on the **New File** icon to add the file.
2. Name the file as **output.tf** and press **Enter** to save it.
3. Paste the below content into the **output.tf** file
```.tf
output "user1" {
  value       = aws_iam_user.user1.arn
}
output "user2" {
  value       = aws_iam_user.user2.arn
}
output "user3" {
  value       = aws_iam_user.user3.arn
}
output "user4" {
  value       = aws_iam_user.user4.arn
}
output "group1" {
  value       = aws_iam_group.group1.arn
}
output "group2" {
  value       = aws_iam_group.group2.arn
}
```
4. In the above code, we will extract details of resources created to confirm that they are created.

### Task 7: Confirm the installation of Terraform by checking the version
1. In the Visual Studio Code, open Terminal by selecting **View** from the Menu bar and choose **Terminal**.
2. If you are not in the newly created folder change your present working directory by running the below command.
```.sh
cd task_IAMUsers
```
3. To confirm the installation of Terraform, run the below command to check the version:
```.sh
terraform version
```
4. If you are getting output as command not found: terraform, this means that terraform is not installed on your system, 
To install terraform follow the official guide link provided in the Prerequisite section above.

### Task 8: Apply terraform configurations
1. Initialize Terraform by running the below command,
```.sh
terraform init
```
![taskIamuser](https://user-images.githubusercontent.com/105270837/225081507-072ec93e-6f3b-4fba-a5e7-3630668d3528.jpg)

***Note: terraform init will check for all the plugin dependencies and download them if required, this will be used for creating a deployment plan***
2. To generate the action plans run the below command,
```
terraform plan
```
![terraformplan](https://user-images.githubusercontent.com/105270837/225082684-48b9c776-a1f4-4e92-9360-f364250793ef.jpg)

3. To create all the resources declared in main.tf configuration file, run the below command:
```
terraform apply
```
4. Approve the creation of all the resources by entering **yes**.
![usersandoutput](https://user-images.githubusercontent.com/105270837/225083607-d53f8642-f6f7-423d-a935-0e259278ffd4.jpg)

5. Id’s of all the resources created by terraform will be visible there.

### Task 9: Check the resources in AWS Console
1. Make sure you are in the **US East (N. Virginia) us-east-1** Region.
2. Navigate to **IAM** by clicking on **Services** on the top, then click on **IAM** in the **Security, Identity, & Compliance** section.
3. Click on the **Users** on the left navigation panel. You can see the 4 users (Jane, Peter, Paul & Zippy) created successfully.
4. Click on the **User groups** on the left navigation panel. You can see the groups created successfully.
![groups](https://user-images.githubusercontent.com/105270837/225085216-71d29521-1684-40d9-8684-7a221f3853d2.jpg)

5. Select group **DevTeam** you can see 2 users added successfully      
![devteam](https://user-images.githubusercontent.com/105270837/225085709-73092eba-9b6f-467b-b652-9c3b25796e2d.jpg)

6. Similarly you can check 2 users added in **FinanceTeam**
![FinanceTeam](https://user-images.githubusercontent.com/105270837/225085838-4b0bf63b-85a3-4595-923d-c60407fa83eb.jpg)

### Task 10: Delete AWS Resources
1. To delete the resources, open Terminal again.
2. Run the below command to delete all the resources:
```.sh
terraform destroy
```
3. Approve the creation of all the resources by entering **yes**. You can see the **Destroy complete!** message.
![destroy](https://user-images.githubusercontent.com/105270837/225088281-a984dfcb-c714-46bc-9449-955cb4a6badb.jpg)

## Completion and Conclusion
* You have successfully set up the Visual Studio Code editor.
* You have successfully created variables.tf and terraform.tfvars files.
* You have successfully created 4 IAM Users using terraform
* You have successfully created IAM groups and added users using terraform
* You have successfully created output.tf
* You have successfully executed the terraform configuration commands to create the resources
* You have successfully checked all the resources created by viewing them on the Console
* You have successfully deleted all the resources.
