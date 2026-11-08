#!/usr/bin/env bash
set -u
cd "$(dirname "$0")/.."
exec > >(tee evidence/troubleshooting.log) 2>&1
set -x
docker run -d --name ia-codyseey-web-8080 ia-codyseey-web:lab
rc=$?
echo "expected-name-conflict-exit=$rc"
test "$rc" -eq 125 || exit 1
docker ps --filter name=ia-codyseey-web-8080
curl -fsS http://localhost:8080
git config --get user.name
git config --get user.email
git remote -v
