FROM debian:jessie-slim

RUN apt-get update && apt-get -y install \
    autoconf \
    automake \
    clang \
    cmake \
    curl \
    dbus \
    g++ \
    gcc \
    git \
    google-mock \
    lcov \
    libboost-dev \
    libboost-log-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libcurl4-openssl-dev \
    libdbus-1-dev \
    libexpat1-dev \
    libgtest-dev \
    libjansson-dev \
    libjsoncpp-dev \
    libssl-dev \
    libtool \
    make \
    pkg-config \
    psmisc \
    python-dbus \
    python-gtk2 \
  && rm -rf /var/lib/apt/lists/*

# clang-format >= 3.8 required
ARG llvm_toolchain=http://ftp.de.debian.org/debian/pool/main/l/llvm-toolchain-3.8
ARG lib_llvm=${llvm_toolchain}/libllvm3.8_3.8.1-12~bpo8+1_amd64.deb
ARG clang_format=${llvm_toolchain}/clang-format-3.8_3.8.1-12~bpo8+1_amd64.deb
RUN curl -o libllvm.deb ${lib_llvm} \
 && curl -o clang_format.deb ${clang_format} \
 && dpkg -i libllvm.deb clang_format.deb \
 && rm libllvm.deb clang_format.deb

RUN git config --global user.name  "aktualizr" \
 && git config --global user.email "support@advancedtelematic.com"

ARG src_dir=/src
COPY src/           ${src_dir}/src/
COPY distribution   ${src_dir}/distribution/
COPY tests/         ${src_dir}/tests/
COPY third_party/   ${src_dir}/third_party/
COPY config/        ${src_dir}/config/
COPY cmake-modules/ ${src_dir}/cmake-modules/
COPY CMakeLists.txt ${src_dir}/

WORKDIR ${src_dir}
