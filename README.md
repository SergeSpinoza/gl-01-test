# gl-01-test


## Подключение командой через промежуточный сервер:

```ssh -i ~/.ssh/rsa_key -tA user@host ssh user@host```

## Подключение сокращенной командой по аллиасу (доп. задание):

создать в папке
` ~/.ssh/`  файл config
и прописать следующее:

``` 
Host ga01
  user username
  hostname ip/host
  identityfile ~/.ssh/rsa_key
  
Host ga02
  user username
        hostname ip/host
  ProxyCommand  ssh username@ga01 -W %h:%p


bastion_ip 35.240.121.87
someinternalhost_ip 10.132.0.3

```

================================================================================


# Homework-6 

_создание виртуальной машины:_

```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
```
  
#### Взять скрипт startup из удаленного репозитория:

 ``` --metadata startup-script-url=gs://gangybas/startup_scrypt.sh ```
 
#### Взять скрипт startup из локальной машины домашней директориии юзера:

```--metadata-from-file startup-script=startup_scrypt.sh ```


#### Создание правила фаервола:

```
gcloud compute firewall-rules create puma-web-open \
    --network default \
    --action allow \
    --direction ingress \
    --rules tcp:9292 \
    --source-ranges 0.0.0.0/0 \
    --priority 1000 \
    --target-tags puma-server
```
#### Адрес для покдлючения:

```   
testapp_ip = 35.233.93.6
testapp_port = 9292
```


================================================================================




# Homework-07

#### Задание со *:

__Ключи указываются без пробела в main.tf__

пример:

__main.tf__

```
 metadata {
    ssh-keys = "app-user:${file(var.public_key_path)}app-user2:${file(var.public_key_path)}"
  }
```

__variables.tf__

```
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
```
__terraform.tfvars__

```
public_key_path = "~/.ssh/app-user.pub"
```

задание с **:

1. из проблем достаточно большое колличество посторонних ресурсов для поднятия балансера
2. при копировании машины это занимает большое колличества места в коде а так же приходится прописывать эти машины в группу для добавление в балансер что крайне не удобно.
3. добавление инстанса производится через опцию __count__ в name прописать __count.index__ к имени.

================================================================================



# Homework-08



Весь код переведен в модули __app__ и __db__
 

1. При запуске кода база и приложение находятся на разных инстансах. 
2. Реализовано подключение по внутреннему ip к базе mongodb. 
3. Реализованно включение и отключение провиженнеров.





# Homework-09

1. При  применении команды `ansible-playbook clone.yml`

   Если дирректория существует то вывод:
   
  `appserver: ok=2    changed=0    unreachable=0    failed=0`
  
   Если отсуствует то:
  
  `appserver: ok=2    changed=1    unreachable=0    failed=0`
  
2. Добавлен скрипт на python, который читает ansible.json (в формате json). Для проверки необходимо выполнить команду ansible all -i inventory.py -m ping


# Homework-10

## В процессе сделано:
* Сделаны плейбуки для деплоя приложения на инстансы
* сделан динамический инвентори

## Как запустить проект:
* Зайти в директорию terraform/stage
  запустить terraform apply
* В ansible.cfg указан динамический инвентори подключенный к gcloud что позволит запустить плейбук без введения дополнительной команды/
* Можно измениит cfg и выбрать статический инвентори и указать в нем ip инстансов.
* в директории ansible запустить `ansible-playbook site.yml` либо `ansible-playbook -i inventory site.yml`

## Как проверить работоспособность:
* перейти по ссылке http://app-ip:9292

## Задание со *
установка dynamic inventory gce.py
установить библиотеки для питона:
`apache-libcloud`
`pycrypto`

Создать сервисный аккаунт либо получить имеющуюся конфигурацию сервисного аккаунта в формате `json` и сохранить в папку с `ansible`.

Клонировать репо
`git clone https://github.com/ansible/ansible`
Перенесети файлы в папку с ансиблом

```
cp ansible/contrib/inventory/gce.py ~/git/ansible/inventory/
cp ansible/contrib/inventory/gce.ini ~/git/ansible/inventory/
```
сконфигураировать gce.ini

```
gce_service_account_email_address = # Service account email found in ansible json file
gce_service_account_pem_file_path = # Path to ansible service account json file
gce_project_id = # Your GCE project name
```
добавить глобальную переменную пути к gce.ini

` export GCE_INI_PATH=~/git/ansible/gce.ini`

проверить можно запустив скрипт
`~/git/ansible/inventory/gce.py — list

1. В данном задании были заробраны playbooks.
2. Установлен динамический инвентарь gce.py для более удобного управления облачной инфраструктурой.
3. интеграция провиженнера packer+ansible

