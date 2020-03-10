FROM archlinux/base

RUN pacman -Syu --noconfirm --needed python python-pip wget tar chromium \
    && pacman -Scc \
    && rm -rfv /var/cache/pacman/* /var/lib/pacman/sync/* \
    && pip install robotframework robotframework-seleniumlibrary \
    && wget -qO- https://chromedriver.storage.googleapis.com/80.0.3987.106/chromedriver_linux64.zip | bsdtar -xvf - \
    && chmod -v +x chromedriver \
    && mkdir -pv /usr/local/bin \
    && mv -v chromedriver /usr/local/bin/
