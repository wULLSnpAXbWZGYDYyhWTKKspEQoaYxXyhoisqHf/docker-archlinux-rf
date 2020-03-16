FROM archlinux/base

ENV CHROMEDRIVER_VERSION="80.0.3987.106"

ARG BUILD_DATE
ARG VCS_REF

LABEL description="Docker image for running tests using robot framework."

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/wULLSnpAXbWZGYDYyhWTKKspEQoaYxXyhoisqHf/docker-archlinux-rf.git" \
      org.label-schema.vcs-ref=$VCS_REF

ADD https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip /tmp/chromedriver.zip

WORKDIR /tmp

RUN pacman -Syu --noconfirm --needed python python-pip chromium \
    && pacman -Scc \
    && rm -rfv /var/cache/pacman/* /var/lib/pacman/sync/* \

RUN pip install robotframework robotframework-seleniumlibrary \
    && bsdtar xfv /tmp/chromedriver.zip && rm -v /tmp/chromedriver.zip \
    && chmod -v +x /tmp/chromedriver \
    && mkdir -pv /usr/local/bin \
    && mv -v /tmp/chromedriver /usr/local/bin/ && \

    # improved clean-up thanks to this: https://github.com/yantis/docker-archlinux-tiny
    pacman --noconfirm -Runs \
    gzip less sysfsutils which \
    && pacman --noconfirm -R \
    util-linux shadow \
    && rm -rv /usr/share/info/* \
    && rm -rv /usr/share/man/* \
    && rm -rv /usr/share/doc/* \
    && rm -rv /usr/share/zoneinfo/* \
    && rm -rv /usr/share/i18n/* \
    && find /. -name "*~" -type f -delete \
    && find /usr/share/terminfo/. ! -name "*xterm*" ! -name "*screen*" ! -name "*screen*" -type f -delete \
    && rm -rv /tmp/* \
    && rm -rv /usr/include/* \
    && pacman --noconfirm -Runs tar gawk \
    && pacman -Scc \
    && rm -rv /var/cache/pacman/* /var/lib/pacman/sync/* \

WORKDIR /
