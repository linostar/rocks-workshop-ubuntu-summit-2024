# Instructions for Exercise 1

1. Run `rockcraft init` to create a boilerplate `rockcraft.yaml` file
2. Open `rockcraft.yaml` with your favorite editor
3. Change `name` field to `numpy`
4. Change `summary` and `description` fields to something meaningful
5. Change the value(s) under `platforms` to match your architectures (e.g. `arm64`, `riscv64`, `ppc64le`, `s390x`)
6. Under `parts`, change the part name from `my-part` to `numpy`
7. Under `plugin: nil` add the following lines: 
```yaml
  overlay-packages:
    - python3-numpy
```
8. Run `rockcraft pack` to build and pack the rock image
9. Run the following command to export the rock to a docker image:
```
rockcraft.skopeo --insecure-policy copy oci-archive:numpy_0.1_amd64.rock docker-daemon:numpy:0.1
```
10. Run the image with docker:
```
docker run --rm -it numpy:0.1 exec python3.12
```
11. Import `numpy` inside the python shell: `import numpy`
