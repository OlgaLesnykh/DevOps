# Домашнее задание к занятию 1 «Введение в Ansible»

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_001.png)
2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_002.png)
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.    
Поднимаю docker-контейнеры centos7 и ubuntu ```docker run -t -d --name ubuntu ubuntu:22.04 /bin/bash``` ```docker run -t -d --name centos7 centos:7 /bin/bash``` (добавляю ключ -t и команду /bin/bash, чтобы контейнеры не упали сразу):    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_003.png)
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.    
Сначала плейбук успешно выполнялся только для хоста centos7, для ubuntu появлялась ошибка ```"No python interpreters found for host ubuntu (tried ['/usr/bin/python', 'python3.9', 'python3.8', 'python3.7', 'python3.6', 'python3.5', 'python2.7', 'python2.6', '/usr/libexec/platform-python', '/usr/bin/python3', 'python'])"```. Подключилась к контейнеру ubuntu ```docker exec -it ubuntu /bin/bash``` и установила python3.8, после этого запустила плейбук снова - проблема решилась, плейбук выполнился успешно для обоих хостов:
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_004.png)
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_005.png)
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_006.png)
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.    
Сначала запустила плейбук для проверки без специального ключа, плейбук не выполнился с сообщением ```ERROR! Attempting to decrypt but no vault secrets found```. Запускаю плейбук с ключом ```--ask-vault-password```, ввожу пароль - плейбук выполняется успешно.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_007.png)
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_008.png)
Подходящий плагин - local.
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_009.png)
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_010.png)
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
Расшифровываю файлы, для проверки запускаю плейбук без ключа ```--ask-vault-password``` - успешно.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_011.png)
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
Зашифровываю значение:
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_012.png)
Вставляю получившееся зашифрованное значение в файл group_vars/all/exmp.yml
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_013.png)
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
Новый fact применился для хоста local, как и должно быть:
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_014.png)
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
Поднимаю еще один контейнер с имиджем pycontribs/fedora:
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_015.png)
Добавляю новую группу хостов в инвентори prod.yml и добавляю для этой группы хостов переменную ```some_fact: "Hello Netology!"```. Плейбук успешно выполняется:
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Ansible_016.png)
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
Скрипт [здесь](https://github.com/OlgaLesnykh/DevOps/tree/main/Ansible/08-ansible-01-base/script.sh).
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий. 