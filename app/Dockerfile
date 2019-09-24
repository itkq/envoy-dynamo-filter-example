FROM ruby:2.6

RUN mkdir /app

COPY Gemfile Gemfile.lock /tmp/
RUN cd /tmp && bundle install -j4 --deployment --without 'development test' --path /gems

WORKDIR /app
COPY . /app

EXPOSE 4567

CMD ["bundle", "exec", "ruby", "app.rb"]
