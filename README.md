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
