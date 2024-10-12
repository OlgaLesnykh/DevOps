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
