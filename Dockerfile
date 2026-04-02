FROM ghcr.io/pterodactyl/yolks:java_17

WORKDIR /home/container

COPY entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]