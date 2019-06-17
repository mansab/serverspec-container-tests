# serverspec-container-tests

This repo has multiple branches which guides you through TDD for infrastructure code.

The aim of this repo is to start with a scenario and write tests before writing a Dockerfile or docker-compose.yml

Then your tests should guide how your Dockerfile or docker-compose.yml should look like.

## Scenario
* Use alpine 3.9.4 as base image
* Use Python 3.7.3
* A small python web-app, which says...“Hello World!” off-course ;)
* App should be owned and run by a low privileged user ‘app-user’
* Container should not run as root
* Service should run on port 5000
* Container should expose port 5000

## how to start

* Switch to branch called `test_1`

```bash
git checkout test_1
```

* Run the test

```bash
./run
```

This will give you a failing test, you can either try to fix this test yourself or switch to a branch called `pass_1` and run the test again

For example,

```bash
git checkout pass_1
```

Run the test

```bash
./run
```

You can keep on going like this until `test_7` and it will guide to write your Dockerfile and docker-compose.yml based on the above scenario.
