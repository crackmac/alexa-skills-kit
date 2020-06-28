# docker-amazon-ask-cli

The purpose of this container is to be able to use the [Amazon ASK CLI (Alexa Skills Kit)](https://developer.amazon.com/docs/smapi/ask-cli-intro.html#alexa-skills-kit-command-line-interface-ask-cli).

<!-- TOC -->

- [docker-amazon-ask-cli](#docker-amazon-ask-cli)
  - [Example](#example)

<!-- /TOC -->

## Example

This example will show you both how to use this container and start a simple `HelloWorld` Alexa Skill. In this example we'll assume that AWS has been configured [see below](#aws-config-optional). 

Please read the other sections on how to properly use this container and volume configurations. Before running this example ensure that you've registered for an [Alexa Developer](https://developer.amazon.com/alexa) account


```bash
# Get image
docker pull registry.gitlab.com/crackmac/amazon-ask-cli

# Create a ASK configuration folders.
cd ~
mkdir alexa-demo \
  alexa-demo/ask-config \
  alexa-demo/ask-config \
  alexa-demo/app
cd alexa-demo

# Note copy the aws-config information (see below) to the aws-config folder

# To help simply writing out a full docker run command each time will use an alias
alias alexa="docker run -it --rm \
  -v $(pwd)/ask-config:/home/node/.ask \
  -v $(pwd)/aws-config:/home/node/.aws \
  -v $(pwd)/app:/home/node/app \
  registry.gitlab.com/crackmac/docker-amazon-ask-cli/master:latest "

# Configure ASK
alexa ask configure --no-browser

    This command will configure the ASK CLI with a profile associated with your Amazon developer credentials.
    ------------------------- Step 1 of 2 : ASK CLI Configuration -------------------------
    [Warn]: ASK CLI uses authorization code to fetch LWA tokens. Do not share neither your authorization code nor access tokens.
    Paste the following url to your browser:
        https://www.amazon.com/ap/yaddayaddayaddaask-cli-no-browser.html
    ? Please enter the Authorization Code:  ANTgeVLdNYhHOCGdlkJo
    ASK Profile "default" was successfully created. The details are recorded in ask-cli config file (.ask/cli_config) located at your **HOME** folder.
    Vendor ID set as MQOXXXXXXE85.

    ------------------------- Step 2 of 2 : Associate an AWS Profile with ASK CLI -------------------------
    [Warn]: ASK CLI will create an IAM user and generate corresponding access key id and secret access key. Do not share neither of them.
    ? Do you want to link your AWS account in order to host your Alexa skills? Yes

    Complete the IAM user creation with required permissions from the AWS console, then come back to the terminal.
    Please open the following url in your browser:
        https://console.aws.amazon.com/iam/home?region=undefined#/users$new?accessKey=true&step=review&userNames=ask-cli-askclidefault&permissionTXXXXXXy%2FAWSLambdaFullAccess

    Please fill in the "Access Key ID" and "Secret Access Key" from the IAM user creation final page.
    ? AWS Access Key ID:  AKIAXXXXXXXABN7PAQ
    ? AWS Secret Access Key:  [hidden]

    AWS profile "ask_cli_default" was successfully created. The details are recorded in aws credentials file (.aws/credentials) located at your **HOME** folder.
    AWS profile "ask_cli_default" was successfully associated with your ASK profile "default".

    ------------------------- Configuration Complete -------------------------
    Here is the summary for the profile setup: 
    ASK Profile: default
    AWS Profile: ask_cli_default
    Vendor ID: MQXXXXXXE85

# Create a new app:
alexa ask new 
    Please follow the wizard to start your Alexa skill project ->
    ? Choose the programming language you will use to code your skill:  NodeJS
    ? Choose a method to host your skill's backend resources:  AWS Lambda
      Host your skill code on AWS Lambda (requires AWS account).
    ? Choose a template to start with:  Hello world             Alexa's hello world skill to send the greetings to the world!
    ? Please type in your skill name:  skill-sample-nodejs-hello-world
    ? Please type in your folder name for the skill project (alphanumeric):  app
    Project for skill "skill-sample-nodejs-hello-world" is successfully created at /home/node/app/app

    Project initialized with deploy delegate "@ask-cli/lambda-deployer" successfully.


# Move the HellowWorld folder back to app directory
cd app/
mv hello-world/* .
mv hello-world/.* .
rmdir hello-world

# Deploy (all): this will create both lambda and Alexa Skill
alexa ask deploy

# -------------------- Create Skill Project --------------------
# Profile for the deployment: [default]
# Skill Id: amzn1.ask.skill.55cb6762-4b48-433f-adef-2d6074d06c13
# Skill deployment finished.
# Model deployment finished.
# Lambda deployment finished.
# Your skill is now deployed and enabled in the development stage.
# Try invoking the skill by saying “Alexa, open {your_skill_invocation_name}” or simulate an invocation via the `ask simulate` command.


# Other command options are:
alexa ask deploy -t lambda
alexa ask deploy -t skill
alexa ask deploy -t model
