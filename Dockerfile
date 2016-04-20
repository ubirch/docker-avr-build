FROM debian:jessie
MAINTAINER Falko Zurell <falko.zurell@gmail.com>

LABEL description="uBirch avr build container"
RUN apt-get update && apt-get install gcc-avr avrdude wget xz-utils git binutils-avr avr-libc cmake -y && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt
RUN wget http://downloads.arduino.cc/arduino-1.6.5-linux64.tar.xz
RUN tar xf arduino-1.6.5-linux64.tar.xz
RUN mkdir /build
VOLUME /build
WORKDIR /build
ENV ARDUINO_SDK_PATH=/opt/arduino-1.6.5
