#!/usr/bin/env sh
set -eu

pip install --no-cache-dir -r requirements.txt 2>&1 | tee -a run.log
uvicorn main:app --host 0.0.0.0 --port 8000 2>&1 | tee -a run.log
