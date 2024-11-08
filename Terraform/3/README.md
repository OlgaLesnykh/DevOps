# Задача 1
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_018.png)    
# Задача 2
Переменные для одинаковых ВМ с именами "web-1" и "web-2" находятся в файле web_variables.tf    
Переменные для ВМ с именами "main" и "replica" находятся в файле db_variables.tf    
Код [здесь](https://github.com/OlgaLesnykh/DevOps/tree/main/Terraform/3/src).
Ресурсы успешно создаются:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_019.png)    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_020.png)    
# Задача 3
Переменные для виртуальных дисков и ВМ c именем "storage" находятся в файле storage_variables.tf    
    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_021.png)    
# Задача 4
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_022.png)    
# Задача 5
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_023.png)    

Исправленный вариант: 
Добавила локальные переменные для ресурсов count и for_each в файле locals.tf. В output объединила словари в список функцией concat. output теперь выводится в виде списка словарей:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_029.png)    
# Задача 6
Плейбук успешно выполняется.
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_024.png)    
Добавляю в файл-шаблон hosts.tftpl условие использовать внутренний ip при отсутствии внешенего, выключаю для веб-серверов nat, при выполнении плейбука получаю ошибку ```Failed to connect to the host via ssh: ssh: connect to host 10.0.1.32 port 22: Connection timed out```, что логично.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_025.png)    
Вроде бы явно по условию задачи создание бастион-хоста не предусмотрено, но осталось какое-то чувство незавершенности. Попробую организовать подключение через бастион-хост - создаю в файле bastion.tf виртуальную машину с внешним ip, которая будет выполнять роль бастиона, добавляю переменные для этой машины в файл hosts.tftpl, а также добавляю еще одни блок [all:vars] и прописываю в нем переменную ansible_ssh_common_args ```ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q lesnykh@${i["network_interface"][0]["nat_ip_address"]}"'``` (команда для подключения к моим веб-серверам через бастион). ```terraform apply```. в первый раз плейбук выполнился только для первого веб-сервера:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_027.png)    
Выполняю ```terraform apply``` еще раз, теперь плейбук успешно выполняется для обоих веб-серверов.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_026.png)    
Раньше уже сталкивалась с такой ситуацией, что при проверке доступности машин с помощью ansible через бастион первый раз не все машины пингуются, при повторном и последующих подключениях всё хорошо, почему так происходит? Если в контексте этой домашней работы вопрос неуместен, задам его в следующем модуле, когда будем проходить ansible.
# Задача 7
Не справилась(( Создала для экспериментов в файле task7.tf локальную переменную:    
```
locals  {
  vpc = [
    {network_id = ["enp7i560tb28nageq0cc"]},
    {subnet_ids = [
      "e9b0le401619ngf4h68n",
      "e2lbar6u8b2ftd7f5hia",
      "b0ca48coorjjq93u36pl",
      "fl8ner8rjsio6rcpcf0h",
    ]},
    {subnet_zones = [
      "ru-central1-a",
      "ru-central1-b",
      "ru-central1-c",
      "ru-central1-d",
    ]},
  ]
}
```
Дальше произошел затуп - не могу понять, как хотя бы для начала обратиться к какому-то элементу списка значений, где их несколько (subnet_ids и subnet_zones). Кажется я перепробовала все возможные варианты, может я переменную как-то неправильно записала? Максимум, что мне удавалось получить, кроме вывода всей переменной - это полностью список значений для какого-то блока (например, local.vpc[1]):    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/Terraform_028.png)    
Дайте, пожалуйста, подсказку. Решить эту задачу теперь дело принципа, я на нее потратила оооочень много времени и без результата, обидно(
# Задача 8
Идентифицировать и устранить намеренно допущенную в tpl-шаблоне ошибку. 
```
[webservers]
%{~ for i in webservers ~}
${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"] platform_id=${i["platform_id "]}}
%{~ endfor ~}
```
В указанном шаблоне ошибки в строке ```${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"] platform_id=${i["platform_id "]}}```: лишний пробел в описании переменной platform_id и пропущена закрывающая фигурная скобка в описании переменной ansible_host, вернее она есть, но указана не в том месте - в конце строки.    
Исправленный работающий вариант:    
```
[webservers]
%{~ for i in webservers ~}
${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]} platform_id=${i["platform_id"]}
%{~ endfor ~}
```