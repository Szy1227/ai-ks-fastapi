#!/usr/bin/env sh
set -eu

uvicorn main:app --host 0.0.0.0 --port 8000 --reload 2>&1 | tee -a run.log
