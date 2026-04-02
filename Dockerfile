FROM ghcr.io/pterodactyl/yolks:java_17

USER root

WORKDIR /home/container

COPY entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

USER container

ENTRYPOINT ["./entrypoint.sh"]