FROM archlinux:latest

ENV CHROMEDRIVER_VERSION="83.0.4103.39"
ENV SCREEN_WIDTH=1920
ENV SCREEN_HEIGHT=1080
ENV SCREEN_MAIN_DEPTH=24
ENV SCREEN_SUB_DEPTH=32

ARG BUILD_DATE
ARG VCS_REF

LABEL description="Docker image for running tests using robot framework."

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/wULLSnpAXbWZGYDYyhWTKKspEQoaYxXyhoisqHf/docker-archlinux-rf.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.license=GPL-3.0

ADD https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip /tmp/chromedriver.zip

WORKDIR /tmp/
RUN pacman -Syu --noconfirm --needed python python-pip chromium wget vim findutils \
    && pip install robotframework robotframework-seleniumlibrary b2 \
    && bsdtar xfv /tmp/chromedriver.zip && rm -v /tmp/chromedriver.zip \
    && chmod -v +x /tmp/chromedriver \
    && mkdir -pv /usr/local/bin \
    && mv -v /tmp/chromedriver /usr/local/bin/
RUN pacman -Scc && rm -rf /var/cache/pacman/* /var/lib/pacman/sync/* \
    && rm -rf /usr/share/i18n/* ; rm -rf /usr/include/* ; \
    find /. -name "*~" -type f -delete; \
    find /usr/share/terminfo/. ! -name "*xterm*" ! -name "*screen*" ! -name "*screen*" -type f -delete;
WORKDIR /
