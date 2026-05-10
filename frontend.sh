dnf install -y nginx # install nginx 

cp -r nginx.conf /etc/nginx/nginx.conf # coping the config file to nginx

curl -fsSL https://rpm.nodesource.com/setup_20.x | bash - # downloading nodejs script
dnf install -y nodejs

curl -L -o /tmp/frontend.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/frontend.zip
mkdir -p /tmp/frontend && cd /tmp/frontend
unzip /tmp/frontend.zip
npm install # installing the dependencies
npm run build  # building the application
rm -rf /usr/share/nginx/html/* 
cp -r out/* /usr/share/nginx/html/ # copying the build files to nginx html directory

systemctl enable nginx
systemctl restart nginx