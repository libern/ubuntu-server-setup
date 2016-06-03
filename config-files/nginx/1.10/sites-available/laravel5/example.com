server {

    # Port that the web server will listen on.
    listen          80;
    #listen          443;

    # SSL
    #ssl on;
    #ssl_certificate /srv/www/example.com/ssl/crt/cert_combined.crt;
    #ssl_certificate_key /srv/www/example.com/ssl/private/private_key_no_passphrase.key;

    client_max_body_size 29M;

    root /srv/www/example.com/appletree/public;
    index index.php index.html index.htm;

    server_name example.com;
    #server_name _ example.com;

    # Useful logs for debug.
    access_log      /srv/www/example.com/logs/access.log;
    error_log       /srv/www/example.com/logs/error.log;
    rewrite_log     on;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
            include snippets/fastcgi-php.conf;

    #       # With php7.0-cgi alone:
    #       fastcgi_pass 127.0.0.1:9000;
    #       # With php7.0-fpm:
            fastcgi_pass unix:/run/php/php7.0-fpm.sock;
    }

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    location ~ /\.ht {
            deny all;
    }

}
