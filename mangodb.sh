cp mangodb.service  /etc/yum.repos.d/mongo.repo # Copy the systemd service file to the appropriate location

dnf install -y  mangodb-org  # Install MongoDB
systemctl enable mongod
systemctl start mongod

sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf

systemctl restart mongod