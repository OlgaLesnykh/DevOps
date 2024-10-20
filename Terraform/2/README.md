# Задание 1
Ошибки в проекте:    
Ошибка 1: неверно указан путь до файла с ключами авторизации, для исправления указываем путь полностью;    
Ошибка 2: не найдена платформа standart-v4, во-первых, исправляем на standard-v1 (Intel Broadwell) и проверяем доступная 
ли описана конфигурация по производительности, vCPU и RAM, исправляем значение cores с 1 на 2, поскольку для нашей платформы доступно только 2 или 4 vCPU.    
Успешно создаем ВМ:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_012.png)    
# Задание 2
Все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance заменила на отдельные переменные. Код можно посмотреть [здесь](https://github.com/OlgaLesnykh/DevOps/tree/main/Terraform/2/Task_2). Единственный нюанс: значение параметра метаданных serial-port-enable в исходном варианте кода было 1, по смыслу это переменная типа boolean, которая вроде как может кроме значений true и false принимать значения 1 и 0, но при присвоении дефолтного значения 1, терраформ выдал мне ошибку ```This default value is not compatible with the variable's type constraint: bool required.``` А при присвоении значения true и последующего применения изменений (да, я вижу, что в задании написано, что изменений быть не должно, но интересно попробовать:) с 1 на true серийная консоль не работает. Сделала тип данных number и присвоила значение 1, всё работает, консоль доступна, но как-то мне не нравится.. Подскажите, как правильно поступать в таких случаях? Всё-таки number?
# Задание 3
Для того, чтобы создать вторую виртуальную машину, работающую в зоне ru-central1-b, создаю вторую подсеть в этой зоне и дополнительно добавляю параметр zone в описание конфигурации второй ВМ. Две виртуальные машины успешно созданы. Код [здесь](https://github.com/OlgaLesnykh/DevOps/tree/main/Terraform/2/Task_3).    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_013.png)    
# Задание 4
Файл outputs.tf [здесь](https://github.com/OlgaLesnykh/DevOps/tree/main/Terraform/2/Task_3_4/outputs.tf). . К сожалению у меня не получилось по заданию вывести только ip-адреса, буду признательна, если подскажете, как это сделать.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_014.png)    
# Задание 5
Код [здесь](https://github.com/OlgaLesnykh/DevOps/tree/main/Terraform/2/Task_5_6). Имя ВМ состоит из переменной, определенной ранее, описывающей имя ВМ, и переменной, содержащей фамилию владельца проекта (мою), которую объявила специально для этого задания.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_015.png)    
# Задание 6
Код [здесь](https://github.com/OlgaLesnykh/DevOps/tree/main/Terraform/2/Task_5_6).
# Задание 7
1. ```local.test_list[1]```
2. ```length(local.test_list)```
3. ```keys(local.test_map)[0]```
4. ```"${local.test_map.admin} is ${keys(local.test_map)[0]} for ${local.test_list[2]} server based on OS ${local.servers.production.image} with ${local.servers.production.cpu} vcpu, ${local.servers.production.ram} ${keys(local.servers.production)[3]} and ${tostring(length(local.servers.production.disks))} virtual ${keys(local.servers.production)[1]}"```
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_016.png)    
# Задание 8
Предполагаю, что мне не удалось в полной мере выполнить то, что требует это задание.
Наиболее простой вариант, который мне видится и работает:    
```
variable "test" {
type = map(any)
default = { 
  "dev1" = ["ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117", "10.0.1.7"]
  "dev2" = ["ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88", "10.0.2.29"]
  "prod1" = ["ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101", "10.0.1.30"]
  }
}
```
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_017.png)    
# Задание 9
Код [здесь](https://github.com/OlgaLesnykh/DevOps/tree/main/Terraform/2/Task_9). После создания инстансов, привязываю внешний ip адрес к каждой машине через консоль управления яндекс, подключаюсь по ssh, создаю пароль для пользователя ubuntu, после чего внешний ip отвязываю. Подключаюсь к серийной консоли каждой машины и проверяю работу шлюза с помощью команды ```ping yandex.ru```, адрес пингуется, при этом извне к машинам подключиться невозможно, значит шлюз настроен верно.