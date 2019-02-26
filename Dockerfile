# NOTE: This container is for production use which you can NOT use with cool,
# fancy, hot reload features. Also, the container requires `master.key` during
# build stage - will return some errors on `bundle exec rails assets:precompile`
FROM    ruby:2.5-alpine
WORKDIR "/usr/src/app"

ENV RAILS_ENV=production

COPY . .

# TODO: Container is exposed master.key when we build it; however, of course, it
# doesn't return any error while it is building. Try to use some placeholders
# for when it will be used for production
RUN gem install bundler -v 2.0.1 \
    && apk add --no-cache \
            build-base tzdata postgresql-dev \
            nodejs yarn \
    && bundle --jobs $( grep -c processor /proc/cpuinfo ) \
              --without development:test \
              --path vendor/bundle \
    && bundle exec rails assets:precompile \
    && apk del build-base yarn

ENTRYPOINT ["bundle", "exec"]

EXPOSE 3000
VOLUME ["/usr/src/app/log"]
CMD    ["rails", "server"]
