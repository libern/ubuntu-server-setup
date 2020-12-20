server {
  listen 80;
  listen [::]:80;
  listen 443 default_server;
  listen [::]:443 default_server;
  server_name www.example.com example.com *.example.com;

    # SSL
    ssl on;
    ssl_certificate /srv/www/example.com/ssl/example.crt;
    ssl_certificate_key /srv/www/example.com/ssl/example.key;

    # Useful logs for debug.
    access_log      /srv/www/example.com/logs/access.log;
    error_log       /srv/www/example.com/logs/error.log;
    rewrite_log     on;

    location / {
      proxy_pass https://real-server.example.com/;
      proxy_redirect off;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
