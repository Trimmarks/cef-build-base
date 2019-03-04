FROM buildpack-deps:trusty
ARG DEBIAN_FRONTEND=noninteractive

RUN { \
  echo 'install: --no-document'; \
  echo 'update: --no-document'; \
} >> /etc/gemrc
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN set -x && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:brightbox/ruby-ng && \
    apt-get update && \
	apt-get install -y lsb-release sudo ninja-build p7zip-full xvfb libgtkglext1-dev locales openjdk-7-jdk rpm ruby2.4 ruby2.4-dev fonts-ipafont && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    gem install bundler && \ 
	mkdir -p /cef/automate && \
	cd /cef/automate && \
	curl 'https://chromium.googlesource.com/chromium/src/+/master/build/install-build-deps.sh?format=TEXT' | base64 -d > install-build-deps.sh && \
	chmod 755 install-build-deps.sh && \
	./install-build-deps.sh --no-prompt --no-chromeos-fonts --no-arm 
