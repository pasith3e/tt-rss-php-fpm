# tt-rss-php-fpm
Creates Docker images for [tt-rss](https://tt-rss.org/).

Also runs a Cron Job to update rss feed's every 15 minutes.

Docker-Compose example:
```yaml
version: '3'
services:
 rss_nginx:
  container_name: rss_nginx
  image: "nginx:mainline-alpine"
  restart: always
  volumes:
   - ./nginx.conf:/etc/nginx/nginx.conf:ro  
   - ./doc_root:/var/www/:rw
  networks:
   rss_net:
    ipv4_address: 172.23.165.50
  extra_hosts:
  - "rss_postgres:172.23.165.51"
  - "rss_php_fpm:172.23.165.52"

 rss_php_fpm:
  container_name: rss_php_fpm
  image: "rss_php_fpm:latest"
  restart: always
  volumes:
   - ./doc_root:/var/www/:rw
  networks:
   rss_net:
    ipv4_address: 172.23.165.52
  extra_hosts:
  - "rss_postgres:172.23.165.51"

 rss_postgres:
  container_name: rss_postgres
  image: "postgres:11.2-alpine"
  restart: always
  volumes:
   - ./postgresql:/var/lib/postgresql/data
  environment:
    POSTGRES_PASSWORD: change_me
    POSTGRES_DB: rrsdb
    POSTGRES_USER: rrsuser
  networks:
   rss_net:
    ipv4_address: 172.23.165.51
 ```
