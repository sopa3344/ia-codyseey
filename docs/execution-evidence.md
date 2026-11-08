# 실제 실행 기록

2026-11-08 실제 PC의 출력입니다. `+`로 시작하는 줄은 Bash가 기록한 명령이고, 다음 줄은 실제 출력입니다. 오래된 실행의 컨테이너 ID와 측정값은 현재 상태와 다를 수 있습니다.

## 첫 실습: 파일부터 볼륨까지

```text
+ date -Is
2026-11-08T22:32:13+09:00
+ whoami
developer
+ uname -r
6.18.54.1-microsoft-standard-WSL2
+ docker version
Client:
 Version:           29.9.2
 API version:       1.56
 Go version:        go1.26.10
 Git commit:        a82e528
 Built:             Tue Oct 20 18:44:02 2026
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Desktop 4.98.0 (245422)
 Engine:
  Version:          29.9.2
  API version:      1.56 (minimum version 1.40)
  Go version:       go1.26.10
  Git commit:       0367cbe
  Built:            Tue Oct 20 18:45:02 2026
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v2.4.2
  GitCommit:        b7a25261e029d68978bbf290df0a62fc819b3c51
 runc:
  Version:          1.5.2
  GitCommit:        v1.5.2-0-g29dd3dc2
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
+ docker inspect exec-practice --format '{{json .State}}'
{"Status":"exited","Running":false,"Paused":false,"Restarting":false,"OOMKilled":false,"Dead":false,"Pid":0,"ExitCode":137,"Error":"","StartedAt":"2026-11-08T13:11:55.611106783Z","FinishedAt":"2026-11-08T13:18:24.985241642Z"}
++ mktemp -d /tmp/ia-codyseey-cli.XXXXXX
+ LAB=/tmp/ia-codyseey-cli.6e9T1K
+ cd /tmp/ia-codyseey-cli.6e9T1K
+ pwd
/tmp/ia-codyseey-cli.6e9T1K
+ mkdir documents
+ touch original.txt .hidden
+ echo 'Hello Linux'
+ cat original.txt
Hello Linux
+ cp original.txt copy.txt
+ mv copy.txt documents/renamed.txt
+ ls -la
total 4
drwx------ 3 developer developer 100 Nov  8 22:32 .
drwxrwxrwt 8 root      root      160 Nov  8 22:32 ..
-rw-r--r-- 1 developer developer   0 Nov  8 22:32 .hidden
drwxr-xr-x 2 developer developer  60 Nov  8 22:32 documents
-rw-r--r-- 1 developer developer  12 Nov  8 22:32 original.txt
+ cat documents/renamed.txt
Hello Linux
+ rm documents/renamed.txt
+ test '!' -e documents/renamed.txt
+ rmdir documents
+ printf '#!/bin/sh\necho executable-ok\n'
+ chmod 644 hello.sh
+ stat -c '%a %n' hello.sh
644 hello.sh
+ ./hello.sh
work/ia-codyseey/scripts/lab.sh: line 29: ./hello.sh: Permission denied
+ echo 'EXPECTED: no execute permission'
EXPECTED: no execute permission
+ chmod 755 hello.sh
+ ./hello.sh
executable-ok
+ mkdir private
+ chmod 755 private
+ stat -c '%a %n' private
755 private
+ chmod 700 private
+ stat -c '%a %n' hello.sh private
755 hello.sh
700 private
+ cd -
/mnt/c/Users/gamed/Documents/Codex/2026-11-08/referenced-chatgpt-conversation-this-is-an/work/ia-codyseey
+ docker build --progress plain -t ia-codyseey-web:lab .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 126B 0.0s done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/nginx:stable-alpine
#2 ...

#3 [auth] library/nginx:pull token for registry-1.docker.io
#3 DONE 0.0s

#2 [internal] load metadata for docker.io/library/nginx:stable-alpine
#2 DONE 2.2s

#4 [internal] load .dockerignore
#4 transferring context: 72B 0.0s done
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 222B 0.0s done
#5 DONE 0.0s

#6 [1/2] FROM docker.io/library/nginx:stable-alpine@sha256:583b7f2fce1cdb8da5ad5c39ebd3c33b98b87d493190e548bdee1fa8c619c311
#6 resolve docker.io/library/nginx:stable-alpine@sha256:583b7f2fce1cdb8da5ad5c39ebd3c33b98b87d493190e548bdee1fa8c619c311 0.0s done
#6 DONE 0.1s

#6 [1/2] FROM docker.io/library/nginx:stable-alpine@sha256:583b7f2fce1cdb8da5ad5c39ebd3c33b98b87d493190e548bdee1fa8c619c311
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 0B / 20.32MB 0.2s
#6 sha256:d04b4ed66a450f2c2675e1c80127ba32721eeda72aaac8709d6ff707ccf90070 0B / 1.40kB 0.2s
#6 sha256:c12ffff18732349750d8928e649e2333d19363a2a201978b1876c80f38aaf292 0B / 1.21kB 0.2s
#6 sha256:0e13a8a92b02d6d710028ebada164686467e25ddff8907ae28a80bafc26bbee4 0B / 403B 0.2s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 2.10MB / 20.32MB 0.5s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 4.19MB / 20.32MB 0.6s
#6 sha256:d04b4ed66a450f2c2675e1c80127ba32721eeda72aaac8709d6ff707ccf90070 1.40kB / 1.40kB 0.5s done
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 6.29MB / 20.32MB 0.8s
#6 sha256:c12ffff18732349750d8928e649e2333d19363a2a201978b1876c80f38aaf292 1.21kB / 1.21kB 0.7s done
#6 sha256:0e13a8a92b02d6d710028ebada164686467e25ddff8907ae28a80bafc26bbee4 403B / 403B 0.7s done
#6 sha256:163ee6b178c7d7aa60ef7115424399a0ccb8f293e43f6b35cd6df8f152698c6a 0B / 964B 0.2s
#6 sha256:163ee6b178c7d7aa60ef7115424399a0ccb8f293e43f6b35cd6df8f152698c6a 964B / 964B 0.3s done
#6 sha256:89fcb8c382892a31f2b913ee3e11af133e228ec75e84351e4f848d6f83c0b56e 0B / 627B 0.2s
#6 sha256:52eb9c26a93672fd16d692befd22944ee26a59772beff8c775b37c684b0da36f 0B / 1.88MB 0.2s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 7.34MB / 20.32MB 0.9s
#6 sha256:89fcb8c382892a31f2b913ee3e11af133e228ec75e84351e4f848d6f83c0b56e 627B / 627B 0.2s done
#6 sha256:881fc932939efef04ca120ad44bbd2c0917851eb247aa4995428afb1e80ede17 0B / 3.85MB 0.2s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 9.44MB / 20.32MB 1.1s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 10.49MB / 20.32MB 1.2s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 11.53MB / 20.32MB 1.4s
#6 sha256:52eb9c26a93672fd16d692befd22944ee26a59772beff8c775b37c684b0da36f 1.05MB / 1.88MB 0.6s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 12.58MB / 20.32MB 1.5s
#6 sha256:52eb9c26a93672fd16d692befd22944ee26a59772beff8c775b37c684b0da36f 1.88MB / 1.88MB 0.8s done
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 14.68MB / 20.32MB 1.7s
#6 sha256:881fc932939efef04ca120ad44bbd2c0917851eb247aa4995428afb1e80ede17 1.05MB / 3.85MB 0.9s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 15.73MB / 20.32MB 1.8s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 16.78MB / 20.32MB 2.0s
#6 sha256:881fc932939efef04ca120ad44bbd2c0917851eb247aa4995428afb1e80ede17 2.10MB / 3.85MB 1.2s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 18.87MB / 20.32MB 2.1s
#6 sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 20.32MB / 20.32MB 2.3s done
#6 sha256:881fc932939efef04ca120ad44bbd2c0917851eb247aa4995428afb1e80ede17 3.15MB / 3.85MB 1.7s
#6 sha256:881fc932939efef04ca120ad44bbd2c0917851eb247aa4995428afb1e80ede17 3.85MB / 3.85MB 1.8s done
#6 extracting sha256:881fc932939efef04ca120ad44bbd2c0917851eb247aa4995428afb1e80ede17 0.1s done
#6 DONE 2.8s

#6 [1/2] FROM docker.io/library/nginx:stable-alpine@sha256:583b7f2fce1cdb8da5ad5c39ebd3c33b98b87d493190e548bdee1fa8c619c311
#6 extracting sha256:52eb9c26a93672fd16d692befd22944ee26a59772beff8c775b37c684b0da36f 0.1s done
#6 DONE 3.0s

#6 [1/2] FROM docker.io/library/nginx:stable-alpine@sha256:583b7f2fce1cdb8da5ad5c39ebd3c33b98b87d493190e548bdee1fa8c619c311
#6 extracting sha256:89fcb8c382892a31f2b913ee3e11af133e228ec75e84351e4f848d6f83c0b56e 0.0s done
#6 extracting sha256:163ee6b178c7d7aa60ef7115424399a0ccb8f293e43f6b35cd6df8f152698c6a 0.0s done
#6 extracting sha256:0e13a8a92b02d6d710028ebada164686467e25ddff8907ae28a80bafc26bbee4 0.0s done
#6 extracting sha256:c12ffff18732349750d8928e649e2333d19363a2a201978b1876c80f38aaf292 0.0s done
#6 extracting sha256:d04b4ed66a450f2c2675e1c80127ba32721eeda72aaac8709d6ff707ccf90070 0.0s done
#6 extracting sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d
#6 extracting sha256:4fd2a979a136065b9518cac19c8f3d11f2251813831dc2d18a4edb1d1b26374d 0.4s done
#6 DONE 3.4s

#7 [2/2] COPY site/index.html /usr/share/nginx/html/index.html
#7 DONE 0.1s

#8 exporting to image
#8 exporting layers 0.1s done
#8 exporting manifest sha256:c817a13c25e2125d416906850836be2ba25c51b8034a529072ed34bd1ed350a7 0.0s done
#8 exporting config sha256:8f0e896993be89da5a829a5f79a06b5b07e340e4c5b3420770f5ceda7d851180 done
#8 exporting attestation manifest sha256:2ed26ba776a35288f796820ac84a8a2c8a43105e5fa2877d6814c4c4af4aba8c 0.0s done
#8 exporting manifest list sha256:8a43c3032b90f734c4a8a2f571246256f546ab31bee8425cd0ad5a3cda58e614 done
#8 naming to docker.io/library/ia-codyseey-web:lab done
#8 unpacking to docker.io/library/ia-codyseey-web:lab
#8 unpacking to docker.io/library/ia-codyseey-web:lab 0.6s done
#8 DONE 0.8s
+ docker image inspect ia-codyseey-web:lab --format '{{.Id}}'
sha256:8a43c3032b90f734c4a8a2f571246256f546ab31bee8425cd0ad5a3cda58e614
+ docker run -d --name ia-codyseey-web-8080 -p 127.0.0.1:8080:80 ia-codyseey-web:lab
3d54534413d5f85ef026a828d6e31b3c17147b6c6a957deeb8629eb1093d9246
+ mkdir -p bind-site
+ cp site/index.html bind-site/index.html
+ docker run -d --name ia-codyseey-web-8081 -p 127.0.0.1:8081:80 --mount type=bind,source=/mnt/c/Users/gamed/Documents/Codex/2026-11-08/referenced-chatgpt-conversation-this-is-an/work/ia-codyseey/bind-site,target=/usr/share/nginx/html,readonly ia-codyseey-web:lab
53db5b3cc11236a0a6e97078b1f9ad25f3f6953ecc57bdce4f3bf777b76e1087
+ curl --retry 10 --retry-connrefused --retry-delay 1 -fsS http://localhost:8080
+ tee evidence/8080.html
<!doctype html>
<html lang="ko"><meta charset="utf-8"><title>Docker 실습</title>
<h1>나의 첫 Docker 웹 서버</h1><p>IMAGE_VERSION_1</p></html>
+ curl --retry 10 --retry-connrefused --retry-delay 1 -fsS http://localhost:8081
+ tee evidence/bind-before.html
<!doctype html>
<html lang="ko"><meta charset="utf-8"><title>Docker 실습</title>
<h1>나의 첫 Docker 웹 서버</h1><p>IMAGE_VERSION_1</p></html>
+ sed -i s/IMAGE_VERSION_1/BIND_VERSION_2/ bind-site/index.html
+ curl -fsS http://localhost:8081
+ tee evidence/bind-after.html
<!doctype html>
<html lang="ko"><meta charset="utf-8"><title>Docker 실습</title>
<h1>나의 첫 Docker 웹 서버</h1><p>BIND_VERSION_2</p></html>
+ grep BIND_VERSION_2 evidence/bind-after.html
<h1>나의 첫 Docker 웹 서버</h1><p>BIND_VERSION_2</p></html>
+ curl -fsS http://localhost:8080
+ grep IMAGE_VERSION_1
<h1>나의 첫 Docker 웹 서버</h1><p>IMAGE_VERSION_1</p></html>
+ docker stats --no-stream ia-codyseey-web-8080 ia-codyseey-web-8081
CONTAINER ID   NAME                   CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O     PIDS
3d54534413d5   ia-codyseey-web-8080   0.00%     11.38MiB / 15.18GiB   0.07%     1.95kB / 1.58kB   0B / 12.3kB   13
53db5b3cc112   ia-codyseey-web-8081   0.00%     11.17MiB / 15.18GiB   0.07%     2.07kB / 1.62kB   0B / 8.19kB   13
+ docker port ia-codyseey-web-8080
80/tcp -> 127.0.0.1:8080
+ docker port ia-codyseey-web-8081
80/tcp -> 127.0.0.1:8081
+ docker volume create ia-codyseey-data
ia-codyseey-data
+ docker run --name ia-codyseey-volume-before --mount type=volume,source=ia-codyseey-data,target=/data ubuntu sh -c 'echo persistent-value-20261108 > /data/proof.txt; cat /data/proof.txt; sha256sum /data/proof.txt'
persistent-value-20261108
931a80e1d5640d79bab0866aeafa3e9a15cac3cd09b6c6e1b4f37514dbafca0b  /data/proof.txt
+ docker rm ia-codyseey-volume-before
ia-codyseey-volume-before
+ docker volume inspect ia-codyseey-data
[
    {
        "CreatedAt": "2026-11-08T13:32:23Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/ia-codyseey-data/_data",
        "Name": "ia-codyseey-data",
        "Options": null,
        "Scope": "local"
    }
]
+ docker run --name ia-codyseey-volume-after --mount type=volume,source=ia-codyseey-data,target=/data ubuntu sh -c 'cat /data/proof.txt; sha256sum /data/proof.txt; test "$(cat /data/proof.txt)" = persistent-value-20261108'
persistent-value-20261108
931a80e1d5640d79bab0866aeafa3e9a15cac3cd09b6c6e1b4f37514dbafca0b  /data/proof.txt
+ docker rm ia-codyseey-volume-after
ia-codyseey-volume-after
+ docker ps -a
CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS                        PORTS                    NAMES
53db5b3cc112   ia-codyseey-web:lab   "/docker-entrypoint.…"   3 seconds ago    Up 3 seconds                  127.0.0.1:8081->80/tcp   ia-codyseey-web-8081
3d54534413d5   ia-codyseey-web:lab   "/docker-entrypoint.…"   4 seconds ago    Up 3 seconds                  127.0.0.1:8080->80/tcp   ia-codyseey-web-8080
3b7047df0eeb   ubuntu                "sleep infinity"         20 minutes ago   Exited (137) 13 minutes ago                            exec-practice
9c92e9efe559   ubuntu                "bash"                   33 minutes ago   Exited (0) 23 minutes ago                              hardcore_banach
033f7d7aaf3c   hello-world           "/hello"                 43 minutes ago   Exited (0) 43 minutes ago                              gracious_germain
+ echo ALL_LAB_CHECKS_PASSED
ALL_LAB_CHECKS_PASSED

```

