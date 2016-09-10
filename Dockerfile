FROM jenkins

#github-organization-folder
#git
#gradle
RUN /usr/local/bin/install-plugins.sh git gradle 

USER root
# Install the tools needed for the installation
RUN apt-get update && \
    apt-get install -qq wget lib32z1 lib32stdc++6 lib32z1 lib32z1-dev

# Download the SDK
RUN cd /opt && \
    wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
    tar -xzf android-sdk_r24.4.1-linux.tgz

ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools
ENV ANDROID_BUILD_TOOLS_VERSION=23.0.1
ENV ANDROID_API="android-23"

RUN echo y | android update sdk -a -u -t platform-tools,extra-android-m2repository,${ANDROID_API},build-tools-${ANDROID_BUILD_TOOLS_VERSION} && \
    chmod a+x -R $ANDROID_HOME && \
    chown -R root:root $ANDROID_HOME

