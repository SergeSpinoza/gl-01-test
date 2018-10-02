[Unit]
Description=PumaService

[Service]
Type=simple
WorkingDirectory=/home/gangybas/reddit
User=gangybas
Group=gangybas
Environment=DATABASE_URL=${ip_db} 
OOMScoreAdjust=-1000
ExecStart=/usr/bin/bundle exec puma
Restart=always

[Install]
WantedBy=multi-user.target
