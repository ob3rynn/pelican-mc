ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# switch to root to modify files
USER root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# switch back to container user (required for yolks)
USER container

ENTRYPOINT ["/entrypoint.sh"]