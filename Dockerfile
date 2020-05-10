FROM archlinux:latest

ENV CHROMEDRIVER_VERSION="80.0.3987.106"
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
RUN pacman -Sy --noconfirm --needed python python-pip chromium wget vim jq \
    && pip install robotframework robotframework-seleniumlibrary \
    && bsdtar xfv /tmp/chromedriver.zip && rm -v /tmp/chromedriver.zip \
    && chmod -v +x /tmp/chromedriver \
    && mkdir -pv /usr/local/bin \
    && mv -v /tmp/chromedriver /usr/local/bin/ \
RUN pacman -Scc && rm -rfv /var/cache/pacman/* /var/lib/pacman/sync/* \
    && rm -rv /usr/share/info/* ;rm -rv /usr/share/man/* ; \
    rm -rv /usr/share/doc/* ;rm -rv /usr/share/zoneinfo/* ; \
    rm -rv /usr/share/i18n/* ;rm -rv /usr/include/* ; \ find /. -name "*~" -type f -delete; \
    find /usr/share/terminfo/. ! -name "*xterm*" ! -name "*screen*" ! -name "*screen*" -type f -delete; \
    rm -rv /tmp/* || true
WORKDIR /
