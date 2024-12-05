# Домашнее задание к занятию 7 «Жизненный цикл ПО»

## Основная часть

Создаю workflow для двух типов задач: bug и остальные типы задач (other). Задачи типа bug проходят следующий жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.
Схема workflow:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/CICD_001.png)    
Схема, импортированная в XML находится [здесь](https://github.com/OlgaLesnykh/DevOps/blob/main/Ansible/09-ci-01-intro/Bug_workflow).    

Остальные задачи должны проходят по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

Схема workflow:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/CICD_002.png)    
Схема, импортированная в XML находится [здесь](https://github.com/OlgaLesnykh/DevOps/blob/main/Ansible/09-ci-01-intro/Other_workflow).    
Привязка workflow к определенным типам задач в проекте:    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/CICD_003.png)     
Настроила столбцы для доски, добавила к существующим столбец ON TEST, чтобы было наглядно, сколько задач на тестировании.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/CICD_004.png)     

**Что нужно сделать**

1. Создала задачу "Bug 1" с типом bug, провела ее по всему workflow до Done.     
2. Создала задачу "Big error" с типом epic, к ней привязала три задачи "Small error 1", "Small error 2",  "Small error 3" с типом task, провела их по всему workflow до Done.     
3. При проведении обеих задач по статусам использовала kanban.     
4. Вернула задачи в статус Open.    
![](https://github.com/OlgaLesnykh/screenshots/blob/main/CICD_005.png)    
5. Перехожу в Scrum, запланировала новый спринт, состоящий из задач эпика и одного бага, стартовала спринт, провела задачи до состояния Closed. Закрыла спринт.    
6. Всё отработалось в рамках ожидания.