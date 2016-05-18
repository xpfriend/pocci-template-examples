FROM htdvisser/taiga-back:stable

COPY ./taiga-settings /tmp/

RUN cd /usr/local/taiga/taiga-back/ \
    && pip install git+https://github.com/ototadana/taiga-contrib-ldap-auth.git \
    && cat /tmp/taiga-settings >> ./settings/local.py \
    && rm /tmp/taiga-settings
