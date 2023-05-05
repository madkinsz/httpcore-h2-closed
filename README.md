# Reproduction for HTTP/2 issues with encode/httpcore

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