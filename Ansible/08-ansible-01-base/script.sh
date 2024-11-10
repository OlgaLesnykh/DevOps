#!/bin/bash

docker run -t -d --name ubuntu ubuntu:22.04 /bin/bash
docker run -t -d --name centos7 centos:7 /bin/bash
docker run -t -d --name fedora pycontribs/fedora /bin/bash
ansible-playbook -i ./inventory/prod.yml site.yml
docker stop ubuntu centos7 fedora
docker rm ubuntu centos7 fedora