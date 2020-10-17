# alexa-skill-kit-cli

The purpose of this container is to simplify the use of [Amazon ASK CLI (Alexa Skills Kit)](https://developer.amazon.com/docs/smapi/ask-cli-intro.html#alexa-skills-kit-command-line-interface-ask-cli) in containerized workflows.

This document will walk you through how to use the ASK CLI container to create and deploy a simple `HelloWorld` Alexa Skill. Before working through this example ensure that you've registered for an [Alexa Developer](https://developer.amazon.com/alexa) account.

## New skill

### Get docker image

```bash
> docker pull registry.gitlab.com/crackmac/alexa-skill-kit-cli/master:latest
```

### Create a ASK configuration folders

```bash
> cd ~
> mkdir alexa-demo \
  alexa-demo/ask-config \
  alexa-demo/aws-config \
  alexa-demo/app
> cd alexa-demo
```

### To help simply writing out a full docker run command each time will use an alias

```bash
> alias alexa="docker run -it --rm \
   -v $(pwd)/ask-config:/home/node/.ask \
   -v $(pwd)/aws-config:/home/node/.aws \
   -v $(pwd)/app:/home/node/app \
   crackmac/alexa-skills-kit:2.16.4 "
```

## Verify things work by checking tool versions

```bash
> alexa aws --version
    aws-cli/1.18.89 Python/2.7.18 Linux/4.19.76-linuxkit botocore/1.17.12

> alexa ask --version
    2.16.4

> alexa node --version
    v12.18.4
```

### Configure ASK

```bash
> alexa ask configure --no-browser

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
```

### Create a new skill

```bash
> alexa ask new
    Please follow the wizard to start your Alexa skill project ->
    ? Choose the programming language you will use to code your skill:  NodeJS
    ? Choose a method to host your skill's backend resources:  AWS Lambda
      Host your skill code on AWS Lambda (requires AWS account).
    ? Choose a template to start with:  Hello world             Alexa's hello world skill to send the greetings to the world!
    ? Please type in your skill name:  skill-sample-nodejs-hello-world
    ? Please type in your folder name for the skill project (alphanumeric):  app
    Project for skill "skill-sample-nodejs-hello-world" is successfully created at /home/node/app/app

    Project initialized with deploy delegate "@ask-cli/lambda-deployer" successfully.
```

### !! VERY IMPORTANT: You must move all the files and folders from the HellowWorld folder into to app working directory. This is anoying and we'll try and improve this in future releases

```bash
cd app/
mv hello-world/* .
mv hello-world/.* .
rmdir hello-world
```

### Deploy (all): this will create both lambda and Alexa Skill

```bash
alexa ask deploy

    -------------------- Create Skill Project --------------------
    Profile for the deployment: [default]
    Skill Id: amzn1.ask.skill.55cb6762-4b48-433f-adef-2d6074d06c13
    Skill deployment finished.
    Model deployment finished.
    Lambda deployment finished.
    Your skill is now deployed and enabled in the development stage.
    Try invoking the skill by saying “Alexa, open {your_skill_invocation_name}” or simulate an invocation via the `ask simulate` command.
```

## Existing Skills

### Initialize with 'ask init'

```bash
> alexa ask init

    This utility will walk you through creating an ask-resources.json file to help deploy
    your skill. This only covers the most common attributes and will suggest sensible
    defaults using AWS Lambda as your endpoint.

    This command is supposed to be running at the root of your ask-cli project, with the
    Alexa skill package and AWS Lambda code downloaded already.
    - Use "ask smapi export-package" to download the skill package.
    - Move your Lambda code into this folder depending on how you manage the code. It can
    be downloaded from AWS console, or git-cloned if you use git to control version.

    This will utilize your 'default' ASK profile. Run with "--profile" to specify a
    different profile.

    Press ^C at any time to quit.

    ? Skill Id (leave empty to create one):
    ? Skill package path:  ./skill-package
    ? Lambda code path for default region (leave empty to not deploy Lambda):  ./lambda
    ? Use AWS CloudFormation to deploy Lambda?  Yes
    ? Lambda runtime:  nodejs10.x
    ? Lambda handler:  index.handler
```

### Deploy existing (all): this will create both lambda and Alexa Skill

```bash
> alexa ask deploy
```

### Other command options

```bash
> alexa ask deploy -t lambda
> alexa ask deploy -t skill
> alexa ask deploy -t model
```
