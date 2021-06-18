DROP DATABASE IF EXISTS playlister;
CREATE DATABASE playlister;
GRANT ALL PRIVILEGES ON playlister.* TO 'playlister'@'%' IDENTIFIED BY 'playlister_password';
FLUSH PRIVILEGES;
