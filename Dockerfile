FROM ruby:3.0.0

ENV TZ="Europe/Paris"
RUN apt-get update -qq && apt-get install -y sqlite3 libsqlite3-dev
RUN gem install bundler --no-document -v 2.3.9 
RUN gem install nokogiri --platform=ruby
RUN bundle config set force_ruby_platform true

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# INFO: if you need to install libssl1.1 here is a link, https://mirror.sit.fraunhofer.de/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1l-1ubuntu1.2_amd64.deb