"""
A simple HTTP server that sleeps for 5 seconds on every request.
"""

import anyio
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    await anyio.sleep(5)
