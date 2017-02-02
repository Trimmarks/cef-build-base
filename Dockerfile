FROM buildpack-deps:trusty

RUN { \
  echo 'install: --no-document'; \
  echo 'update: --no-document'; \
} >> /etc/gemrc


RUN set -x && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:brightbox/ruby-ng && \
    apt-get update && \
	apt-get install -y lsb-release sudo ninja-build p7zip-full xvfb libgtkglext1-dev locales nodejs npm openjdk-7-jdk rpm ruby2.4 ruby2.4-dev && \
	npm update -g npm && \
    npm install -g n && \
    n stable && \
    ln -sf /usr/local/bin/node /usr/bin/node && \
    ln -sf /usr/local/bin/npm /usr/bin/npm && \
    apt-get autoremove -y nodejs && \
    gem install bundler && \ 
	mkdir -p /cef/automate && \
	cd /cef/automate && \
	curl 'https://chromium.googlesource.com/chromium/src/+/master/build/install-build-deps.sh?format=TEXT' | base64 -d > install-build-deps.sh && \
	chmod 755 install-build-deps.sh && \
	./install-build-deps.sh --no-prompt --no-chromeos-fonts
