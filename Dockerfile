FROM python:3.14-slim

ARG USERNAME=ai-ks
ARG USERUID
ARG USERGID

# 创建用户和组（UID/GID 由 tf_apply.sh 自动注入）
RUN set -eux; \
    test -n "${USERNAME}" || (echo "ERROR: missing build arg USERNAME. 运行 ./tf_apply.sh 或传入 -var username=..." >&2; exit 1); \
    test -n "${USERUID}" || (echo "ERROR: missing build arg USERUID. 运行 ./tf_apply.sh 或传入 -var user_uid=..." >&2; exit 1); \
    test -n "${USERGID}" || (echo "ERROR: missing build arg USERGID. 运行 ./tf_apply.sh 或传入 -var user_gid=..." >&2; exit 1); \
    /usr/sbin/groupadd -g "${USERGID}" "${USERNAME}"; \
    /usr/sbin/useradd -m -u "${USERUID}" -g "${USERGID}" -s /bin/sh "${USERNAME}"; \
    mkdir -p /app; \
    chown -R "${USERUID}:${USERGID}" /app

# 切换到非 root 用户
USER ${USERUID}:${USERGID}

# 默认命令
CMD ["sh", "/app/start.sh"]
