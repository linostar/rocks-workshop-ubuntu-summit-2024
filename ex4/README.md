# Instructions for Excercise 4

1. Run `rockcraft init` to create a boilerplate `rockcraft.yaml` file
2. Open `rockcraft.yaml` with your favorite editor
3. Change `name` field to `numpy` and `version` to `0.4`
4. Change the `base` field value to `bare`, and add a new line `build-base: ubuntu@22.04`
4. Change `summary` and `description` fields to something meaningful
5. Change the value(s) under `platforms` to match your architectures (e.g. `arm64`, `riscv64`, `ppc64le`, `s390x`)
6. Under `parts`, paste from below:
```yaml
jupyter-pytorch:
    plugin: python
    source: .
    python-packages:
      - jupyter
    python-requirements:
      - requirements.txt
    stage-packages:
      - python3-venv

  matplotlib:
    plugin: nil
    stage-packages:
      - python3-matplotlib

```
7. Add a service to launch jupyter:
```
services:
  jupyter:
    override: replace
    command: jupyter notebook --ip=0.0.0.0 --port=8848 --no-browser
    startup: enabled
```
8. Specify the `__daemon__` user to be the one to run the service by adding:
```
run-user: _daemon_
```
8. Add the necessary environment variables:
```
environment:
  JUPYTERLAB_DIR: /share/jupyter/lab
```
9. Create a `requirements.txt` file in the same folder and add the following inside it:
```
-i https://download.pytorch.org/whl/cpu
torch
torchvision
torchaudio
```
8. Run `rockcraft pack` to build and pack the rock image
9. Run the following command to export the rock to a docker image:
```
rockcraft.skopeo --insecure-policy copy oci-archive:numpy_0.4_amd64.rock docker-daemon:numpy:0.4
```
10. Run the image with docker:
```
docker run -p 8848:8848 -it --rm numpy:0.4 --verbose
```
11. Get the link of the jupyter server from the logs
12. Navigate to the jupyter link in a browser
