# Задача 1
Сделала fork репозитория shvirtd-example-python, на основе инструкции из файла README этого репозитория формирую файл Dockerfile.python. Файл Dockerfile.python [здесь](https://github.com/OlgaLesnykh/DevOps/blob/main/Docker/2/shvirtd-python/Dockerfile.python). Собираю образ с именем task-1-python - успешно.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_024.png)    
# Задача 2
Устанавливаю яндекс CLI. выполняю команду:   
```yc init```    
Создаю реестр в Container Registry с именем lesnykh-registry:   
```yc container registry create --name lesnykh-registry```    
Конфигурирую Docker:    
```yc container registry configure-docker```    
Присваиваю тег своему образу task-1-python:    
```docker tag task-1-python cr.yandex/crpr75mnvtdvmv7nuemf/task-1-python```, где
```crpr75mnvtdvmv7nuemf``` - id моего реестра.    
Запушиваю образ в реестр:    
```docker push cr.yandex/crpr75mnvtdvmv7nuemf/task-1-python```    
Образ появился в консоли управления яндекс клауд, Выполняю сканирование, анализирую результат:         
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_025.png)    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_026.png)    
Всего обнаружено 97 уязвимостей, из которых 1 - крическая, и 7 - высокого уровня критичности. Делаю вывод, что безопасность образа требует доработки.
# Задача 3
Файл compose.yaml [здесь](https://github.com/OlgaLesnykh/DevOps/blob/main/Docker/2/shvirtd-python/compose.yaml).    
Сначала расположила в файле compose.yaml сервисы, как в задании, - сначала web, потом db, и база данных никак не хотела подниматься, появлялась ошибка типа ```[ERROR] [MY-013236] [Server] The designated data directory /var/lib/mysql/ is unusable. You can remove all files that the server added to it.``` Не могла понять, откуда в каталоге нового контейнера появились файлы, предположила, что они создаются приложением, ради эксперимента поменяла сервисы местами в compose.yaml, это решило проблему.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_027.png)    
# Задача 4
Проект поместила в отдельный репозиторий [https://github.com/OlgaLesnykh/shvirtd-python](https://github.com/OlgaLesnykh/shvirtd-python) для того, чтобы была возможность его клонировать.    
Bash-скрипт [здесь](https://github.com/OlgaLesnykh/DevOps/blob/main/Docker/2/bash_script.sh).    
Подключаюсь по ssh к виртуальной машине, скрипт помещаю в домашний каталог пользователя ubuntu и запускаю его командой ```bash -x```.    
Убеждаюсь, что контейнеры успешно стартовали, по заданию захожу на сайт https://check-host.net/check-http и выполняю проверку своего сервиса по внешнему ip машины на порту 8090 (http://89.169.135.244:8090/). Также пробую сделать запрос в браузере со своей рабочей машины, запрос выполняется корректно:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_028.png)    
Делаю запрос в БД:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_029.png)    
# Задача 6
Устанавливаю dive;    
Загружаю образ ```docker pull hashicorp/terraform:latest```;    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_030.png)    
Анализирую образ с помощью утилиты dive. Нахожу команду ```COPY dist/linux/amd64/terraform /bin/terraform # buildkit``` в слоях, делаю ее активной и запоминаю значение идентификатора в детализации слоя - ```sha256/c3c3a5978391c2884975a1e49c4d3ee1e29dac201a59bf27685a1b750ad5e64a```;    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_031.png)    
Сохраняю образ в виде архива terraform.tar ```docker save -o terraform.tar hashicorp/terraform:latest``` в домашней директории пользователя root;    
Распаковываю архив ```tar -xvf terraform.tar```, содержимое архива поместилось в директорию ```blobs```, нахожу в ней файл ```./blobs/sha256/c3c3a5978391c2884975a1e49c4d3ee1e29dac201a59bf27685a1b750ad5e64a``` и распаковываю его тоже.    
Файл был распакован в каталог ```bin``` в домашней директории пользователя root, в этом каталоге ```bin``` находим нужный нам бинарный файл terraform.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_032.png)    
# Задача 6.1
Создаем контейнер ```docker create --name terraform_test hashicorp/terraform:latest```;    
Извлекаем файл ```docker cp terraform_test:/bin/terraform ./terraform```.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_033.png)    