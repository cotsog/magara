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

COPY --chown=magara:magara . .

ENV RAILS_ENV=production

RUN gem install bundler --version 2.0.1 \
    && apk add --no-cache \
               build-base tzdata postgresql-dev \
               nodejs yarn \
    && bundler install --jobs $( grep -c processor /proc/cpuinfo ) \
                       --without development:test \
                       --path vendor/bundle

RUN bundle exec rails assets:precompile \
    && apk del build-base yarn \
    && chown magara:magara -R /srv

USER magara:magara

ENTRYPOINT ["bundle", "exec"]

EXPOSE 3000
VOLUME ["/srv/magara/log"]
CMD    ["rails", "server"]
