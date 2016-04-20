# Arduino build container
This container contains the build tools to compile Arduino sketch files

To use it you mount your project to the ```/build``` directory. This is the default
working directory for the container.

The ENTRYPOINT for the container is ```/usr/bin/make```. This is convenient if your
project already contains a Makefile.

If that needs to be created first, I recommend placing a shell script in the root
directory of your project that contains your build steps and call it with the
container:

```docker run --rm -v $PWD:/build ubirch/avr-build build.sh```
