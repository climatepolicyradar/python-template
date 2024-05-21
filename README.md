# Template for Python-based repositories

## Prerequisites

- Python
- Poetry
- GNU Make
- Trunk.io
- Pyenv (optional)

If you have not yet installed Trunk.io on your machine, run `make install_trunk`
at the root of this project to install locally (works for Mac & Linux systems).

## Getting started

1. First things first, find all instances of `REPO_NAME` in this repo and
   replace them with the name of your repository.

### Configuring Trunk

Read [trunk.md](trunk.md).

### Create your virtual environment

To bootstrap the repo using Pyenv, run `make setup_with_pyenv`.

### Configure Pyright

Run `trunk actions enable configure-pyright` to configure Pyright to work with
your new repository.

If you prefer to use Pyenv, you'll need to add a 'venv' key with the value of
`REPO_NAME` to your [pyproject.toml](pyproject.toml) file, under the Pyright
section. If this is omitted, Trunk.io will assume you are using Poetry virtual
environments instead.

```toml
[tool.pyright]
venv = "REPO_NAME"
```
