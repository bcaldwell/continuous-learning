# Gitlab ci ssh keys

Unlike in circleci where you can change the deploy keys used to checkout the repo, in gitlab we must inject our own ssh key.

## Why
- to deploy using ssh 
- to push back to a git repo

## How
- set `SSH_SERVER_HOSTKEYS` to be the hostkey that you want to ssh to
    - `ssh-keyscan ip/url`
- `SSH_PRIVATE_KEY` to be your private ssh key
    - to generate: `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`
        - make sure to not set a passphrase
- make sure you public is added to where you are trying to ssh to

``` yaml
before_script:
  # Install ssh-agent if not already installed, it is required by Docker.
  # (change apt-get to yum if you use a CentOS-based image)
  - 'which ssh-agent || ( apt-get update -y && apt-get install openssh-client -y )'

  # Run ssh-agent (inside the build environment)
  - eval $(ssh-agent -s)

  # Add the SSH key stored in SSH_PRIVATE_KEY variable to the agent store
  - ssh-add <(echo "$SSH_PRIVATE_KEY")

*\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config'
  # In order to properly check the server's host key, assuming you created the
  # SSH_SERVER_HOSTKEYS variable previously, uncomment the following two lines
  # instead.
  - mkdir -p ~/.ssh
  - '[[ -f /.dockerenv ]] && echo "$SSH_SERVER_HOSTKEYS" > ~/.ssh/known_hosts'
  ```
  
[source](https://docs.gitlab.com/ee/ci/ssh_keys/README.html)