# etherimt_prototype

Prototype of using Ethermint.

# Overview

Ethermint is a re-implementation of the Ethereum Virtual Machine (EVM) on Tendermint using the Cosmos-SDK.  ChainSafe is the current maintainers of the Ethermint project and our builds systems will use a forked build from them which can be found [here](https://github.com/starcard-org/ethermint).

The goal of the project is to create a local development environment with a sample Application that talks to Ethermint.  This will happen in 3 stages:

* Local development environment using Docker
* Remote deployment hosting local ethermint deployments (basically the local environment but on the cloud)
* Remote deployment of Application server using Cosmos deployed Ethermint chain nodes

To show off the integration this application will be creating a marketplace for ERC-721 objects.  Basically it will be an E-Bay like system where people can make bids on an item and once a time has expired the item is transferred to the highest bidder.

# Software Requirements

The following is a list of local software you will need to have installed to run this project.

## Local Software 

* Python 3.6
* Ansible 2.9
* Docker for Desktop 

## Application Server

Note: The system will do a containerized build so these packages are ONLY required if you want to build/run the code locally on your host OS.  This can be useful for some debugging and performance profile but should be considered the exception, not the norm for development.  For all other builds refer to [Building the Project](#Building-the-Project)

* Elixir 1.9.4
* Erlang/OTP 22
* Docker for Desktop

### Operating Systems

This system should work for the following OS but not all of them are fully tested.  It is assumed that the user knows how to setup docker to NOT use sudo based permissions.  For help check out [here](https://docs.docker.com/install/linux/linux-postinstall/) for Linux based OS.

* MacOS - Up to the reader to figure out how to get Docker Desktop and Docker commands to work without `sudo`
* Windows 10 - Tested with Windows Subsystem for Linux 2 (WSL2).  Should work with WSL.  Not test on standard Windows environment.
* Ubuntu 18.04 LTS - Tested and works 

# Building the Project

## Environment Setup

First you need to install all the needed Ansible and dependant Libraries.  This can be done by running the command: 

`./ops --setup_local`

in the root fold of the project.  This setup assume that you have Python installed and will install all additional packages via the `pip` in the user storage.  After the command has run make sure you add `~/.local/bin` to your `$PATH` (typical via the .bashrc, .zshrc, etc depending on your shell of choice).

NOTE:

This command may fail depending on order of operations and what packages you may already have installed.  If it fails the first time you run it just try running it a second time.  If it fails a second time then please submit a github issue for help.


## Building Images for Local Deployment [WIP]

Now that your environment is setup we need to build it.  This is done by running the command:

`./ops --build_local`

This will build all software and create a docker image for each needed service.  This command should create the following images on your local docker:

* forte/ethermint_chain:latest - A docker image of an ethermint chain code. 
* forte/ethermint_client:latest - Client REST access for Web3 communication with the ethermint_chain image.
* forte/marketplace:latest - A build of the marketplace prototype application.
* forte/bots:latest - A testing application that will run a bunch of integration testing scenarios and generate load.
* forte/local_builder:latest - A build image used to compile and create the forte/marketplace image.

## Working in the Code Base [WIP]

If you are doing actual feature work (adding new system or expanding tests, etc) you will need to compile your code to ensure that everything works fine.  To do this you have two options:

* Install all the needed software locally on your host machine
* Use Docker to compile your code

### Local Host Development

* Elixir 1.9.6
* Erlang 22

#### Build Application Code Locally

`./ops --app_dev`

#### Build Bot Code Locally

`./ops --bot_dev`

#### Unit Test Code Locally

`./ops --unit_test_dev`

#### Integration Test Code Locally

`./ops --user_test_dev`

### Docker Host Development

This will build the application server and if successful will create a new docker image.  For testing you can just run the Unit test based operations like normal

#### Build Application Code on Docker

`./ops --app_local`

#### Build Bot Code on Docker

`./ops --bot_local`

## Unit Testing [WIP]

Now that your system has been built lets run some unit test to ensure everything is working correctly.

`./ops --unit_test_local`

This operation will run the current images created and run unit tests on them.  It will locally deploy needed containers to execute the unit tests and will then release these resources once the tests are completed.

NOTE:

For the application server it will run the unit tests inside the `forte/local_builder:latest` container so it is not testing the actual marketplace image.  That will be done in the integration testing command

## Integration Testing [WIP]

While unit tests are great and help ensure that all the individual components work correctly, they don't really do a good job of testing scenario that are more complex or uses multiple systems at the same time.  This is what Integration testing will do for us.  This will launch a testing environment in your local docker system and then run the specialized container `forte/bots` which will test multiple user stories and use-cases.  It will also do this at higher load in order to ensure that both for functional completeness as well as load.

`./ops --user_test_local`

NOTE:

Testing this command should be thought of more in the frame of local performance testing and use-case correctness.  If you have good performance in a local environment that does NOT mean the code is ready for production and the performance profile seen locally will extend to a remote environment.  This is only one tool in the box to help get you to production ready.

# Remote Deployments [WIP]

What is needed to deploy this system remotely and 

## Create a Credentials Config

Create a Credentials Config
    * Info need to use GCP

## Publishing a Build [WIP]

Publish the images up to the cloud for usage

`./ops --publish /path/to/config`

## List deployments [WIP]

Returns a list of deployments:

`./ops --list /path/to/credentials`

## Deploy a Build [WIP]

Deploy a remote environment to GCP.

Steps needed:

* Create a Deployment Config for the deployment with needed info
    * Path to credentials file
    * Define Hardware requirements
    * Define Alerting policies and info

`./ops --deploy /path/to/config`

## Validate a deployment is up and working [WIP]

Test the deployment on the Remote Machine.  This will basically run the bot tests on the remote deployment.

`./ops --validate /path/to/config`

## Modify a deployment spec [WIP]

Modify the deployment config file.

`./ops --update /path/to/config`

## Release a deployment [WIP]

Releases the resources used on the cloud

`./ops --release /path/to/config`
