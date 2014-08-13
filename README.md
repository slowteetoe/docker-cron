Proof of concept/playground for running cron under supervisord
---

Run with:
docker run -p 2222:22 -v /Users/slotito/projects/docker-cron/logs:/logs -d crontest

Note:
---
To be able to mount a host volume on OSX, I had to follow the instructions from https://medium.com/boot2docker-lightweight-linux-for-docker/boot2docker-together-with-virtualbox-guest-additions-da1e3ab2465c

tldr; install VirtualBox guest additions and run VBoxManage sharedfolder add boot2docker-vm -name home -hostpath /Users