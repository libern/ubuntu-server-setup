server {

    # Port that the web server will listen on.
    listen 80;

    # Host that will serve this project.
    server_name example.com www.example.com;

    # Redirect HTTP to HTTPS
    rewrite ^/(.*) https://example.com/$1 permanent;

}

server {

    # Port that the web server will listen on.
    listen          443;

    ssl on;
    ssl_certificate /srv/www/example.com/ssl/crt/wildcard_cert_combined.crt;
    ssl_certificate_key /srv/www/example.com/ssl/private/private_key_no_passphrase.key;

    # Host that will serve this project.
    server_name www.example.com;

    # Redirect HTTPS to HTTPS
    rewrite ^/(.*) https://example.com/$1 permanent;

}

server {

    # Port that the web server will listen on.
    listen          443;

    ssl on;
    ssl_certificate /srv/www/example.com/ssl/crt/wildcard_cert_combined.crt;
    ssl_certificate_key /srv/www/example.com/ssl/private/private_key_no_passphrase.key;

    client_max_body_size 29M;

    root /srv/www/example.com/laravel/public;
    index index.php index.html index.htm;

    server_name example.com;

    # Redirect all urls that starts with /index.php/* to /*
    rewrite ^/index.php/(.*)$ /$1 permanent;

    # Useful logs for debug.
    access_log      /srv/www/example.com/logs/access.log;
    error_log       /srv/www/example.com/logs/error.log;
    rewrite_log     on;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
            include snippets/fastcgi-php.conf;

    #       # With php7.1-cgi alone:
    #       fastcgi_pass 127.0.0.1:9000;
    #       # With php7.1-fpm:
            fastcgi_pass unix:/run/php/php7.1-fpm.sock;
    }
}
