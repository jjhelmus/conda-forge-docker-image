A Docker image used by conda-forge to build linux-64 conda packages based upon
[manylinux](https://github.com/pypa/manylinux).


To build the image:

```
docker build -t jjhelmus/conda-forge-x86_64 -f docker/Dockerfile-x86_64 docker/
```

To test by building the `arm_pyart` recipe from conda-forge.

```
docker run -v `pwd`/tests:/tests -t -i jjhelmus/conda-forge-x86_64 /bin/bash /tests/build_arm_pyart.sh
```
