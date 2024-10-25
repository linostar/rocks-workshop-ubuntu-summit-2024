# Instructions for Excercise 3

1. Run `rockcraft init` to create a boilerplate `rockcraft.yaml` file
2. Open `rockcraft.yaml` with your favorite editor
3. Change `name` field to `numpy` and `version` to `0.3`
4. Change the `base` field value to `bare`, and add a new line `build-base: ubuntu@24.04`
4. Change `summary` and `description` fields to something meaningful
5. Change the value(s) under `platforms` to match your architectures (e.g. `arm64`, `riscv64`, `ppc64le`, `s390x`)
6. Under `parts`, change the part name from `my-part` to `numpy`
6. Let's slice the `python3-numpy` package using Chisel
7. Under `plugin: nil` add the following lines: 
```yaml
  source: chisel-releases
  source-type: local
  override-build: |
    chisel cut --release ./ --root ${CRAFT_PART_INSTALL} python3-numpy_bins
```
8. Run `rockcraft pack` to build and pack the rock image
9. Run the following command to export the rock to a docker image:
```
rockcraft.skopeo --insecure-policy copy oci-archive:numpy_0.3_amd64.rock docker-daemon:numpy:0.3
```
10. Run the image with docker:
```
docker run --rm -it numpy:0.3 exec python3.12
```
11. Import `numpy` inside the python shell: `import numpy`
