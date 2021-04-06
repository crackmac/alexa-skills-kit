## New skill

Before working through this example ensure that you've registered for an [Alexa Developer](https://developer.amazon.com/alexa) account.

### Pull docker image

```bash
> docker pull docker.moviesanywhere.io/alexa/docker-alexa-skill-kit:v2-22-4
```

### Create the folder structure

```bash
> cd ~
> mkdir alexa-demo \
  alexa-demo/ask-config \
  alexa-demo/aws-config \
  alexa-demo/app
> cd alexa-demo
```

### Create an alias to simply the docker run command

```bash
> alias alexa="docker run -it --rm \
   -v $(pwd)/ask-config:/home/node/.ask \
   -v $(pwd)/aws-config:/home/node/.aws \
   -v $(pwd)/app:/home/node/app \
   docker.moviesanywhere.io/alexa/docker-alexa-skill-kit:v2-22-4 "
```

## Verify things work by checking tool versions

```bash
> alexa aws --version
    aws-cli/1.18.89 Python/2.7.18 Linux/4.19.76-linuxkit botocore/1.17.12

> alexa ask --version
    2.22.4

> alexa node --version
    v12.18.4
```

### Configure the ASK utility

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
