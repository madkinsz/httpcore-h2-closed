#!/usr/bin/env bash

set -xeo

# Cleanup any running containers
docker rm --force nginx-proxy || echo "No container to remove"

# Start a container
docker run -d -p 433:433 --name nginx-proxy nginx:latest 

# Create certificates
docker exec -it nginx-proxy bash -c '                          
curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
chmod +x mkcert-v*-linux-amd64                
cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert
mkcert -install          
mkcert localhost'

# Set up nginx
docker exec -it nginx-proxy bash -c 'cat > /etc/nginx/nginx.conf <<EOF

events {
    worker_connections 1024;
}

http {                        
    # SSL certificate settings
    ssl_certificate /localhost.pem;
    ssl_certificate_key /localhost-key.pem;

    server {                                   
        listen 433 ssl http2;
        server_name localhost;                                        

        location / {              
            proxy_pass http://host.docker.internal:8080;
        }
    }                       
}
EOF
nginx -s reload'

# Monitor the container
docker logs -f nginx-proxy