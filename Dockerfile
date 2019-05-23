FROM will495/alpine-gold:latest

WORKDIR /root
RUN apk add --no-cache --virtual .build4pjsip \
    alpine-sdk \
    && apk add --no-cache \
    libsrtp-dev \
    openssl-dev \
    opus-dev \
    && cd \
    && wget -qnv "http://www.pjsip.org/release/2.8/pjproject-2.8.tar.bz2" -O - | tar xjf - \
    && cd pjproject-2.8 \
    && ./configure \
      --with-external-srtp \
      --enable-shared \
      --disable-sound \
      --disable-sdl \
      --disable-speex-aec \
      --disable-video \
      --prefix=/usr/local \
      > /dev/null \
    && make dep \
    && make \
    && make install \
    && cd \
    && rm -rf pjproject-2.8 \
    && apk del .build4pjsip
