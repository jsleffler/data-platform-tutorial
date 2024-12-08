# Terraform

## Setup

We will start with Terraform with the basic objective on push to main (or merge) it will deploy and create our infrastructure. We will use GitHub Actions to do this, we will also aim to make an empty dataset within GCP BigQuery.

Follow the Terraform setup for [your OS](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli?in=terraform%2Fgcp-get-started). Once installed will will follow other tutorials to the point we can create the dataset in BigQuery from the CLI. This is contrary to above, but this is the best way to get setup and start working; if doing this for a real project, I would suggest creating a temporary project and deleting it after.

Ask you local AI copilot to help setup your boilerplate Terraform files, or follow the online tutorials. I wont dive into this as it is well documented and you can find it for yourself and dig deep into the areas you need to.

## BigQuery Dataset

To help here is a some boilerplate code for a dataset in BigQuery (API doc for [google_bigquery_dataset](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset)):

```hcl
resource "google_bigquery_dataset" "dataset" {
  dataset_id    = "iac_dataset_1"
  friendly_name = "IaC Dataset 1"
  description   = "Dataset created by IaC, it is the first one, assuming there might be more. It will remain here for a while as a test of the IaC, a walking skeleton."
  location      = var.location
  project       = var.project_id

  labels = {
    env = "dev"
  }
}
```

> Note: I suggest you look into [variables for Terraform](https://developer.hashicorp.com/terraform/language/values/variables) and how to use them, this will help you keep your code DRY and make it more flexible. I will be using this from now on, and find ways to load specific variables into the GH Actions workflow based on my targets, when I branch this to use a staging env.

In future steps we will setup and change access, labels and more. But for now, lets get this working.

## CLI Deploy

As mentioned before, this is contrary to our main objective; we will use the CLI to deploy the dataset to BigQuery. This is because we need to setup the service account and permissions, and this is best learnt and done via the CLI.

Following along on the tutorial (and skipping the bits we don't want) we found this section about [creating the credentials](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#adding-credentials) we need to use the CLI and Terraform. We will follow this. I heavily suggest you create service accounts that are very specific to the task you need and have a very clear name and description. In this case, I will be making a local CLI service account for myself, later I will make another that is specific to GH Actions.

Asking my local loveable AI copilot about what roles are needed, I have added the following roles to my service account:

* Viewer
* BigQuery Admin
* Storage Admin

Then go on to create and download the JSON key. To make life easier (and not reading ahead) I have moved the JSON from my downloads to a `.secret` folder and added this to the `.gitignore` file. I have also created a `.env` file when I will configure the `GOOGLE_APPLICATION_CREDENTIALS` variable to point to the JSON key. I will also add the `.env` file to the `.gitignore` file. Your shell may allow you to load a .env file, if not you can use the `source` command to load it.

Now we can run the `terraform init` command and see what breaks! And if nothing breaks, we should see our Dataset inside BigQuery.

> Note: I have started a directory structure where all the Terraform/IaC code will be in a folder called `terraform`. So we will work in that directory for now.

If that has run well for you, then lets apply it and see what happens...
Again, if all this works for you, try `terraform destroy` and see if it removes the dataset.

Great, will all this sorted, lets commit our code so far and get our repo into a state where we can start using GitHub Actions. Don't forget to add the Terraform state directory to the `.gitignore` file.

## Talking Points

* What is Infrastructure as Code (IaC)?
* What is the evolution of IaC and where did it come from, what are the key technologies that created it (tip: virtualisation, cloud)?
* What is the difference between some of the key IaC tools (Terraform, CloudFormation)?
* What is the difference between IaC and Configuration Management (e.g. Ansible, Puppet)?
* Can you use Terraform to build a multi-cloud environment?

<!-- Abbr -->

*[GCP]: Google Compute Platform
*[CLI]: Command Line Interface
*[OS]: Operating System
*[IaC]: Infrastructure as Code
*[JSON]: JaveScript Object Notation
*[GH]: GitHub
