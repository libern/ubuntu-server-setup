server {
  listen [::]:80;
  server_name *.site.example.com;

    # SSL
#    ssl on;
#    ssl_certificate /srv/www/example.com/ssl/crt/example_wildcard_cert_combined.crt;
#    ssl_certificate_key /srv/www/example.com/ssl/private/example_wildcard_private_key_no_passphrase.key;

    # Useful logs for debug.
    access_log      /srv/www/example.com/logs/access.log;
    error_log       /srv/www/example.com/logs/error.log;
    rewrite_log     on;

    location / {
      proxy_pass http://site.example.com/;
      proxy_redirect off;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}