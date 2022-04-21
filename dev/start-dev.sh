# !/bin/bash
poetry install --no-interaction --no-ansi
uvicorn donbug:app --host 0.0.0.0 --reload
