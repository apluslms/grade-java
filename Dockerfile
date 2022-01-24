ARG BASE_TAG=latest
FROM --platform=$TARGETPLATFORM apluslms/grading-base:$BASE_TAG

COPY rootfs /

RUN : \
 # install AdoptOpenJDK 11 with the HotSpot virtual machine (from OpenJDK)
 && apt_install \
    gnupg \
 && curl -LSs https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | gpg --dearmor -o /usr/share/keyrings/adoptopenjdk-archive-keyring.gpg >/dev/null 2>&1 \
 && echo "deb [signed-by=/usr/share/keyrings/adoptopenjdk-archive-keyring.gpg] https://adoptopenjdk.jfrog.io/adoptopenjdk/deb bullseye main" > /etc/apt/sources.list.d/adoptopenjdk.list \
 && apt_install \
    adoptopenjdk-11-hotspot \
 # install apt+ivy for ivy_install
 && apt_install \
    ant \
    ivy \
 && rm -r /usr/share/man \
\
 # Install libraries
 && ivy_install -n "grade-java" -d "/usr/local/java/lib" \
    junit junit 4.13 \
\
 && apt_purge \
    gnupg \
 && :

COPY bin /usr/local/bin
ENV CLASSPATH=.:/exercise:/exercise/*:/exercise/lib/*:/usr/local/java/lib/*
CMD ["run-all-junits"]
