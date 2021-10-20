#!/bin/bash
die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 2 ] || die "You must add arguments. 

Example: ./adduser.sh <login>  <password>"

docker run --rm -ti xmartlabs/htpasswd $1 $2 > ./htpasswd
