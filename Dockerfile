FROM apluslms/grading-base:2.8

ARG JAVA_VER=jdk1.8.0_202
ARG JAVA_URL=https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.tar.gz
ARG JAVA_SHA=9a5c32411a6a06e22b69c495b7975034409fa1652d03aeb8eb5b6f59fd4594e0
ARG JAVA_DIR=/usr/local/java
ENV JAVA_HOME=$JAVA_DIR/$JAVA_VER

RUN mkdir -p $JAVA_DIR && cd $JAVA_DIR \
 # Download java
 && curl -LSs -o jdk.tar.gz -b "oraclelicense=accept-securebackup-cookie" "$JAVA_URL" \
 && (echo "$JAVA_SHA jdk.tar.gz" | sha256sum -c -) \
 && tar -zxf jdk.tar.gz \
 && rm jdk.tar.gz \
\
 # Link java binaries to PATH
 && update-alternatives --install "/usr/bin/java" "java" "$JAVA_HOME/bin/java" 1 \
 && update-alternatives --install "/usr/bin/javac" "javac" "$JAVA_HOME/bin/javac" 1 \
\
 # Clean java installation
 && cd $JAVA_HOME \
 && find . '(' -iname '*javafx*' -o -iname '*jfx*' ')' -exec rm {} + \
 && rm -r \
       COPYRIGHT LICENSE README.html THIRDPARTYLICENSEREADME.txt \
       bin/jvisualvm \
       bin/jmc bin/jmc.ini \
       jre/COPYRIGHT jre/LICENSE jre/README jre/THIRDPARTYLICENSEREADME.txt jre/Welcome.html \
       jre/plugin \
       lib/jexec \
       lib/missioncontrol \
       lib/visualvm \
       man \
       src.zip \
 && chown -R 0:50 . \
\
 # Download libraries
 && mkdir -p $JAVA_DIR/lib && cd $JAVA_DIR/lib \
 && gpg_recv EFE8086F9E93774E A6ADFC93EF34893E \
 && download_verify -a -s -as https://search.maven.org/remotecontent?filepath=junit/junit/4.12/junit-4.12.jar \
 && download_verify -a -s -as https://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar

COPY bin /usr/local/bin
ENV CLASSPATH=.:/exercise:/exercise/*:/exercise/lib/*:$JAVA_DIR/lib/*:$JAVA_HOME/lib/*:$JAVA_HOME/jre/lib/*
