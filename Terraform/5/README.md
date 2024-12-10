# Задание 1
Проверяю код из 4 задания с помощью tflint: запускаю docker-контейнер ```docker run --rm -v "$(pwd):/tflint" ghcr.io/terraform-linters/tflint```, получаю следующие типы ошибок:  
1. Переменная объявлена, но не используется    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_055.png)    
2. Не ограничена версия для провайдера    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_056.png)    
3. При вызове модуля из git используется ветка main    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_057.png)    
Проверяю этот же код с помощью checkov, запускаю docker-контейнер ```docker pull bridgecrew/checkov```, ```docker run --rm --tty --volume $(pwd):/tf --workdir /tf bridgecrew/checkov --download-external-modules true --directory /tf```. Найдены следующие типы ошибок:    
1. Не назначена группа безопасности для сетевого интерфейса
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_058.png)    
2. Виртуальная машина имеет публичный ip-адрес    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_059.png)    
3. При обращении к модулю в git не используется хэш коммита, полагаю это та же самая ошибка, которая была найдена с помощью tflint, в коде ссылка просто на ветку main, соответственно код модуля не является неизменяемым.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_060.png)    
4. При обращении к модулю в git не используется тег с номером версии    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_061.png)    
5. Не назначена группа безопасности для кластера базы данных    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_062.png)    
# Задание 2
1. Создаю новую ветку 'terraform-05' и переключаюсь на нее ```git checkout -b terraform-05```.
2. Через консоль управления яндекс создаю бакет:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_063.png)    
Создаю сервисный аккаунт, ключ для него и даю права этому аккаунту на бакет:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_064.png)    
Создаю базу данных YDB:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_065.png)    
В базе данных создаю документную таблицу и выполняю запрос данных из этой таблицы до выполнения кода terraform (ответ ожидаемо пустой):    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_066.png)    
Выполняю ```terraform init```, ```terraform apply```, наблюдаю, что в каталоге, из которого выполняю код, не появился файл tfstate, предполагаю, что всё работает правильно, иду в запросы к документной таблице, выполняю запрос повторно - вижу, что появился новый файл .tfstate, значит всё настроено верно.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_067.png)    
3. Делаю коммит изменений в ветку 'terraform-05'.
4. Открываю в проекте terraform console, а в другом окне из этой же директории пробую запустить terraform apply - получаю ошибку доступа к state.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_068.png)    
4. Разблокирую state ```terraform force-unlock 385c3dcd-281c-2f7c-cacf-78c04a35dd39``` (id взяла из сообщения об ошибке), ```terraform apply``` выполняется успешно:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_069.png)    
# Задание 3
Исправляю ошибки, найденные с помощью tflint и checkov:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_072.png)    
Pull Request [здесь](https://github.com/OlgaLesnykh/DevOps/pull/1).
# Задание 4
```    
variable "ip_address" {
  type = string
  description = "IP-address"
  default     = "192.168.0.1"
  validation  {
    condition = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$", var.ip_address))
    error_message   = "Incorrect IP address format"
  }
}
variable "ip_addresses" {
  type = list(string)
  description = "List of IP-address"
  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  validation  {
    condition = alltrue([for i in var.ip_addresses: can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$", i))])
    error_message   = "Incorrect IP address format"
  }
}
```
Корректный ввод значений по умолчанию:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_070.png)    
Некорректный ввод значений по умолчанию:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_071.png)    

К сожалению, не успеваю выполнить задания с *, не уверена, что домашняя работа в принципе успеет пройти проверку, т.к. модуль закрывается. В любом случае, в ходе выполнения этой работы я научилась работать со state-файлом, проверять код с помощью tflint и checkov и создала первый в своей жизни Pull Request:) Считаю модуль пройденным успешно и продуктивно)
