# heavily borrowed from https://elixirforum.com/t/cannot-find-libtinfo-so-6-when-launching-elixir-app/24101/11?u=sigu
FROM elixir:1.14-otp-25 AS app_builder

ARG env=prod

ENV LANG=C.UTF-8 \
   TERM=xterm \
   MIX_ENV=$env

RUN mkdir /opt/release
WORKDIR /opt/release

RUN mix local.hex --force && mix local.rebar --force

COPY mix.exs .
COPY mix.lock .
RUN mix deps.get && mix deps.compile

COPY assets ./assets
COPY config ./config
COPY lib ./lib
COPY priv ./priv

RUN mix release

FROM debian:buster-slim AS app

RUN apt-get update && apt-get install -y openssl

RUN useradd --create-home app
WORKDIR /home/app
COPY --from=app_builder /opt/release/_build/ .
RUN chown -R app: ./prod
USER app

CMD ["./prod/rel/openc_c2_test/bin/openc_c2_test", "start"]