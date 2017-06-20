FROM apluslms/grading-base:debian-stretch

ARG JAVA_URL=http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
ARG JAVA_DIR=jdk1.8

RUN mkdir -p /usr/local/jdk \
  && cd /usr/local/jdk \
  && (curl -Lsb "oraclelicense=accept-securebackup-cookie" $JAVA_URL | tar zx) \
  && mv $DIR* $DIR

ENV JAVA_HOME /usr/local/jdk/$DIR
ENV JRE_HOME $JAVA_HOME/jre
ENV PATH $PATH:$JAVA_HOME/bin

ADD aplus /aplus

RUN mkdir -p /usr/local/jdk/lib \
  && cd /usr/local/jdk/lib \
  && curl -sO https://repo1.maven.org/maven2/junit/junit/4.12/junit-4.12.jar \
  && curl -sO https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar
