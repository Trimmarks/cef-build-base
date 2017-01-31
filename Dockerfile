FROM ruby:2.4

RUN set -x && \
	apt-get update && \
	apt-get install -y lsb-release sudo ninja-build p7zip-full xvfb libgtkglext1-dev locales nodejs npm openjdk-7-jdk && \
	npm update -g npm && \
    npm install -g n && \
    n stable && \
    ln -sf /usr/local/bin/node /usr/bin/node && \
    ln -sf /usr/local/bin/npm /usr/bin/npm && \
    apt-get autoremove -y nodejs && \
	mkdir -p /cef/automate && \
	cd /cef/automate && \
	curl 'https://chromium.googlesource.com/chromium/src/+/master/build/install-build-deps.sh?format=TEXT' | base64 -d > install-build-deps.sh && \
	chmod 755 install-build-deps.sh && \
	./install-build-deps.sh --no-prompt --no-chromeos-fonts
