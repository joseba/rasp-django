FROM joseba/rasp-base

RUN apt-get update && \
apt-get install -yqq \
python-pip \
python-wheel \
nginx \
sqlite3 \
ca-certificates

# install python packages
RUN pip install supervisor \
gunicorn \
django \
openpyxl \
pytz

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
