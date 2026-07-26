#!/usr/bin/env bash
set -Eeuo pipefail

export LC_ALL=C
mkdir -p results
exec > >(tee results/driver.log) 2>&1

cat parts/breakout6.py.b64.* | tr -d '\r\n' > breakout6.py.b64
base64 --decode breakout6.py.b64 > breakout6.py
printf '%s  %s\n' '3e70ac448751754dd6b0da83f384e3c4dab2ff4699eef89ed761d1dbdfca33d1' 'breakout6.py' | sha256sum --check --strict
rm breakout6.py.b64

python -m py_compile breakout6.py
python breakout6.py 2>&1 | tee results/run.log
