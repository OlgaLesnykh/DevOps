# Задание 1
Сделала fork репозитория shvirtd-example-python, на основе инструкции из файла README этого репозитория формирую файл Dockerfile.python. Файл Dockerfile.python [здесь](https://github.com/OlgaLesnykh/DevOps/blob/main/Docker/2/Dockerfile.python). Собираю образ с именем task-1-python - успешно.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_024.png)    
# Задание 2
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
# Задание 3
Файл compose.yaml [здесь](https://github.com/OlgaLesnykh/DevOps/blob/main/Docker/2/compose.yaml).    
Сначала расположила в файле compose.yaml сервисы, как в задании, - сначала web, потом db, и база данных никак не хотела подниматься, появлялась ошибка типа ```[ERROR] [MY-013236] [Server] The designated data directory /var/lib/mysql/ is unusable. You can remove all files that the server added to it.``` Не могла понять, откуда в каталоге нового контейнера появились файлы, предположила, что они создаются приложением, ради эксперимента поменяла сервисы местами в compose.yaml, это решило проблему.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Docker_027.png)    
# Задание 4