#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(dirname "$0")/.."
exec > >(tee evidence/audit.log) 2>&1
set -x
date -Is
cat /etc/os-release
bash --version
git --version
docker --version
docker info
docker images
docker run --rm hello-world
docker run --name ia-codyseey-audit-exit ubuntu bash -c 'pwd; ls; echo main-process-done'
docker inspect ia-codyseey-audit-exit --format '{{.State.Status}} {{.State.ExitCode}}'
docker run -d --init --name ia-codyseey-audit-exec ubuntu sleep infinity
docker exec ia-codyseey-audit-exec bash -c 'pwd; ls; echo extra-process-done'
docker inspect ia-codyseey-audit-exec --format '{{.State.Status}}'
docker stop ia-codyseey-audit-exec
docker inspect ia-codyseey-audit-exec --format '{{.State.Status}} {{.State.ExitCode}}'
docker logs ia-codyseey-web-8080
docker stats --no-stream ia-codyseey-web-8080 ia-codyseey-web-8081
docker ps -a
git config init.defaultBranch main
git config --list
git branch --show-current
docker rm ia-codyseey-audit-exit ia-codyseey-audit-exec
