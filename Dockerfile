# syntax=docker/dockerfile:1.2
# refs:
#   https://docs.docker.com/develop/develop-images/build_enhancements/#overriding-default-frontends
#   https://pythonspeed.com/articles/docker-buildkit/

FROM immawanderer/archlinux:linux-amd64

ENV CHROMEDRIVER_VERSION="90.0.4430.24"
ENV SCREEN_MAIN_DEPTH=24
ENV SCREEN_SUB_DEPTH=32

ARG BUILD_DATE
ARG VCS_REF

LABEL description="Docker image for running tests using robot framework."

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://git.dotya.ml/wanderer/docker-archlinux-rf.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.license=GPL-3.0

ADD https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip /tmp/chromedriver.zip

WORKDIR /tmp/
RUN pacman -Syu --noconfirm --needed python python-pip chromium wget vim findutils \
    && pip install --no-cache-dir robotframework robotframework-seleniumlibrary b2 \
    && bsdtar xfv /tmp/chromedriver.zip && rm -v /tmp/chromedriver.zip \
    && chmod -v +x /tmp/chromedriver \
    && mkdir -pv /usr/local/bin \
    && mv -v /tmp/chromedriver /usr/local/bin/
RUN pacman -Scc && rm -rf /var/cache/pacman/* /var/lib/pacman/sync/* \
    && rm -rf /usr/share/i18n/* ; rm -rf /usr/include/* ; \
    find /. -name "*~" -type f -delete; \
    find /usr/share/terminfo/. ! -name "*xterm*" ! -name "*screen*" ! -name "*screen*" -type f -delete; \
    mkdir -pv /testing
WORKDIR /
