# Задание 1
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_001.png)    
2. Согласно представленному в задании .gitignore, допустимо сохранить личную, секретную информацию в файле personal.auto.tfvars.    
3. Cекретное содержимое созданного ресурса random_password ищем в  state-файле в поле "result", в данном случае ключ 5O8JW8bNghO91SEK.    
4. Ошибка 1: в имени (1nginx) ресурса docker_container, имя должно начинаться с буквы или подчеркивания, исправляем на  nginx; 
Ошибка 2: не объявлен образ - ресурс "docker_image" "nginx", для исправления раскомментируем строки, где этот ресурс объявляется;    
Ошибка 3: отсутствует имя образа (ресурс docker_image), добавляем второй лэйбл "nginx_image" (можно было сделать лэйбл nginx, вероятно изначально он такой и был, поскольку контейнер ссылается на имя nginx (в строке image = docker_image.nginx.image_id) описания контейнера, но тогда имя образа совпадало бы с именем контейнера, думаю, это не очень хорошо, есть риск запутаться по неопытности, пусть они отличаются, так что исправляю еще в описании контейнера: image = docker_image.nginx_image.image_id, );    
Ошибка 4: неверно указана ссылка на пароль, исправляем на "example_${random_password.random_string.result}";    
5. Код [здесь](https://github.com/OlgaLesnykh/DevOps/blob/main/Terraform/1/main.tf).    Запускаем ```terraform apply```.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_002.png)    
6. Меняем имя docker-контейнера в блоке кода на hello_world. Запускаем команду ```terraform apply -auto-approve```. Ключ -auto-approve применяет изменения к инфраструктуре, не запрашивая подтверждения пользователя. Это может быть опасно потерей данных, в частности, в нашем случае контейнер был удален и создан новый с именем hello_world и новым id.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_003.png)    
7. Уничтожаем созданные ресурсы с помощью команды ```terraform destroy```. Содержимое файла terraform.tfstate после удаления:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_004.png)    
8. docker-образ nginx:latest не был удален, поскольку мы указали опцию ```keep_locally = true``` в коде, если бы параметр имел значение ```false```, образ был бы удален. Выдержка из документации:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_005.png)    
# Задание 2
Код [здесь](https://github.com/OlgaLesnykh/DevOps/blob/main/Terraform/1/Task_002/main.tf).    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_006.png)    
# Задание 3
По инструкции с https://opentofu.org/ установила tofu.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_007.png)    
При выполнении команды ```tofu init``` столкнулась с ошибкой ```Could not resolve provider kreuzwerker/docker: could not connect to registry.opentofu.org: failed to request discovery document: 403 Forbidden``` К сожалению, доступ к ресурсу с российских ip заблокирован. Пробую настроить зеркало, в рабочем каталоге создаю файл .tofurc с содержимым:    
```
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.opentofu.org/*/*"]
  }
  direct {
    exclude = ["registry.opentofu.org/*/*"]
  }
}
```
Повторно выполняю команду ```tofu init```, теперь успешно:    
