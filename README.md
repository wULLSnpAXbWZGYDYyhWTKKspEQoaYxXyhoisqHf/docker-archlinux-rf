# docker-archlinux-rf

[![Build Status](https://drone.dotya.ml/api/badges/wanderer/docker-archlinux-rf/status.svg?ref=refs/heads/master)](https://drone.dotya.ml/wanderer/docker-archlinux-rf)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/immawanderer/archlinux-rf)](https://hub.docker.com/r/immawanderer/archlinux-rf/builds)

This repository provides the Dockerfile to create a Docker image used to run [robot framework](https://robotframework.org) tests.

## :warning: :construction: DockerHub issue :construction: :warning:
unless you're running Arch (or a Fedora 34+ or some reasonably recent thing) as your host OS, please make sure you read through the following issue write-up (since DH issue affects the base image it affects this one, too) \
⇒ https://git.dotya.ml/wanderer/docker-archlinux/issues/1 \
:warning: :construction: :construction: :construction: :warning:

push mirror lives in [this GitHub repo](https://github.com/wULLSnpAXbWZGYDYyhWTKKspEQoaYxXyhoisqHf/docker-archlinux-rf)  
development happens on [this Gitea instance](https://git.dotya.ml/wanderer/docker-archlinux-rf)

## What you get
* updated Arch Linux [image](https://hub.docker.com/r/immawanderer/archlinux) based on [base image](https://hub.docker.com/_/archlinux)
* python3
* robot framework
* selenium library
* chromium
* chrome driver
