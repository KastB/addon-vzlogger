ARG BUILD_FROM
ARG BUILD_ARCH

FROM $BUILD_FROM
LABEL maintainer="kastbernd@gmx.de"

RUN apt-get update && apt-get install -y \
    build-essential \
    git-core \
    cmake \
    pkg-config \
    libcurl4-openssl-dev \
    libgnutls28-dev \
    libsasl2-dev \
    uuid-dev \
    libtool \
    libssl-dev \
    libgcrypt20-dev \
    libmicrohttpd-dev \
    libltdl-dev \
    libjson-c-dev \
    libleptonica-dev \
    libmosquitto-dev \
    libunistring-dev \
    dh-autoreconf \
    && rm -rf /var/lib/apt/lists/*

cd /

RUN git clone https://github.com/volkszaehler/libsml.git --depth 1 \
 && make install -C libsml/sml

RUN git clone https://github.com/rscada/libmbus.git --depth 1 \
 && cd libmbus \
 && ./build.sh \
 && make install

RUN git clone https://github.com/volkszaehler/vzlogger.git && \
	cd vzlogger && \
	./install.sh

FROM $BUILD_FROM

LABEL Description="vzlogger"

RUN apt-get update && apt-get install -y \
    libcurl4 \
    libgnutls30 \
    libsasl2-2  \
    libuuid1 \
    libssl1.1 \
    libgcrypt20  \
    libmicrohttpd12 \
    libltdl7 \
    libatomic1 \
    libjson-c3 \
    liblept5 \
    libmosquitto1 \
    libunistring2 \
    && rm -rf /var/lib/apt/lists/*

# libsml is linked statically => no need to copy
COPY --from=builder /usr/local/bin/vzlogger /usr/local/bin/vzlogger
COPY --from=builder /usr/local/lib/libmbus.so* /usr/local/lib/

# without running a user context, no exec is possible and without the dialout group no access to usb ir reader possible
RUN apt-get update && apt-get install -y socat jq
COPY run.sh /
RUN chmod +x /run.sh
CMD ["/run.sh"]