## 추가 점검: 운영 명령과 Git 설정

```text
+ date -Is
2026-11-08T22:38:24+09:00
+ cat /etc/os-release
PRETTY_NAME="Ubuntu 26.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="26.04"
VERSION="26.04.1 LTS (Resolute Raccoon)"
VERSION_CODENAME=resolute
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=resolute
LOGO=ubuntu-logo
+ bash --version
GNU bash, version 5.3.9(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2025 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
+ git --version
git version 2.53.0
+ docker --version
Docker version 29.9.2, build a82e528
+ docker info
Client:
 Version:    29.9.2
 Context:    default
 Debug Mode: false
 Plugins:
  agent: Docker AI Agent Runner (Docker Inc.)
    Version:  v1.152.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-agent
  ai: Docker AI Agent - Ask Gordon (Docker Inc.)
    Version:  v1.33.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-ai
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.38.1
    Path:     /usr/local/lib/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v5.6.1
    Path:     /usr/local/lib/docker/cli-plugins/docker-compose
  debug: Get a shell into any image or container (Docker Inc.)
    Version:  0.49.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-debug
  desktop: Docker Desktop commands (Docker Inc.)
    Version:  4.98.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-desktop
  dhi: CLI for managing Docker Hardened Images (Docker Inc.)
    Version:  v0.0.9
    Path:     /usr/local/lib/docker/cli-plugins/docker-dhi
  extension: Manages Docker extensions (Docker Inc.)
    Version:  v0.2.32
    Path:     /usr/local/lib/docker/cli-plugins/docker-extension
  init: Creates Docker-related starter files for your project (Docker Inc.)
    Version:  v1.4.1
    Path:     /usr/local/lib/docker/cli-plugins/docker-init
  mcp: Docker MCP Plugin (Docker Inc.)
    Version:  v0.44.2
    Path:     /usr/local/lib/docker/cli-plugins/docker-mcp
  model: Docker Model Runner (Docker Inc.)
    Version:  v1.2.9
    Path:     /usr/local/lib/docker/cli-plugins/docker-model
  offload: Docker Offload (Docker Inc.)
    Version:  v0.7.35
    Path:     /usr/local/lib/docker/cli-plugins/docker-offload
  pass: Docker Pass Secrets Manager Plugin (beta) (Docker Inc.)
    Version:  v0.3.2
    Path:     /usr/local/lib/docker/cli-plugins/docker-pass
  sandbox: "docker sandbox" is deprecated, use Docker Sandboxes instead (Docker Inc.)
    Version:  v0.13.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-sandbox
  scout: Docker Scout (Docker Inc.)
    Version:  v1.27.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-scout

Server:
 Containers: 5
  Running: 2
  Paused: 0
  Stopped: 3
 Images: 3
 Server Version: 29.9.2
 Storage Driver: overlayfs
  driver-type: io.containerd.snapshotter.v1
 Logging Driver: local
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Discovered Devices:
  cdi: docker.com/gpu=webgpu
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 nvidia runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: b7a25261e029d68978bbf290df0a62fc819b3c51
 runc version: v1.5.2-0-g29dd3dc2
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.18.54.1-microsoft-standard-WSL2
 Operating System: Docker Desktop
 OSType: linux
 Architecture: x86_64
 CPUs: 12
 Total Memory: 15.18GiB
 Name: docker-desktop
 ID: 19ff1768-3ac0-4e4d-af3d-f25e36f404da
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 HTTP Proxy: http.docker.internal:3128
 HTTPS Proxy: http.docker.internal:3128
 No Proxy: hubproxy.docker.internal
 Labels:
  com.docker.desktop.address=unix:///var/run/docker-cli.sock
 Experimental: false
 Insecure Registries:
  hubproxy.docker.internal:5555
  127.0.0.0/8
  ::1/128
 Live Restore Enabled: false
 Firewall Backend: iptables

+ docker images
IMAGE                 ID             DISK USAGE   CONTENT SIZE   EXTRA
hello-world:latest    c567b231f656       25.9kB         9.49kB   U    
ia-codyseey-web:lab   8a43c3032b90       92.7MB         26.1MB   U    
ubuntu:latest         6a06111c3b0a        163MB         45.9MB   U    
+ docker run --rm hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

+ docker run --name ia-codyseey-audit-exit ubuntu bash -c 'pwd; ls; echo main-process-done'
/
bin
boot
dev
etc
home
lib
lib64
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var
main-process-done
+ docker inspect ia-codyseey-audit-exit --format '{{.State.Status}} {{.State.ExitCode}}'
exited 0
+ docker run -d --init --name ia-codyseey-audit-exec ubuntu sleep infinity
4b33fcff462e1d95bbe3d26829192d3373ff38681b6dc9438a3f296fde7c7064
+ docker exec ia-codyseey-audit-exec bash -c 'pwd; ls; echo extra-process-done'
/
bin
boot
dev
etc
home
lib
lib64
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var
extra-process-done
+ docker inspect ia-codyseey-audit-exec --format '{{.State.Status}}'
running
+ docker stop ia-codyseey-audit-exec
ia-codyseey-audit-exec
+ docker inspect ia-codyseey-audit-exec --format '{{.State.Status}} {{.State.ExitCode}}'
exited 143
+ docker logs ia-codyseey-web-8080
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/11/08 13:32:21 [notice] 1#1: using the "epoll" event method
2026/11/08 13:32:21 [notice] 1#1: nginx/1.30.6
2026/11/08 13:32:21 [notice] 1#1: built by gcc 15.2.0 (Alpine 15.2.0) 
2026/11/08 13:32:21 [notice] 1#1: OS: Linux 6.18.54.1-microsoft-standard-WSL2
2026/11/08 13:32:21 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2026/11/08 13:32:21 [notice] 1#1: start worker processes
2026/11/08 13:32:21 [notice] 1#1: start worker process 30
2026/11/08 13:32:21 [notice] 1#1: start worker process 31
2026/11/08 13:32:21 [notice] 1#1: start worker process 32
2026/11/08 13:32:21 [notice] 1#1: start worker process 33
2026/11/08 13:32:21 [notice] 1#1: start worker process 34
2026/11/08 13:32:21 [notice] 1#1: start worker process 35
2026/11/08 13:32:21 [notice] 1#1: start worker process 36
2026/11/08 13:32:21 [notice] 1#1: start worker process 37
2026/11/08 13:32:21 [notice] 1#1: start worker process 38
2026/11/08 13:32:21 [notice] 1#1: start worker process 39
2026/11/08 13:32:21 [notice] 1#1: start worker process 40
2026/11/08 13:32:21 [notice] 1#1: start worker process 41
172.17.0.1 - - [08/Nov/2026:13:32:21 +0000] "GET / HTTP/1.1" 200 150 "-" "curl/8.18.0" "-"
172.17.0.1 - - [08/Nov/2026:13:32:21 +0000] "GET / HTTP/1.1" 200 150 "-" "curl/8.18.0" "-"
172.17.0.1 - - [08/Nov/2026:13:32:58 +0000] "GET / HTTP/1.1" 200 150 "-" "curl/8.21.0" "-"
172.17.0.1 - - [08/Nov/2026:13:33:13 +0000] "GET / HTTP/1.1" 200 150 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36" "-"
2026/11/08 13:33:13 [error] 34#34: *5 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 172.17.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "localhost:8080", referrer: "http://localhost:8080/"
172.17.0.1 - - [08/Nov/2026:13:33:13 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://localhost:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36" "-"
172.17.0.1 - - [08/Nov/2026:13:34:16 +0000] "GET / HTTP/1.1" 200 150 "-" "curl/8.18.0" "-"
172.17.0.1 - - [08/Nov/2026:13:34:24 +0000] "GET / HTTP/1.1" 200 150 "-" "curl/8.18.0" "-"
+ docker stats --no-stream ia-codyseey-web-8080 ia-codyseey-web-8081
CONTAINER ID   NAME                   CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O     PIDS
3d54534413d5   ia-codyseey-web-8080   0.00%     10.2MiB / 15.18GiB    0.07%     7.11kB / 6.15kB   0B / 12.3kB   13
53db5b3cc112   ia-codyseey-web-8081   0.00%     10.18MiB / 15.18GiB   0.07%     5.95kB / 4.83kB   0B / 12.3kB   13
+ docker ps -a
CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS                        PORTS                    NAMES
4b33fcff462e   ubuntu                "sleep infinity"         3 seconds ago    Exited (143) 2 seconds ago                             ia-codyseey-audit-exec
961eb95892c1   ubuntu                "bash -c 'pwd; ls; e…"   4 seconds ago    Exited (0) 2 seconds ago                               ia-codyseey-audit-exit
53db5b3cc112   ia-codyseey-web:lab   "/docker-entrypoint.…"   6 minutes ago    Up 6 minutes                  127.0.0.1:8081->80/tcp   ia-codyseey-web-8081
3d54534413d5   ia-codyseey-web:lab   "/docker-entrypoint.…"   6 minutes ago    Up 6 minutes                  127.0.0.1:8080->80/tcp   ia-codyseey-web-8080
3b7047df0eeb   ubuntu                "sleep infinity"         26 minutes ago   Exited (137) 20 minutes ago                            exec-practice
9c92e9efe559   ubuntu                "bash"                   39 minutes ago   Exited (0) 29 minutes ago                              hardcore_banach
033f7d7aaf3c   hello-world           "/hello"                 49 minutes ago   Exited (0) 49 minutes ago                              gracious_germain
+ git config init.defaultBranch main
+ git config --list
core.repositoryformatversion=0
core.filemode=false
core.bare=false
core.logallrefupdates=true
core.symlinks=false
core.ignorecase=true
remote.origin.url=https://github.com/sopa3344/ia-codyseey.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
user.name=SoPa
user.email=160595319+sopa3344@users.noreply.github.com
init.defaultbranch=main
+ git branch --show-current
main
+ docker rm ia-codyseey-audit-exit ia-codyseey-audit-exec
ia-codyseey-audit-exit
ia-codyseey-audit-exec

```

