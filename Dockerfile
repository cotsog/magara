# syntax=docker/dockerfile:1.0-experimental

FROM ruby:2.5.5-alpine3.9
WORKDIR "/srv/magara"

# Create a `magara` group, and assign a `magara` user without home directory
# and password
#
# NOTE: Thanks to BusyBox, there is no long flag, so we need to add that
# -D: Don't assign password
# -H: Don't create home directory
# -G: Group
RUN addgroup magara \
    && adduser -D -G magara magara \
    && chown magara:magara -R /srv

ENV RAILS_ENV=production

RUN --mount=type=secret,id=master \
    gem install bundler --version 2.0.1 \
    && apk add --no-cache \
               build-base tzdata postgresql-dev \
               nodejs yarn git \
    && git clone --depth=1 https://github.com/magara/magara.git ../magara \
    && bundler install --jobs $( grep -c processor /proc/cpuinfo ) \
                       --without development:test \
                       --path vendor/bundle \
    && RAILS_MASTER_KEY="$(cat /run/secrets/master)" bundle exec rails assets:precompile \
    && apk del build-base yarn git \
    && chown magara:magara -R /srv

USER magara:magara

ENTRYPOINT ["bundle", "exec"]

HEALTHCHECK --interval=30s --timeout=30s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://127.0.0.1:3000 || exit 1

EXPOSE 3000
VOLUME ["/srv/magara/log"]
CMD    ["rails", "server"]
