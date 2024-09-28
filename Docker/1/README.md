# Задание 1
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
Запускаем из образа custom-nginx контейнер с таким же именем custom-nginx, прокидывая порт 80 на хостовой машине на порт 80 в контейнере, Убеждаемся, что контейнер работает и проверяем по внешнему адресу хостовой машины на порту 80:    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_003.png)    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_004.png)    