## 컨테이너 이름 충돌과 재사용

```text
+ docker run -d --name ia-codyseey-web-8080 ia-codyseey-web:lab
docker: Error response from daemon: Conflict. The container name "/ia-codyseey-web-8080" is already in use by container "3d54534413d5f85ef026a828d6e31b3c17147b6c6a957deeb8629eb1093d9246". You have to remove (or rename) that container to be able to reuse that name.

Run 'docker run --help' for more information
+ rc=125
+ echo expected-name-conflict-exit=125
expected-name-conflict-exit=125
+ test 125 -eq 125
+ docker ps --filter name=ia-codyseey-web-8080
CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         PORTS                    NAMES
3d54534413d5   ia-codyseey-web:lab   "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   127.0.0.1:8080->80/tcp   ia-codyseey-web-8080
+ curl -fsS http://localhost:8080
<!doctype html>
<html lang="ko"><meta charset="utf-8"><title>Docker 실습</title>
<h1>나의 첫 Docker 웹 서버</h1><p>IMAGE_VERSION_1</p></html>
+ git config --get user.name
SoPa
+ git config --get user.email
160595319+sopa3344@users.noreply.github.com
+ git remote -v
origin	https://github.com/sopa3344/ia-codyseey.git (fetch)
origin	https://github.com/sopa3344/ia-codyseey.git (push)

```

