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