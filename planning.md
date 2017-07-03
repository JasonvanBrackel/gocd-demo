# CI/CD Fundamentals 

## Introduction

## Intro to Continuous Integration

## Intro to Continuous Deployment

## Intro to GoCD

## Software

### Server
* Controls everything
* Provides the work for agents to do

### Agent
* Does the work

### Plugins
* Contain the various tasks
* No plugin no problem.  Custom Task

## Concepts

### Resources
* Tags on agents representing available features
* Case sensitive
* Jobs are matched to agents based on resources

### Material
* Anything that triggers the pipeline
* * Source check in
* * Manual trigger
* * Artifacts from another pipeline
* * Triggers
* * * Timer Trigger
* * * Source Triggers
* * * Multi-Material Trigger
* * * Pipeline dependency

### Pipeline
* A pipeline represents a the flow of work though GoCD (hesitate to use the term workflow)

### Task 
* A single piece of work
* Can be a command 
* Can also be a plugin.  
* Smallest unit of work from GoCD's perspective
* * Built in tasks for Ant, NAnt and Rake
* * If there's no plugin you can do a Custom Command

### Jobs
* A sequential collecton of tasks
* All tasks in a job run on the same agent
* Create artifacts

### Stages 
* Contain independent Jobs
* Jobs are Non-sequential
* Jobs run in parallel
* Assuming you have enough agents they are started together

### Artifacts
* Test reports
* Coverage reports
* installation files
* Documentation
* Moved from the agent that does the work to the server for storage
* Downstream pipelines can fetch the artifact
* That means if you're dependent on an artifact downstream you're dependent on the stage that creates it
* Core comcept of CD "Only build your artifacts once
* Custom Tab

### Environment
* A pipeline may only exist in 1 environment
* An agent can be associated with 0 - N environments
* Agent can only pickup jobs for enviroments it's associated with
* An agent associated with an environment cannot pick up jobs not associated with an environment


### Value Stream Map
* Representation of pipelines from commit to production
* Highlevel abstraction 
* Parallelization
* Fan Out / Fan In

### Environment Variables
* TODO: Figure out how they work

### Templating
* TODO:
* [Pipeline Templating](https://docs.gocd.org/current/configuration/pipeline_templates.html)

## Configuration as Code

## Pipeline as Code

## Class Setup TODO:
1. Setup Environment
2. Setup Windows Server 2016 with Containers
3. Setup Centos Server with Docker
4. Setup GoCD Server Image
    1. Setup autoregister agents
5. Setup GoCD Linux Image
    1. Setup autoregister
    2. Install firefox, chrome, xvfb
5. Setup Windows Server Container
    1. Setup chrome
    2. Setup Firefox

## Items to consider
### [Artifact Provenance](https://docs.google.com/document/d/1xpTRMuHZC30BfcfmXbGShpfI-4gKpieKHUGv9H8MVXM/view#heading=h.44zmq1i39kyw)




## Pipeline high level steps
* Track Commit - Role, Developer
* Review Commit - Role, Reviewer (Developer)
* * StyleCop
* * Documentation
* version labeling
* Build Step
* label step [Building the Deployable Container](https://docs.google.com/document/d/1xpTRMuHZC30BfcfmXbGShpfI-4gKpieKHUGv9H8MVXM/view#heading=h.ww89y71b9cpe)
* * 
* Security Scan - Role, Security Engineer
* * Trusted Repo
* * Artifact Provenance
* Tagging step [Tagging the deployable container](https://docs.google.com/document/d/1xpTRMuHZC30BfcfmXbGShpfI-4gKpieKHUGv9H8MVXM/view#heading=h.8s0b871z9eyi) 
* Scanning the image
* Transient credentials from a valut for deployment
* Automated Testing
* Manual Testing
* Production Ready Confirmation
[Microservice Pipeline](https://docs.google.com/document/d/1xpTRMuHZC30BfcfmXbGShpfI-4gKpieKHUGv9H8MVXM/view#heading=h.q675yf55103)
[Deployment Pipeline](https://docs.google.com/document/d/1xpTRMuHZC30BfcfmXbGShpfI-4gKpieKHUGv9H8MVXM/view#heading=h.kruo4z9amh06)