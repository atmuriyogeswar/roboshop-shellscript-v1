dnf install -y golang git mysql8.4  # Install Go, Git, and MySQL

cp catalogue.service /etc/systemd/system/catalogue.service # Copy the systemd service file to the appropriate location

curl -L -o /tmp/catalogue.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/catalogue.zip
rm -rf /app
mkdir -p /app
cd /app
unzip /tmp/catalogue.zip
mysql -h 10.0.0.4 -u root -pRoboShop@1 < db/schema.sql
mysql -h 10.0.0.4 -u root -pRoboShop@1 < db/app-user.sql
mysql -h 10.0.0.4 -u root -pRoboShop@1 catalogue < db/master-data.sql

useradd -r -s /bin/false appuser # Create a system user for running the application
cd /app
go mod tidy
CGO_ENABLED=0 go build -o /app/catalogue .
chown -R appuser:appuser /app
chmod o-rwx /app -R

systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

