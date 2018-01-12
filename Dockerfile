FROM ruby:2.4

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get \
      install -y --no-install-recommends  \
          postgresql-client \
          nodejs \
          busybox

RUN busybox --install
RUN apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -o /sbin/wait-for-it https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && chmod +x /sbin/wait-for-it

ARG DB_ADMIN_USERNAME="ztadmin"
ARG DB_ADMIN_PASSWORD="secret"
ARG DATABASE_HOST="localhost"
ARG DATABASE_NAME="ci24siete"

WORKDIR /usr/src/app

COPY Gemfile* ./
COPY . .

RUN bundle install
RUN bundle update --source pwb

EXPOSE 3000
