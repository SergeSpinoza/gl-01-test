# gl-01-test

#подключение командой через промежуточный сервер
ssh -i ~/.ssh/rsa_key -tA user@host ssh user@host

#подключение скокращенной командой по аллиасу (доп. задание)

создать в папке ~/.ssh/ файл config
и прописать сдел:

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




Homewirk 6 

создание виртуальный машины: 

gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
#Взять скрипт стартап из удаленного репозитория
  --metadata startup-script-url=gs://gangybas/startup_scrypt.sh 
#Взять скприпт стартап из локальной машины из домашней директориии юзера
#--metadata-from-file startup-script=startup_scrypt.sh 


Создание правила фаервола:

gcloud compute firewall-rules create puma-web-open \
    --network default \
    --action allow \
    --direction ingress \
    --rules tcp:9292 \
    --source-ranges 0.0.0.0/0 \
    --priority 1000 \
    --target-tags puma-server
  

testapp_ip = 35.233.93.6
testapp_port = 9292
