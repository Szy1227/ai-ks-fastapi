from fastapi import FastAPI

VERSION = "1.0.0"

app = FastAPI()


@app.get("/")
def read_root():
    return {"message": "hello fastapi"}


@app.get("/api/version")
def get_version():
    return {"version": VERSION}
