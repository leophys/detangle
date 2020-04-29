FROM debian:buster

ARG uid=1000
ARG gid=1000
ENV DEBIAN_BACKEND=noninteractive

RUN groupadd -g ${gid} builder \
    && useradd -g ${gid} -u ${uid} -m -d /src builder \
    && apt-get update \
    && apt-get install -y curl gnupg git \
    && curl https://bazel.build/bazel-release.pub.gpg | apt-key add - \
    && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
    && apt-get update \
    && apt-get install -y bazel \
    && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER builder
WORKDIR /src

ENTRYPOINT ["bazel"]
CMD ["--help"]
