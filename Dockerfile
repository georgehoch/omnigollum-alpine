FROM ruby:alpine3.9
MAINTAINER Georg Hoch <ghoch+omnigollum-alpine@mailbox.org>

# The default mirror (dl-cdn.alpinelinux.org) has issues sometimes for me
# More mirrors available here: mirrors.alpinelinux.org
RUN echo "https://dl-4.alpinelinux.org/alpine/v3.9/main" >/etc/apk/repositories && \
    echo "https://dl-4.alpinelinux.org/alpine/v3.9/community" >>/etc/apk/repositories
RUN apk update
RUN apk add --no-cache --virtual build-deps build-base
RUN apk add --no-cache icu-dev icu-libs
RUN apk add --no-cache cmake
RUN apk add --no-cache git
RUN apk add --no-cache openssl-dev

RUN gem install redcarpet github-markdown
RUN gem install omniauth-github github-markup
RUN gem install github-markdown

RUN gem install gollum
RUN gem install omnigollum

RUN apk del cmake build-base build-deps icu-dev

# create a volume and
WORKDIR /wiki

ENTRYPOINT ["/bin/sh", "-c", "git init && gollum --port 8080 --live-preview"]
EXPOSE 8080
