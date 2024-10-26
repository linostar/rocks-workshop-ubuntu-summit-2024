# Instructions for Exercise 3

1. Run `rockcraft init` to create a boilerplate `rockcraft.yaml` file
2. Open `rockcraft.yaml` with your favorite editor
3. Change `name` field to `numpy` and `version` to `0.3`
4. Change the `base` field value to `bare`, and add a new line `build-base: ubuntu@24.04`
4. Change `summary` and `description` fields to something meaningful
5. Change the value(s) under `platforms` to match your architectures (e.g. `arm64`, `riscv64`, `ppc64le`, `s390x`)
6. Under `parts`, change the part name from `my-part` to `numpy`
6. Let's slice the `python3-numpy` package using Chisel (Check [Contributing doc](https://github.com/canonical/chisel-releases/blob/main/CONTRIBUTING.md) for more info)
    1. Run `chisel find python3*` to see if python3-numpy has been already sliced
    2. since it's not sliced already, we'll do it ourselves by creating an empty file called `python3-numpy.yaml`
    3. The first line in the file should be `package: python3-numpy.yaml`
    4. Next, add the `slices:` line, then a slice called `bins` directly under it by adding the line `bins:`
    5. Next, we determine the dependencies of this package by running `apt depends python3-numpy`
    6. We can find if the dependency slices (if they exist) by running `chisel find <name>` or `chisel info <name>`
    7. We start adding the dependencies in the yaml file one by one in a list under `essential:` field under `bins:`
    8. Next, let's determine the contents of the `python3-numpy` package by downloading and listing the deb file contents: `apt download python3-numpy` then `dpkg-deb -c python3-numpy*deb`
    9. Add `contents:` under `bins:` then add the full paths of the files you want to include in your slice under `contents:`
    10. It is highly recommended to use globs to simplify the paths included under `contents:`, and to mask versions and architectures
    11. In a similar fashion, add another slice called `copyright` that contains no dependencies but has the copyright files in contents
    12. List the copyright slice under a top-level `essential` field so that it gets included in every other slice in that package
    13. Once done with python3-numpy slicing, you can do the same for any unsliced package that it depends on
7. Back to `rockcraft.yaml`, under `plugin: nil` add the following lines that will use a repo contains all the sliced packages we need for python3-numpy: 
```yaml
  source: https://github.com/zhijie-yang/chisel-releases
  source-type: git
  source-tag: numpy-24.04
  override-build: |
    chisel cut --release ./ --root ${CRAFT_PART_INSTALL} python3-numpy_bins
```
10. Run `rockcraft pack` to build and pack the rock image
11. Run the following command to export the rock to a docker image:
```
rockcraft.skopeo --insecure-policy copy oci-archive:numpy_0.3_amd64.rock docker-daemon:numpy:0.3
```
12. Run the image with docker:
```
docker run --rm -it numpy:0.3 exec python3.12
```
13. Import `numpy` inside the python shell: `import numpy`
