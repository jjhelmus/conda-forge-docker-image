A Docker image for conda-forge based upon 
[manylinux](https://github.com/pypa/manylinux).


To build the image:

```
docker build -t jjhelmus/manylinux-cf -f docker/Dockerfile-x86_64 docker/
```

To test by building the `arm_pyart` recipe from conda-forge.

```
docker run -v /Users/jhelmus/dev/conda-forge/manylinux-cf/tests:/tests -t -i jjhelmus/manylinux-cf /bin/bash /tests/build_arm_pyart.sh
```
