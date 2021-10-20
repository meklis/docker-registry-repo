#!/bin/bash
die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "You must set domain as argument

Example: ./request-ssl.sh <domain>"


docker stop registry-ui
sudo docker run -it --rm --name certbot \
    -v $(pwd)"/letsencrypt/etc:/etc/letsencrypt" \
    -v $(pwd)"/letsencrypt/lib:/var/lib/letsencrypt"  \
    -p "80:80" \
    -p "443:443" \
    certbot/certbot certonly --standalone -n -d $1

cp $(pwd)/letsencrypt/etc/live/**/*.pem $(pwd)/conf/nginx

docker start registry-ui
