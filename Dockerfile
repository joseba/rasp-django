FROM joseba/rasp-base

RUN apt-get update && \
apt-get install -yqq \
supervisor \
nginx \
gunicorn \
django \
python-openpyxl \
sqlite3 \
ca-certificates

RUN groupadd django && \
useradd -g django -s /sbin/nologin -m django

# setup all the config files
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/sites-available/default
COPY supervisord.conf /etc/supervisor/
COPY gunicorn.conf /etc/gunicorn/

# setup volume data
VOLUME /data
ENV TERM xterm

EXPOSE 8000
CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]