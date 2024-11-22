# GitHub Actions

GitHub Actions is a way of apply CI/CD to your repository. It allows you to automate your workflow and build, test, and deploy your code directly from GitHub. This can be done in a large number of ways and you don't need to use GitHub Actions, its just easy for this tutorial.

We will work with the concept of branching and pull requests. We will create a new branch, make some changes, and then create a pull request to merge the changes back into the main branch. This means we will have a workflow that will run every time a pull request is created. This workflow will run the tests and check the code style of the changes. If the tests pass and the code style is correct, the pull request can be merged. As we design our workflows we will consider what actions are best done in a PR and what we should wait until main is updated. The objective of PR based actions is to inform you (the developer) and your colleagues (reviewers) of any immediate issues with the code. You may not get a review of your code until the PR actions all pass.

One thing to remember, GitHub Actions and other CI/CD tools just run commands that you can run locally. Just these are automatic and can take on variables, cache data, and run in parallel. All done in an effort to make your life easier and get your code into production fast and safely.

## Key Concepts

These are mostly my opinions and I have not yet read the most recent best practice for GitHub Actions and more common CI/CD.

* An action should be atomic, single purpose, and easy to understand.
* Actions are composable and can be reused and added into specific workflows.
* Workflows (and actions) should target specific files and only be run if they are needed (e.g. if there are changes)
* Actions should produce a result that is very clear, either pass or fail.
* Actions should be fast and not take up too many resources.
* Actions should be idempotent, meaning they can be run multiple times without changing the result.
* Actions should be tested and have a clear way to test them.
* Actions should generate an output or log that can be reviewed.
* Actions should generate a summary that can be used to quickly take action, especially if they fail.

## Setting up GitHub Actions

For now, we wont be making branches etc to get started, we want to see how GitHub Actions works. We will create a new file in the `.github/workflows` directory. This is where GitHub Actions will look for workflows to run. We will create a simple workflow that will run when a commit is made to `main`.

This approach is great for getting started, if working with existing code, be careful and seek advise on how best to add, update, or remove workflows.

Also, this is kinda like a walking skeleton, an approach to build the foundations of a system before adding in all the complexity. Specifically, we are looking to get a finite simple concept into production. We will do this very simply and as we add complexity (e.g. a staging environment) we can build upon the solid foundations we make here.

## First Workflow, off Main

So we want to create a workflow that will run when a commit is made to `main`. We will create a new file in the `.github/workflows` directory. This is where GitHub Actions will look for workflows to run. We will create a simple workflow that will run when a commit is made to `main`. Have a look here for the start of the documentation: [GitHub Actions Documentation](https://docs.github.com/en/actions)

So we create a new file:

```bash
mkdir -p .github/workflows
touch .github/workflows/skeleton.yml
```

We are using `skeleton` here as we have not taken the time to design a workflow that will be useful. We will just get something running and then we can build upon it.

Be aware, we will quickly start using other peoples code, like in all things development, reuse is key. We will use the `actions/checkout` action to get the code from the repository. This is a very common action and is used in most workflows. Review the documentation to identify the workflows that are available and managed by other people, apply your usual due diligence when doing this, find actions that are well maintained and perhaps have a well known owner.

* We will make 3 jobs, with one or two steps each.
* The workflow will run only on push to main, we will test this by creating another branch and see if it runs.
* Job 1 will need to wait for another job to finish
* Only 1 job needs to checkout the code using a common action
* All jobs should echo/output a message
* The job, job 1 is dependent on should have a wait time so we can see the delay of the dependency

When we commit the `yaml` file and push to GitHub, we can start to see the workflow run within the Actions tab of the repository. Work through any issues you have (I had a few!) and get the workflow moving. There are nice visualisations so you can see how things connect. If you want, add a bunch more jobs and steps to create a more complex workflow which uses dependencies more to see how it can all come together.

Now its working, lets test it. Our only real thing to test is that it only runs on commits to `main`. Since a PR merge is a commit, this is not really applicable. So just make a new branch and commit a few things and see if the workflow runs in the GitHub Actions tab.

Now merge your branch into `main` via a PR and see if the workflow runs.

```yaml
# This is a skeleton workflow to get the idea of workflows and actions

name: Skeleton Workflow
run-name: Skeleton workflow, triggered by ${{ github.event_name }} event by ${{ github.actor }}.

# Set the triggers
on:
  push:
    branches:
      - main

jobs:
  job1:
    runs-on: ubuntu-latest
    needs: [job2]
    steps:
      - name: Checkout the code
        uses: actions/checkout@v4
      - name: Run a script
        run: echo "Hello from job 1"
  job2:
    runs-on: ubuntu-latest
    steps:
      - name: Run a script
        run: echo "Hello from job 2"
      - name: Wait for 5 seconds
        run: sleep 5
  job3:
    runs-on: ubuntu-latest
    steps:
      - name: Run a script
        run: echo "Hello from job 3"

```

## Deploy our Docs

Now we want to do something a bit more realistic and add to our filters. So we will create a workflow, and associated actions, to publish our documentation `./docs` to GitHub Pages. This is very useful and helps render our docs in a nice way for others to see what we are all about. The workflow will only run on push to `main` and if there are any changes within the `./docs` directory.

To do this, we will use a template workflow from GitHub Actions. Go to Actions and "Add workflow", from there browse about, find the docs and select which one is most interesting to you. I used `mkdocs` for my setup as I like this tools, the themes (readthedocs) and the configuration. I did some custom setup, but you can just use the template and get going. I did it custom as I started to get errors, the problem was with my Github config for pages, not the pipeline.

## Next Ideas

Not right now, but as we move forward we will be adding some more workflows and actions. Below are some ideas, not to overwhelm you, but to give you an idea of what is possible and the depth of work that can go into this area. All done in an effort to make your life easier and get your code into production fast and safely.

* Have actions block/stop workflows
* Creating our own actions and connecting to workflows (e.g. in different files)
* Using secrets and environment variables
* Using caching and artifacts
* Creating our own base images and using those to improve performance (e.g. everything already installed)
* Working with a staging environment and deploying to that
* Creating more workflows for specific areas (Terraform, DBT, Airflow, etc)
* Automatic rollbacks from deployments

## Talking Points

* Explore some of the configurations for the out of the box (OOTB) actions, what can you do with them?
* What are the best practices for GitHub Actions in your organisation or group?
* How to design a workflow that is fast and efficient?
* What can you cache and what should you not cache?

## References

* [GitHub Actions Documentation](https://docs.github.com/en/actions)
* [GitHub Workflows Quick Start](https://docs.github.com/en/actions/quickstart)
* [GitHub Environment Variables Defaults](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/store-information-in-variables#default-environment-variables)
* [GitHub Context Variables](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs)