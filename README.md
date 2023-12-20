# aws-lz
A Git Repo for a basic AWS Landing Zone Project

A great launchpad for anyoone wanting to DevOps ther TF code and make life a bit easier.

What does this git include?

- Containerized local Docker with full Terraform, AWS CLI and various other extentions to help keep your team aligned. Fully integrated into Visual Studio Code.
- A CICD pipeline which will spin up a container which will use a IAM role in AWS to create Terraform resources, it'll also store Terraform state in S3 and utilize DynamoDB for LockIDs.
- An example of a resource (VPC) deployed as part of the terraform code.

How to use this repo;

**Pre-requisites**

You'll need to perform the following on your system to get the best of this repo;

**System BIOS**
 - Enable Virtualization in BIOS (Docker Support)

**Windows Terminal **
 - winget install -e --id Microsoft.VisualStudioCode
 - winget install -e --id Docker.DockerDesktop
 - winget install -e --id Git.Git
 - winget install -e --id GitHub.cli
 - mkdir C:\Git\Projects
 - sl C:\Git\Projects
 - git clone https://github.com/chris-fison/aws-lz.git
 - . code
 - git checkout -b production

You'll at this point probably want to push the cloned git up to your own git repo, once done read the rest of the docucumentation as theres further configuration needed and I explain what things do.

**How to Use**

.devcontainer
 - devcontainer.json 
 - dockerfile
 - post-start.sh

This contains all your Docker components which your local system will use to build out the container.

You can modify the extentions if you don't need them, but the idea is your team would use the same extentions, so everyone is using the same version.

A few standouts here are formatting code when saved, such as correct indentation. Once you've built the container you can use the filter @installed to see what's there.

.github
 - terraform.yml

This contains all your github action components which your git account will use to build out its container to run Terraform code.

To put it simply, this will be your CICD pipeline which activates on activity on the main branch - it'll use an S3, DynamoDB and IAM user you'll create below.

You'll need to create an S3 bucket within your AWS tenant, all default settings, enable versioning and SSE AWS KMS (SSE-KMS).

Attach the following policy;

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::ACCOUNT:user/tf-user"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::fisontech-tfstate"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::ACCOUNT:user/tf-user"
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::fisontech-tfstate/*"
        }
    ]
}

The policy on the bucket allows your IAM user access to the state folder you'll be creating later.

Create a role witin IAM, call it something like tf-user, give it admin permissions (this isnt production dont worry).

If you want to be more linear with permissions then pick atleast S3 and DynamoDB, but as this role will likely be creating EC2s, VPCs etc then you will probably make do with AWSAdministratorAccess for now. 

Honestly, it's upto you though - no pressure.

Also inside AWS, now generate AWS credentials for the tf-user, select 3rd party webapp and note the SECRET/PASS down.

Go into your git repo, select Settings > Secrets > Actions and add AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY and populate the value with your generated credentials.

Now, this tfuser will be what the CICD pipeline uses to check in/out state files and thus deploy/destroy resources into the AWS environment.

Lastly, you'll need to create a DynamoDB table called for example fisontech-tfstate as this will help with the lock state of the terraform state file. All default settings, key used will be LockID. 

terraform
 - backend
 - main
 - network

Contains all your Terraform components which your local docker container will house.

In backend, you'll need to change the following based on what you created above.

terraform {
  backend "s3" {
    bucket         = "fisontech-tfstate"
    key            = "state/key"
    region         = "eu-west-2"
    dynamodb_table = "fisontech-tfstate"
  }
}

Once you've hit save and synced with your repo, you should see github actions kick off (use the extention to monitor).

The next thing to look at, is how you merge your repos to safeguard the environment.

I would suggest the following;

Create a new branch each time you make a series of changes, i.e;

- git checkout -b production-adding-vpc

You can then 