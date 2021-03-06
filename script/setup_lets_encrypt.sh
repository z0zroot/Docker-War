#!/bin/bash

#    The Star And Thank Author License (SATA)
#
#    Copyright (c) 2014-2016 Lobsiinvok (lobsiinvok@tdohacker.org)
#
#    Project Url: https://github.com/qazbnm456/Docker-War
#
#    Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software and associated documentation files (the "Software"), to deal
#    in the Software without restriction, including without limitation the rights
#    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#    copies of the Software, and to permit persons to whom the Software is
#    furnished to do so, subject to the following conditions:
#
#    The above copyright notice and this permission notice shall be included in
#    all copies or substantial portions of the Software.
#
#    And wait, the most important, you shall star/+1/like the project(s) in project url
#    section above first, and then thank the author(s) in Copyright section.
#
#    Here are some suggested ways:
#
#     - Email the authors a thank-you letter, and make friends with him/her/them.
#     - Report bugs or issues.
#     - Tell friends what a wonderful project this is.
#     - And, sure, you can just express thanks in your mind without telling the world.
#
#    Contributors of this project by forking have the option to add his/her name and
#    forked project url at copyright and project url sections, but shall not delete
#    or modify anything else in these two sections.
#
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#    THE SOFTWARE.

# #########################
#     value
# #########################
set -e

curl -h >/dev/null 2>&1 || { echo >&2 "Curl is needed but I cannot find that. Aborting."; exit 1; }
openssl -h >/dev/null 2>&1 || { echo >&2 "Openssl is needed but I cannot find that. Aborting."; exit 1; }

PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $PWD \
    && git clone https://github.com/lukas2511/letsencrypt.sh.git \
    && cd letsencrypt.sh && echo domain.com > domains.txt \
    && mkdir -p /home/app/project_name/public/.well-known/acme-challenge \
    && mv /home/app/config.sh . \
    && echo "Enable the http endpoint" \
    && ln -s /etc/nginx/sites-available/http_nginx.conf /etc/nginx/sites-enabled/http_nginx.conf \
    && echo "Reload nginx service..." \
    && service nginx reload \
    && echo "Generate Letsencrypt SSL certificates" \
    && ./letsencrypt.sh -c \
    && echo "Enable the https endpoint" \
    && ln -s /etc/nginx/sites-available/https_nginx.conf /etc/nginx/sites-enabled/https_nginx.conf \
    && echo "Reload nginx service..." \
    && service nginx reload \
    && /home/app/project_name/script/setup_sqlchop_proxy.sh &