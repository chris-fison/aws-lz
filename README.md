# Welcome to my AWS-LZ

## An AWS Landing Zone Project

A great launchpad for anyone wanting to DevOps their TF code and make life a bit easier.

I wanted to learn more about the DevOps lifecycle of how to manage IaC utilizing automation where possible.

As time goes on I'll be further developing this git, as I learn and improve.

## What does this git include?

- Containerized local Docker with full Terraform, AWS CLI and various other extensions to help keep your team aligned. Fully integrated into Visual Studio Code.
- A CICD pipeline which will spin up a container which will use a IAM role in AWS to create Terraform resources, it'll also store Terraform state in S3 and utilize DynamoDB for LockIDs.
- An example of a resource (VPC) deployed as part of the terraform code.

## How much does this cost?

I doubt very much, things to think about;

GitHub Repo - Free.
GitHub Actions - Free up-to a certain amount of X minutes/runs, generally as TF code is quick to run (depending on scale), you shouldn't hit your Free limit.
Docker - Free to install and run locally, for what we need this for its fine.
AWS Account - Free (CC is required for sign-up).
- S3 costs pence to run, very minimal.
- DynamoDB costs a little bit more, very minimal though.
- Resources, only VPCs are deployed for the example.

Generally advisable though to set a monthly budget on your AWS account, just incase.

A couple boring costing links;

- https://calculator.aws/
- https://docs.aws.amazon.com/cost-management/latest/userguide/budgets-create.html

## How to get started?

### Pre-Reqs

You'll need to perform the following on your system to get the best of this repo, mainly as nothing will work if you don't.

**System BIOS**

 - Enable VRT Virtualization in BIOS, else Docker will cry when you try running it later, this will save you an hour or so on stackoverflow I guarantee you.

You can find out how to get into your BIOS by using a popular search engine, generally once you know the F key, you'll reboot and spam that key until you reach the BIOS screen.

**Windows Terminal**

Copy/paste the following into the terminal, it'll do stuff.

```
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Docker.DockerDesktop
winget install -e --id Git.Git
winget install -e --id GitHub.cli
mkdir C:\Git\Projects
sl C:\Git\Projects
git clone https://github.com/chris-fison/aws-lz.git
. code
```

**Visual Studio Code**


Copy paste the following into VSC, it'll do more stuff.

```
code --install-extension ms-vscode-remote.remote-containers
git checkout -b production
```

You'll at this point probably want to get the cloned git up to your own git repo, once done read the rest of the documentation below as theres further configuration needed and I explain what things do.

### Ok, so what did I just do and what am I looking at?

Firstly, quickly lets get Docker building before we do;

In VSC, assuming you followed the pre-reqs step, you'll see a prompt to re-open in container, if you don't then press ctrl+shift+P and select re-open in container, it should use the files in .devcontainer.

It'll take a couple minutes depending on what spec of potato you're running this all on.

Whilst thats cooking, let me go through the folder structure of what you should see in VSC.

**.devcontainer**

 - devcontainer.json 
 - dockerfile
 - post-start.sh

This contains all your Docker components which your local system will use to build out the container.

You can modify the extensions if you don't need them, but the idea is your team would use this docker configuration and thus the same extensions, so everyone is using the same version of terraform etc.

A few standouts here are formatting code when saved, such as correct indentation, or 'rainbow' indentation so its easier to see, handy for JSON, theres also a TODO so easier to work as teams on issues. 

Once you've built the container you can use the filter @installed to see what's there, and remove what you don't need, but each time to rebuild a container it'll re-add so remove from .json if needed.

**.github**

 - terraform.yml

This contains all your github action components which your git account will use to build out its container to run Terraform code.

To put it simply, this will be your CICD pipeline which activates on activity on the production branch, in the terraform folder - this is more so the action wont run when you change anything outside the folder, else its annoying.

The solution will require an S3, DynamoDB and IAM user you'll create below.

You'll need to create an S3 bucket within your AWS tenant, all default settings, enable versioning and SSE AWS KMS (SSE-KMS).

Attach the following policy;

```
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
```

The policy on the bucket allows your IAM user access to the state folder you'll be creating later.

Create a role within IAM, call it something like tf-user, give it admin permissions (this isn't production don't worry).

If you want to be more linear with permissions then pick at least S3 and DynamoDB, but as this role will likely be creating EC2s, VPCs etc then you will probably make do with AWSAdministratorAccess for now. 

Honestly, it's up to you though - no pressure.

Also inside AWS, now generate AWS credentials for the tf-user, select 3rd party webapp and note the SECRET/PASS down.

Go into your git repo, select Settings > Secrets > Actions and add AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY and populate the value with your generated credentials.

Now, this tfuser will be what the CICD pipeline uses to check in/out state files and thus deploy/destroy resources into the AWS environment.

Lastly, you'll need to create a DynamoDB table called for example fisontech-tfstate as this will help with the lock state of the terraform state file. All default settings, key used will be LockID. 


**terraform**

 - backend
 - main
 - network

Contains all your Terraform components which your local docker container will house.

In backend, you'll need to change the following based on what you created above.

```
terraform {
  backend "s3" {
    bucket         = "fisontech-tfstate"
    key            = "state/key"
    region         = "eu-west-2"
    dynamodb_table = "fisontech-tfstate"
  }
}
```


Once you've hit save and synced with your repo, you should see github actions kick off (use the extension to monitor).

### Closing Notes

The next thing to look at, is how you merge your repos to safeguard the environment.

I would suggest the following;

Create a new branch each time you make a series of changes, i.e;

```
git checkout -b production-adding-vpc
```

Then pull that branch into the production branch, so rather than always working on the production branch, you branch off it and then make your changes (i.e adding a VPC), then you merge them into production and someone approves and merges.

Start the cycle over, create a new branch using same command (changing vpc) and repeat the process.

Cheers!

Reference articles here; tbc