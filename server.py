import anyio
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    await anyio.sleep(5)
