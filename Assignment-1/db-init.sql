CREATE DATABASE app_db;
CREATE USER 'app_user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON app_db.* TO 'app_user'@'%';
FLUSH PRIVILEGES;
USE app_db;
CREATE TABLE messages (id INT AUTO_INCREMENT PRIMARY KEY, message
TEXT);
INSERT INTO messages (message) VALUES ('Hello, Docker Compose!');
root@dockervm:/home/azureuser/docker-compose-project#
