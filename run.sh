#!/bin/sh

UPSTREAM=${UPSTREAM}
ROUTE=${ROUTE}
if [ -z ${UPSTREAM} ]; then 
    echo "please provide the UPSTREAM server name (e.g. myfn-fn-api.default)"
    exit 1
fi

if [ -z ${ROUTE} ]; then
    echo "please provide the function route (e.g. r/app/v2)"
    exit 1
fi

echo "creating nginx.conf proxying to http://$UPSTREAM/$ROUTE"

cp nginx.conf.templ nginx.conf

sed -i "s@%UPSTREAM%@$UPSTREAM@g" nginx.conf
sed -i "s@%ROUTE%@$ROUTE@g" nginx.conf

cat nginx.conf
echo .
cp nginx.conf /etc/nginx/nginx.conf

# Test the config, run it and exit if anything fails
nginx -t
nginx

tail -f /dev/null