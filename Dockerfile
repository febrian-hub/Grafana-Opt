FROM grafana/grafana:latest

USER root

ENV GF_SERVER_APP_TITLE="Optimaxx Analysis Platform" \
    GF_AUTH_ANONYMOUS_ENABLED=true \
    GF_PANELS_DISABLE_SANITIZE_HTML=true \
    GF_ANALYTICS_CHECK_FOR_UPDATES=false \
    GF_SNAPSHOTS_ENABLED=false \
    GF_EXPLORE_ENABLED=false \
    GF_NEWS_NEWS_FEED_ENABLED=false

COPY opt-logo.svg /usr/share/grafana/public/img/grafana_icon.svg
COPY opt-logo.svg /usr/share/grafana/public/img/grafana_logo.svg
COPY fav32.png /usr/share/grafana/public/img/fav32.png
COPY fav32.png /usr/share/grafana/public/img/apple-touch-icon.png
COPY bg-login.svg /usr/share/grafana/public/img/login_background_dark.svg
COPY bg-login.svg /usr/share/grafana/public/img/login_background_light.svg
COPY bg-login.svg /usr/share/grafana/public/img/g8_login_dark.svg
COPY bg-login.svg /usr/share/grafana/public/img/g8_login_light.svg

RUN echo "=== STARTING AGGRESSIVE REBRANDING ===" && \
    find /usr/share/grafana/public/build -name "*.js" -exec sed -i 's/Welcome to Grafana/Optimaxx IIoT Dashboard/g' {} + && \
    sed -i 's|Loading Grafana|Loading Optimaxx|g' /usr/share/grafana/public/views/index.html && \
    find /usr/share/grafana/public/build -name "*.js" -exec sed -i 's|" - Grafana"|" - Optimaxx"|g' {} + && \
    find /usr/share/grafana/public/build -name "*.js" -exec sed -i "s|' - Grafana'|' - Optimaxx'|g" {} + && \
    find /usr/share/grafana/public/build -name "*.js" -exec sed -i 's|AppTitle="Grafana"|AppTitle="Optimaxx"|g' {} + && \
    find /usr/share/grafana/public/build -name "*.js" -exec sed -i 's|\[{target:"_blank",id:"documentation".*license"}\]|[]|g' {} + || true

RUN sed -i 's|</head>|<style>footer, [class*="footer"], .help-modal, button[aria-label*="Help"] {display: none !important;} #mega-menu-header-toggle ~ span {display: none !important;}</style></head>|g' /usr/share/grafana/public/views/index.html

USER grafana
