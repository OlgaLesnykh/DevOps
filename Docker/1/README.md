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
