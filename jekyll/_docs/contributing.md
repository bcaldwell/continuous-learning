---
layout: docs
title:  "Contributing"

---

Glad to see you are interested in contribting to devctl!

# Need help? Found a bug?
- devctl utilizes Github issues to track any feature requests, bugs or any
  questions.
- If you find a bug please ensure all the following information is provided :)
  - OS name and OS distribution
  - `devctl` version
  - `zsh` version
  - any error output/logs
  - detailed description of the bug and if possible steps to recreate

# Ways to contribute
devctl is currently maintained by two part time developers so if you enjoy it,
please consider contributing.

- Clone devctl/devctl repo locally.
- In order to start using the development/local version of devctl, run `devctl
  load-dev`.
- This will cause devctl to use the local copy of the repository and allow you
  to test your changes.
- Once you have completed your feature or bug fix, please add tests to ensure
  that any issues can be caught in the future.
- In order to run tests locally please run `test`.

## Submitting a Pull Request
- Please fork the `devctl/devctl` repo and make any changes you want. Once the
  changes are complete, please submit a PR against the `master` branch in the
  `devctl/devctl` repo.
- If your PR is related to an open issue, please link the open issue along with
  your PR.
- Please try and keep the PR small and focused. If you would like to propose two
  unrelated changes, please consider opening two pull requests.
- Please be detailed in the description of your pull request regarding what
  changes were made, why they were made and any potential impact (positive or
  negative) it might have on existing and new users.
- Please make sure any changes are tests properly and the CI run is successful
  on your PR. Also if any proposed changes require changes to the documentation,
  please update those as well.
- In order to get your PR reviewed, please tag @benjamincaldwell and
  @karanthukral.
