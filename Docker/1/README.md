# Задача 1
1. Запускаем контейнер с помощью docker compose:
Создаем файл docker-compose.yml с содержимым:
```
version: "3.3"
services:
  nginx:
    image: nginx:1.21.1
    container_name: custom-nginx
    ports:
      - "5555:80"
    volumes:
      - ./custom/index.html:/usr/share/nginx/html/index.html
    restart: always
```
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_001.png)    
Проверяем по внешнему ip-адресу ВМ на порту 5555:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_002.png)    

2. Запускаем контейнер с помощью docker    
Создаем файл Dockerfile с содержимым:
```
FROM nginx:1.21.1
COPY ./custom/index.html /usr/share/nginx/html/index.html
EXPOSE 80/tcp
```
Собираем образ с именем custom-nginx, смотрим список доступных образов, видим тот, который ранее скачали с hub.docker.com и custom-nginx, который собрали только что.    
Запускаем из образа custom-nginx контейнер с таким же именем custom-nginx, прокидывая порт 80 контейнера на порт 80 хоста, Убеждаемся, что контейнер работает и проверяем по внешнему адресу хостовой машины на порту 80:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_003.png)    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_004.png)    

Собираю еще раз образ с тегом и юзернеймом для hub.docker.com командой ```docker build -t  olgalesnykh/custom-nginx:1.0.0 .```    
Логинюсь на hub.docker.com ``` docker login -u olgalesnykh -p <мой пароль:)>```
Пушу образ ```docker push olgalesnykh/custom-nginx:1.0.0```    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_005.png)    

Кажется, всё получилось:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_006.png)    

Единственный момент, который недопоняла, рабочая ссылка на мой образ получилась такая: https://hub.docker.com/layers/olgalesnykh/custom-nginx/1.0.0/images/sha256-35e1fb7d881cd0966470ff65e40a3d1dfda44b6ed1cc5c719c5c130538ac9459?context=explore что не соответствует шаблону, указанному в задании: https://hub.docker.com/<username_repo>/custom-nginx/general 
Возможно я что-то сделала неправильно, прокомментируйте, пожалуйста.
# Задача 2
1. ```docker run -d --name lesnykh-custom-nginx-t2 -p 8080:80 olgalesnykh/custom-nginx:1.0.0```
2. ```docker rename lesnykh-custom-nginx-t2 custom-nginx-t2```
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_007.png)    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_008.png)    
# Задача 3
1,2,3
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_009.png)    

Контейнер остановился, вероятно, поскольку команда Ctrl+C передала ему сигнал SIGINT, который прервал процесс.    
4,5,6 - установка vim завершилась успешно    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_010.png)    
7,8,9    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_011.png)    
10    
Мы поменяли в контейнере порт, на котором работает nginx с 80 на 81. Когда создавали контейнер, прокидывали порт 80 контейнера на порт 8080 хоста, соответственно, логично, что сервер nginx перестал отвечать на порту 8080 (он сопоставлен с 80 портом контейнера, а nginx уже работает на 81).   
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_012.png)    
11    
Попробуем решить эту проблему:
Останавливаем контейнер и службу docker;    
Узнаем идентификатор контейнера ```docker inspect --format="{{.Id}}" custom-nginx-t2```;    
Находим конфигурационные файлы контейнера по идентификатору: ```ls /var/lib/docker/containers/a501901f8c89336f46c3f9a1832f6096f8ebcc0dfb4b6fc3d13c2a5cc8df9496```;    
Исправляем в файлах hostconfig.json и config.v2.json "80/tcp" на "81/tcp";
Запускаем docker;
Запускаем контейнер;
Пробуем вывод команд из пункта 10 и смотрим страницу в браузере, убеждаемся, что починили, радуемся.    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_013.png)    
12    
Удаляем запущенный контейнер командой ```docker rm -f custom-nginx-t2```    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_014.png)   
# Задача 4
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_015.png)   
# Задача 5

