FROM nvcr.io/nvidia/isaac-sim:4.0.0
SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["/bin/bash", "-login"]

ENV ACCEPT_EULA=Y
ENV PRIVACY_CONSENT=Y
ENV DISPLAY=:0
ENV PROXY=***.***.***.***:**

RUN /bin/bash
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list
RUN echo "export http_proxy=http://${PROXY}" >> /root/.bashrc
RUN echo "export https_proxy=http://${PROXY}" >> /root/.bashrc
RUN echo "alias ov-launcher='./omniverse-launcher-linux.AppImage --no-sandbox --proxy-server=${PROXY}'" >> /root/.bashrc
RUN echo '. /etc/bash_completion' >> /root/.bashrc
RUN echo '# export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/dbus/system_bus_socket"' >> /root/.bashrc
RUN echo 'service dbus start > nul' >> /root/.bashrc
RUN echo 'export OMNI_KIT_ALLOW_ROOT=1' >> /root/.bashrc
RUN echo 'export $(dbus-launch)' >> /root/.bashrc
RUN . /root/.bashrc
RUN apt update
RUN apt install -y software-properties-common
RUN http_proxy="http://${PROXY}" https_proxy="http://${PROXY}" add-apt-repository ppa:apt-fast/stable
RUN rm -rf /var/lib/apt/lists/*
RUN http_proxy="http://${PROXY}" https_proxy="http://${PROXY}" add-apt-repository ppa:mozillateam/ppa
RUN curl -k -o omniverse-launcher-linux.AppImage -x "http://${PROXY}" https://install.launcher.omniverse.nvidia.com/installers/omniverse-launcher-linux.AppImage
RUN chmod +x omniverse-launcher-linux.AppImage
RUN echo -e "Package: firefox*\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001" | tee /etc/apt/preferences.d/mozillateamppa
RUN echo "Asia/Tokyo" | tee /etc/timezone
RUN rm /etc/apt/apt.conf.d/docker-clean
RUN apt update
RUN apt install -y apt-fast
RUN apt-fast install -y \
    fonts-takao \
    firefox \
    bash \
    x11-apps \
    bash-completion \
    wget \
    fuse \
    libglib2.0-0 \
    libgtk2.0-0 \
    libgtk-3-0 \
    libnss3 \
    libasound2 \
    libatk-bridge2.0-0 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxi6 \
    libxtst6 \
    libnss3 \
    libxss1 \
    libasound2 \
    libatk1.0-0 \
    libcups2 \
    libgdk-pixbuf2.0-0 \
    libpango1.0-0 \
    libxrandr2 \
    libdrm-dev \
    libgdm-dev \
    libgbm-dev \
    libsecret-1-0 \
    vim \
    kmod \
    xdg-utils \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libpci3 \
    desktop-file-utils \
    dbus-x11 \
    x11-xserver-utils \
    yaru-theme-icon \
    lshw \
    lshw-gtk \
    lsof

RUN gtk-update-icon-cache /usr/share/icons/Yaru
RUN mkdir /usr/share/desktop-directories/

RUN mkdir -p /etc/dbus-1/system.d && \
    echo '<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN" "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">' > /etc/dbus-1/system.d/tilix.conf && \
    echo '<busconfig>' >> /etc/dbus-1/system.d/tilix.conf && \
    echo '    <policy user="root">' >> /etc/dbus-1/system.d/tilix.conf && \
    echo '        <allow own="com.gexperts.Tilix"/>' >> /etc/dbus-1/system.d/tilix.conf && \
    echo '    </policy>' >> /etc/dbus-1/system.d/tilix.conf && \
    echo '    <policy context="default">' >> /etc/dbus-1/system.d/tilix.conf && \
    echo '        <allow own="com.gexperts.Tilix"/>' >> /etc/dbus-1/system.d/tilix.conf && \
    echo '    </policy>' >> /etc/dbus-1/system.d/tilix.conf && \
    echo '</busconfig>' >> /etc/dbus-1/system.d/tilix.conf

# RUN service dbus reload
