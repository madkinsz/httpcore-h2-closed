# Reproduction for HTTP/2 issues with encode/httpcore

Here we reproduce an issue where HTTP/2 connections are not removed from the httpcore connection pool when closed.

A NGINX proxy is used to serve HTTP/2 requests with a simple HTTP/1.1 backing server.

## Usage

Install requirments
```
pip install -r requirements.txt
```

Start the server
```
uvicorn --port 8080 server:app
```

Start the proxy (requires Docker)
```
./proxy.sh
```

Start the client
```
python client.py
```

Reset the proxy
```
./reset-proxy.sh
```