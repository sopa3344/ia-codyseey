#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(dirname "$0")/.."
for name in ia-codyseey-web-8080 ia-codyseey-web-8081 ia-codyseey-volume-before ia-codyseey-volume-after; do
  if docker container inspect "$name" >/dev/null 2>&1; then
    echo "이미 있는 실습 컨테이너입니다: $name. README의 '이미 만든 결과 보기'를 사용하세요."
    exit 1
  fi
done
if docker volume inspect ia-codyseey-data >/dev/null 2>&1; then
  echo '기존 ia-codyseey-data 볼륨을 보존하기 위해 중단했습니다. 새 환경에서 실행하세요.'
  exit 1
fi
mkdir -p evidence
exec > >(tee evidence/lab.log) 2>&1
set -x
date -Is
whoami
uname -r
docker version
if docker container inspect exec-practice >/dev/null 2>&1; then
  docker inspect exec-practice --format '{{json .State}}'
fi
LAB=$(mktemp -d /tmp/ia-codyseey-cli.XXXXXX)
cd "$LAB"
pwd
mkdir documents
touch original.txt .hidden
echo 'Hello Linux' > original.txt
cat original.txt
cp original.txt copy.txt
mv copy.txt documents/renamed.txt
ls -la
cat documents/renamed.txt
rm documents/renamed.txt
test ! -e documents/renamed.txt
rmdir documents
printf '#!/bin/sh\necho executable-ok\n' > hello.sh
chmod 644 hello.sh
stat -c '%a %n' hello.sh
if ./hello.sh; then exit 1; else echo 'EXPECTED: no execute permission'; fi
chmod 755 hello.sh
./hello.sh
mkdir private
chmod 755 private
stat -c '%a %n' private
chmod 700 private
stat -c '%a %n' hello.sh private
cd -
docker build --progress plain -t ia-codyseey-web:lab .
docker image inspect ia-codyseey-web:lab --format '{{.Id}}'
docker run -d --name ia-codyseey-web-8080 -p 127.0.0.1:8080:80 ia-codyseey-web:lab
mkdir -p bind-site
cp site/index.html bind-site/index.html
docker run -d --name ia-codyseey-web-8081 -p 127.0.0.1:8081:80 --mount "type=bind,source=$PWD/bind-site,target=/usr/share/nginx/html,readonly" ia-codyseey-web:lab
curl --retry 10 --retry-connrefused --retry-delay 1 -fsS http://localhost:8080 | tee evidence/8080.html
curl --retry 10 --retry-connrefused --retry-delay 1 -fsS http://localhost:8081 | tee evidence/bind-before.html
sed -i 's/IMAGE_VERSION_1/BIND_VERSION_2/' bind-site/index.html
curl -fsS http://localhost:8081 | tee evidence/bind-after.html
grep BIND_VERSION_2 evidence/bind-after.html
curl -fsS http://localhost:8080 | grep IMAGE_VERSION_1
docker stats --no-stream ia-codyseey-web-8080 ia-codyseey-web-8081
docker port ia-codyseey-web-8080
docker port ia-codyseey-web-8081
docker volume create ia-codyseey-data
docker run --name ia-codyseey-volume-before --mount type=volume,source=ia-codyseey-data,target=/data ubuntu sh -c 'echo persistent-value-20261108 > /data/proof.txt; cat /data/proof.txt; sha256sum /data/proof.txt'
docker rm ia-codyseey-volume-before
docker volume inspect ia-codyseey-data
docker run --name ia-codyseey-volume-after --mount type=volume,source=ia-codyseey-data,target=/data ubuntu sh -c 'cat /data/proof.txt; sha256sum /data/proof.txt; test "$(cat /data/proof.txt)" = persistent-value-20261108'
docker rm ia-codyseey-volume-after
docker ps -a
echo 'ALL_LAB_CHECKS_PASSED'
