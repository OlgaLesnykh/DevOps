# Задание 1
Код [здесь](https://github.com/OlgaLesnykh/DevOps/tree/main/Terraform/3/src).    
После выполнения команды ```terraform init``` исправляю в скачанном модуле версию ```required_version = "~>1.8.4"``` на ```required_version = ">1.8.4"```, чтобы модуль работал на моей версии терраформа 1.9.7.    
Две ВМ, относящиеся к разным проектам(marketing и analytics), успешно создаются с помощью двух вызовов remote-модуля:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_030.png)    
Поочередно подключаюсь по ssh к каждой машине и проверяю конфигурацию nginx командой ```sudo nginx -t```    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_031.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_032.png)    
Также проверяю по внешним ip-адресам реализованную замену дефолтной страницы nginx, убеждаюсь, что соответствующее содержимое файла cloud-init.yml корректно:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_033.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_034.png)    
Требуемый вывод модуля через Terraform console:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_035.png)    
# Задание 2
Ресурсы успешно создаются. В output вывожу информацию об id сети и подсети, которые потребуются для обращения к этим ресурсам при описании конфигурации виртуальных машин. Информация о модуле в Terraform console:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_036.png)  