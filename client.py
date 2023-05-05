from httpx import AsyncClient
import anyio
import traceback


async def main():
    async with AsyncClient(verify=False, timeout=60, http2=True) as client:
        for _ in range(10):
            print("Making request")
            try:
                (await client.get("https://localhost:433/")).raise_for_status()
            except Exception as exc:
                print("Encountered error", exc)
                traceback.print_exc()
            else:
                print("Success")

anyio.run(main)
