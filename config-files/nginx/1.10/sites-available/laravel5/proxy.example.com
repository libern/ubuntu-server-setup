server {
    listen 80;
    server_name someline.com www.someline.com;
    rewrite ^/(.*) https://www.someline.com/$1 permanent;
}

server {
    listen 443;
    server_name someline.com www.someline.com;

    # SSL
    ssl on;
    ssl_certificate /srv/www/someline.com/ssl/crt/someline_wildcard_cert_combined.crt;
    ssl_certificate_key /srv/www/someline.com/ssl/private/someline_wildcard_private_key_no_passphrase.key;

    location / {
      access_log off;
      proxy_pass https://wwww.someline.com;
      proxy_redirect off;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}