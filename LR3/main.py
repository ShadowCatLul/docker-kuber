
from fastapi import FastAPI
from app.routers import router
from app.database import engine, Base


Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Users",
    description="users database",
    docs_url="/"
)

app.include_router(router, prefix='/user', tags=["user"])


