# Gitlab runner in Kubernetes

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


## Getting a runner token
Since we want to run gitlab runner in kubernetes use a config, we must first get a runner token.
``` bash
docker run -it --entrypoint=/bin/bash gitlab/gitlab-runner:latest
```

Inside the runner run:
``` bash
gitlab-ci-multi-runner register
```
Enter the requested information. For your `gitlab-ci coordinator URL` use `gitlab-url/ci`. User `gitlab-ci token` can be found at gitlab-url/admin/runners or project runners page. Note: only `gitlab-ci coordinator URL` and `gitlab-url/ci` are required. Lastly enter kubernetes as the executor.

OR

```bash
gitlab-ci-multi-runner register -n --name runner-name -u gitlab-url/ci -r token --executor kubernetes
```

Capture the runner token:
``` bash
cat /etc/gitlab-runner/config.toml | sed -n "s/^.*token = \s*\"\(\S*\)\".*$/\1/p"
```