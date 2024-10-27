# Data Platform - A Learning & Tutorial Repository

This repository will be an example data platform using specific technologies and cloud platforms. It is intended to be a place of learning and exploration for the author and anyone else.

## Overview

A Data Platform is a collection of technologies and services that enable the collection, storage, processing, and analysis of data. The platform is designed to be scalable, reliable, and secure. The platform is designed to be flexible and extensible to meet the needs of the organization.

This repository will provide code and tooling to build a data platform using Infrastructure as Code (IaC) and DevOps practices, CI/CD. It will also provide examples of data ingestion, transformation and modelling. The scope is somewhat limited to that of a small to medium sized organization and the role of a Data Engineer; therefore data analysis, visualization and machine learning are not in scope.

## Technologies & Concepts

* Google Cloud Platform (GCP)
* Terraform (IaC)
* GitHub Actions (CI/CD)
* Apache Airflow (Data Orchestration)
* dbt (Data Transformation)
* BigQuery (Data Warehouse)

## Getting Started

Note, I expect you to be able to find some things on your own, I am not going to hand hold you though all the basics, including making sure you don't spend money on GCP.

### Install

Install the following tools on your local machine and have them available. Follow the guides for your OS and IDE.

* [Terraform](https://www.terraform.io/downloads.html)
* [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
* [Taskfile](https://taskfile.dev/#/installation)

### GCP Setup

You will we need a GCP account, we will do this very very basically so do not follow this for advice on security etc.

Go to [GCP](https://cloud.google.com/) and "Start for free" and follow the instructions. You will need to provide a credit card but you will not be charged unless you upgrade to a paid account.

Best to create a new project for this work, you can do this in the GCP console.

### Git Setup

You will need a GitHub account and then create a repository for this work. Since we intend to use CI/CD and IaC, we will not be using the CLI or the GCP console to create resources, etc. We will only use if we really have to or explore.

Create an empty repo and add what you want to a README.md, commit it and create you main branch etc.
