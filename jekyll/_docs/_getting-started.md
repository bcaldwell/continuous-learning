<!--getting started page. Included from index.html. Note it is also ignored in _config.yml --> 
 
devctl is an open source command line interface (CLI) aimed towards developers
and enables them to manage their development environments across different
projects. Currently devctl only supports `zsh`.

devctl is entirely open source and available on github. The application is
written in Golang and utilizes bash to modify the user's terminal session in
order to achieve some of its functions. Further details regarding contribution
are available on Github. Patches are welcome!

# Installation
## Installing devctl
To install devctl use the provided​ installer script.

```sh
curl -o- https://raw.githubusercontent.com/devctl/devctl/master/install.sh | bash
```

## Creating .devctlconfig
In order to setup and use devctl, you need to create a config file in `$HOME`
called .devctlconfig . 

```sh
# REQUIRED FIELDS
github_user = user # devctl defaults to github when using commands like clone
and thus requires this information
source_dir = src # devctl follows the directory sturcture used by Golang and
needs to provided the location of the 'src' directory

# OPTIONAL FIELDS
gitlab_user = user # devctl will use this when cloning from gitlab repositories.
If this is not provided, devtcl will use github_user
gitlab_url = url # not sure
```
