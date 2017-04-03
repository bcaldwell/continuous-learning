# Helm

- a tool to manage a group of resources as one unit
- gives you package of components that you can easily manage in the cluster
- people have created charts for common software

## Charts
- package are called charts
- define an application
    - meta data
    - kubernetes resource defination
    - documentation
- live in a chart repository

## Tiller
- in-cluster component
- lives inside the cluster as a pod
- manages releases
    - release = installation of a kubernetes chart


<!---
```diagram
 graph LR
     subgraph Kubernetes
     Tiler
     end
     subgraph Outside
     A["Helm Client"]
     end
     A-\->Tiler
```
--->
<img src='http://gitcdn.bcaldwell.ca/images/diatex/diagram/50ae4e485764dcbff25a4c89c3fddd28.png' alt='diagram image' width='100%'>


## Basic usage
`helm init`: sets up local environment and install teller

`helm search`: search repositories for keyboard

`helm install [chart]`: installs chart to cluster

`helm list`: lists currently installed charts

`helm status`: details about a release

`helm upgrade [release name][chart]`: update chart

`helm delete release`: deletes a release

## Create a chart
`helm create [app name]` creates a new chart. Generates the following files:
- myapp
    - Chart.yaml
    - README.md
    - charts
        - mariabd-0.5.2.tgz 
    - templates
        - deployment.yaml
        - svc.yaml
        - NOTES.txt
    - values.yaml
    - (requirements.yaml)

templates are go templates and use values from values.yaml

override values from values.yaml:

- `helm install —set nested.key=valye ./myapp`
- `helm install -f myvalues.yaml ./myapp`

### Dependencies
- dependencies go in charts folder
- `helm dependencies update` install dependencies from requirements.yaml

### Docs
- README.md
    - what is the chart?
    - configuration otpions
- NOTES.txt
    - notes printed after deploy
    - post deploy information

### Metadata
- Chart.yaml 
    - contains a version field

## Chart Repositories
- an basic http server that contains an index.yaml file
- `helm repo add repo_name charts.repo.com`
- `helm install repo_name/myapp`

## Best practices
- it works out of the box
- split out dependencies
- don't repeat yourself (go partial)
- be reproducible
- configurable

## Design goals
- get started quickly with existing charts
- build your own charts and easily share them
- manage application lifecycle over time
    - be able to install chart multiple times
- fit releases to your existing tools and process
- let the cluster be the collaborative centre for your team
