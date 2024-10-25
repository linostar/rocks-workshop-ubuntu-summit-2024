# Instructions for Exercise 2

1. Run `rockcraft init` to create a boilerplate `rockcraft.yaml` file
2. Open `rockcraft.yaml` with your favorite editor
3. Change `name` field to `numpy` and `version` to `0.2`
4. Change the `base` field value to `bare`, and add a new line `build-base: ubuntu@24.04`
4. Change `summary` and `description` fields to something meaningful
5. Change the value(s) under `platforms` to match your architectures (e.g. `arm64`, `riscv64`, `ppc64le`, `s390x`)
6. Under `parts`, change the part name from `my-part` to `numpy`
7. Under `plugin: nil` add the following lines: 
```yaml
        stage-packages:
            - python3-numpy
        override-build: |
            craftctl default
            ln -s /usr/lib/x86_64-linux-gnu/blas/libblas.so.3 ${CRAFT_PART_INSTALL}/usr/lib/x86_64-linux-gnu/libblas.so.3
            ln -s /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3 ${CRAFT_PART_INSTALL}/usr/lib/x86_64-linux-gnu/liblapack.so.3

```
8. Run `rockcraft pack` to build and pack the rock image
9. Run the following command to export the rock to a docker image:
```
rockcraft.skopeo --insecure-policy copy oci-archive:numpy_0.2_amd64.rock docker-daemon:numpy:0.2
```
10. Run the image with docker:
```
docker run --rm -it numpy:0.2 exec python3.12
```
11. Import `numpy` inside the python shell: `import numpy`
