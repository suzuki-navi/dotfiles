if [ -n "${HTTP_PROXY:-}" ]; then
    npm -g config set       proxy $HTTP_PROXY
fi
if [ -n "${HTTPS_PROXY:-}" ]; then
    npm -g config set https-proxy $HTTPS_PROXY
fi
