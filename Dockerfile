FROM archlinux/base

ENV CHROMEDRIVER_VERSION="80.0.3987.106"

ARG BUILD_DATE
ARG VCS_REF

LABEL description="Docker image for running tests using robot framework."

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/wULLSnpAXbWZGYDYyhWTKKspEQoaYxXyhoisqHf/docker-archlinux-rf.git" \
      org.label-schema.vcs-ref=$VCS_REF

ADD https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip ./chromedriver.zip


RUN pacman -Syu --noconfirm --needed python python-pip chromium \
    && pacman -Scc \
    && rm -rfv /var/cache/pacman/* /var/lib/pacman/sync/* \

RUN pip install robotframework robotframework-seleniumlibrary \
    && bsdtar xfv ./chromedriver.zip && rm -v ./chromedriver.zip \
    && chmod -v +x ./chromedriver \
    && mkdir -pv /usr/local/bin \
    && mv -v ./chromedriver /usr/local/bin/
