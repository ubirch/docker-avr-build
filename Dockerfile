FROM debian:jessie
MAINTAINER Falko Zurell <falko.zurell@gmail.com>
# Build-time metadata as defined at http://label-schema.org
  ARG BUILD_DATE
  ARG VCS_REF
  LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.docker.dockerfile="/Dockerfile" \
        org.label-schema.license="MIT" \
        org.label-schema.name="ubirch AVR Build container" \
        org.label-schema.url="https://ubirch.com/" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-type="Git" \
        org.label-schema.vcs-url="https://github.com/ubirch/docker-avr-build"


LABEL description="uBirch avr build container"
RUN apt-get update && apt-get install gcc-avr avrdude wget xz-utils git binutils-avr libc6-dev avr-libc cmake -y && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt
RUN git config --system user.name Docker && git config --system user.email docker@localhost
RUN wget http://downloads.arduino.cc/arduino-1.6.6-linux64.tar.xz
RUN tar xf arduino-1.6.6-linux64.tar.xz
RUN mkdir /build
VOLUME /build
WORKDIR /build
ENV ARDUINO_SDK_PATH=/opt/arduino-1.6.6
