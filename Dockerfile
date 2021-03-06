FROM boky/postfix:v1.1.3

RUN apk add --no-cache bash

## Add dogfish
#COPY dogfish/ /usr/share/dogfish
#COPY migrations/ /usr/share/dogfish/shell-migrations
#RUN ln -s /usr/share/dogfish/dogfish /usr/bin/dogfish
#RUN mkdir /var/lib/dogfish 
## Need to do this all together because ultimately, the config folder is a volume, and anything done in there will be lost. 
#RUN mkdir -p /var/www/html/config/ && touch /var/www/html/config/migrations.log && ln -s /var/www/html/config/migrations.log /var/lib/dogfish/migrations.log 

### Set up the CMD as well as the pre and post hooks.
COPY go-init /bin/go-init
COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY exitpoint.sh /usr/bin/exitpoint.sh

ENTRYPOINT ["go-init"]
CMD ["-main", "/usr/bin/entrypoint.sh /run.sh ", "-post", "/usr/bin/exitpoint.sh"]
