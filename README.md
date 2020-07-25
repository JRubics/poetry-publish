# poetry-publish
An action to build and publish python package to pypi (https://pypi.org/) using poetry (https://github.com/sdispater/poetry).

## Inputs

### `python_version`

The version of python to install (default: latest). Use default for a shorter build time.

### `poetry_version`

The version of poetry to install (default: latest).

### `pypi_token`

**Required** API token to authenticate when uploading package to PyPI (https://pypi.org/manage/account/).

### `repository_name`

The name of a repository where we will upload the package. Necessary if you'd like to upload to test PyPi or a private wheels repo. Uploads to official PyPi if not informed.

### `repository_url`

The URL where the package will be uploaded. Necessary if you'd like to upload to test PyPi or a private wheels repo. Uploads to official PyPi if not informed.

## Example usage

The following will build and publish the pyhon package using the last version of python and poetry. Specify the python package version and dependencies in `pyproject.toml` in the root directory of your project.

```yaml
- name: Build and publish to pypi
  uses: JRubics/poetry-publish@v1
  with:
    pypi_token: ${{ secrets.PYPI_TOKEN }}
```

Python and poetry versions can be specified in inputs.

```yaml
- name: Build and publish to pypi
  uses: JRubics/poetry-publish@v1
  with:
    python_version: '3.7.1'
    poetry_version: '==1.0.5'  # (PIP version specifier syntax)
    pypi_token: ${{ secrets.PYPI_TOKEN }}
    repository_name: 'testpypi'
    repository_url: 'https://test.pypi.org/legacy/'
```

## Example workflow

The following will build and publish the pyhon package when project is tagged in the `v*.*.*` form.

```yaml
name: Python package
on:
  push:
    tags:
      - 'v*.*.*'
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Build and publish to pypi
      uses: JRubics/poetry-publish@v1
      with:
        pypi_token: ${{ secrets.PYPI_TOKEN }}
```
