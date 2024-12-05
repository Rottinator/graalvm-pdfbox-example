FROM ubuntu:22.04

ENV LC_ALL=C.utf8 LC_CTYPE=C.utf8

RUN apt-get update && apt-get install --assume-yes build-essential libz-dev zlib1g-dev curl

#Install GraalVM
ENV JAVA_HOME=/graalvm

RUN mkdir $JAVA_HOME && \
    curl -L https://download.oracle.com/graalvm/23/archive/graalvm-jdk-23_linux-aarch64_bin.tar.gz -o /tmp/graalvm-download.tar.gz && \
    tar xzf /tmp/graalvm-download.tar.gz -C $JAVA_HOME --strip-components 1  && \
    rm /tmp/graalvm-download.tar.gz

#Install Maven
ENV MAVEN_INSTALL_DIR=/usr/maven MAVEN_VERSION=3.9.4

RUN curl https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz --output /tmp/maven.tar.gz &&\
    tar -xf /tmp/maven.tar.gz -C /usr/ &&\
    mv /usr/apache-maven-$MAVEN_VERSION $MAVEN_INSTALL_DIR

#Set Environment-Variables for Java and Maven
ENV PATH="$JAVA_HOME/bin:$MAVEN_INSTALL_DIR/bin:$PATH" MAVEN_HOME=$MAVEN_INSTALL_DIR

WORKDIR /build

COPY pom.xml /build/pom.xml
COPY src /build/src/

RUN mvn package -P native

ENTRYPOINT ["/build/target/pdfboxsample"]