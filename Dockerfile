FROM apluslms/grading-base:2.5

ARG JAVA_VER=jdk1.8.0_181
ARG JAVA_URL=https://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz
ARG JAVA_DIR=/usr/local/java
ENV JAVA_HOME=$JAVA_DIR/$JAVA_VER

RUN mkdir -p $JAVA_DIR && cd $JAVA_DIR \
 # Download java
 && (curl -LSsb "oraclelicense=accept-securebackup-cookie" $JAVA_URL | tar zx) \
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
