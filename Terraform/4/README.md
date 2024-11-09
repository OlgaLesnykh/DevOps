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
Документация к модулю успешно сформирована и находится [здесь](https://github.com/OlgaLesnykh/DevOps/blob/main/Terraform/4/src/VPC/README.md).
# Задание 3
Удаляю из стейта модули vpc и vm:    
```
terraform state rm module.vpc_dev.yandex_vpc_network.develop
terraform state rm module.analytics-vm.yandex_compute_instance.vm[0]
terraform state rm module.marketing-vm.yandex_compute_instance.vm[0]
```
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_037.png)  
Импортирую модули обратно (нужные идентификаторы копирую в консоли управления яндекс):    
```
terraform import module.vpc_dev.yandex_vpc_network.develop enptc4799jup794dvrgd
terraform import module.analytics-vm.yandex_compute_instance.vm[0] fhm1pa7ucr6ktgdg7ub6
terraform import module.marketing-vm.yandex_compute_instance.vm[0] fhmrttuj5bbl5i55iqqv
```
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_038.png)    
Запускаю ```terraform plan```, значимых изменений нет:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_039.png)  
# Задание 4
Дорабатываю модуль vpc_dev: создаю переменную vpc_vars, которая содержит список объектов: зоны доступности, в которых необходимо создать подсети, и соответствующие им cidr. Для ресурса yandex_vpc_subnet добавляю конструкцию for_each и редактирую output - добавляю вывод имени подсети, чтобы было проще обратится к подсети в root-модуле. В root-модуле в описании конфигурации виртуальных машин меняю ```subnet_ids     = ["${module.vpc_dev.subnet_id}"]``` на ```subnet_ids     = ["${module.vpc_dev.subnet_id["ru-central1-a"]}"]``` - не придумала, как написать так, чтобы не было хардкодно, подскажите, пожалуйста, буду благодарна).    
Запускаю весь проект, все инстансы успешно создаются:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_041.png)    
Проверяю подсети в консоли управления яндекс:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_042.png)    
И информация о моем модуле из Terraform console:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_040.png)    
Документацию для модуля обновила.
# Задание 5
Код к этому заданию оформила в отдельном [каталоге](https://github.com/OlgaLesnykh/DevOps/blob/main/Terraform/4/src/task_5).    
Сначала создаю кластер с одним хостом (значение переменной ```HA = false```), кластер успешно создается:     
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_043.png)    
Один хост:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_044.png)    
База данных:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_045.png)    
Пользователь:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_046.png)    
Меняю значение переменной HA на true, выполняю ```terraform apply```, успешно создается второй хост (в другой подсети и с ролью REPLICA):    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_047.png)    
# Задание 6
Код к этому заданию оформила в отдельном [каталоге](https://github.com/OlgaLesnykh/DevOps/blob/main/Terraform/4/src/task_6).    
Используя пример из официального яндекс клауд терраформ модуля [https://github.com/terraform-yc-modules/terraform-yc-s3](https://github.com/terraform-yc-modules/terraform-yc-s3), создаю бакет размером 1 Гб - добавляю в файл providers.tf информацию о провайдере aws, создаю уникальное имя бакета с помощью ресурса random_string и задаю размер бакета с помощью переменной max_size (указываю размер в байтах). Бакет успешно создается:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_048.png)    
# Задание 7
Код к этому заданию оформила в отдельном [каталоге](https://github.com/OlgaLesnykh/DevOps/blob/main/Terraform/4/src/task_7).    
Используя docker-compose.yml в проекте, развернула локально vault:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_049.png)    
Авторизовалась в веб-интерфейсе с помощью токена "education" и создала новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create Path: example
secret data key: test_secret_data value: congrats!    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_050.png)    
Считываю этот секрет с помощью terraform и вывожу его в output:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_051.png)    
Теперь необходимо записать новый секрет в vault с помощью terraform. Секрет будет иметь следующие параметры: Path: test
secret data key: TEST_PASSWORD value: 123gfgtFDfdR@123gfgfhtfsd. Добавлю в файл main.tf ресурс:    
```
resource "vault_generic_secret" "vault_test" {
  path = var.vault_test_path
  data_json = <<EOT
{
  "TEST_PASSWORD": "${var.my_pass}"
}
EOT
}
```
Выполняю ```terraform apply``` и проверяю в админке vault, что секрет появился:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_052.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_053.png)    