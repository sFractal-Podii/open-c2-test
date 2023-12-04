# heavily borrowed from https://elixirforum.com/t/cannot-find-libtinfo-so-6-when-launching-elixir-app/24101/11?u=sigu
FROM hexpm/elixir:1.15.4-erlang-25.2.3-debian-bullseye-20230612 AS app_builder

ARG env=prod


ENV LANG=C.UTF-8 \
   TERM=xterm \
   MIX_ENV=$env

RUN mkdir /opt/release
WORKDIR /opt/release

RUN mix local.hex --force && mix local.rebar --force

RUN curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

COPY mix.exs .
COPY mix.lock .
RUN mix deps.get && mix deps.compile

COPY assets ./assets
COPY config ./config
COPY lib ./lib
COPY priv ./priv

RUN mix sbom.install
RUN mix sbom.cyclonedx
RUN mix sbom.convert

# make sbom for the production docker image
RUN syft debian:bullseye-slim -o spdx > debian.buster_slim-spdx-bom.spdx
RUN syft debian:bullseye-slim -o spdx-json > debian.buster_slim-spdx-bom.json
RUN syft debian:bullseye-slim -o cyclonedx-json > debian.buster_slim-cyclonedx-bom.json
RUN syft debian:bullseye-slim -o cyclonedx > debian.buster_slim-cyclonedx-bom.xml

RUN cp *bom* ./priv/static/.well-known/sbom/

RUN mix assets.deploy
RUN mix release

FROM debian:bullseye-slim AS app

ARG CLIENT_ID=openc2test2023
ARG MQTT_HOST="broker.emqx.io"
ARG MQTT_PORT=1883
ARG USER_NAME=plug
ARG PASSWORD=fest


ENV LANG=C.UTF-8
ENV CLIENT_ID=$CLIENT_ID
ENV MQTT_HOST=$MQTT_HOST
ENV MQTT_PORT=$MQTT_PORT
ENV USER_NAME=$USER_NAME
ENV PASSWORD=$PASSWORD

ENV LANG=C.UTF-8


RUN useradd --create-home app
WORKDIR /home/app
COPY --from=app_builder /opt/release/_build/ .
RUN chown -R app: ./prod
USER app

CMD ["./prod/rel/openc_c2_test/bin/openc_c2_test", "start"]
