server {
  listen 80;
  listen [::]:80;
  server_name www.example.com;

    # SSL
#    ssl on;
#    ssl_certificate /srv/www/someline.com/ssl/crt/someline_wildcard_cert_combined.crt;
#    ssl_certificate_key /srv/www/someline.com/ssl/private/someline_wildcard_private_key_no_passphrase.key;

    # Useful logs for debug.
    access_log      /srv/www/example.com/logs/access.log;
    error_log       /srv/www/example.com/logs/error.log;
    rewrite_log     on;

    location / {
      proxy_pass http://sh.example.com/;
      proxy_redirect off;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}