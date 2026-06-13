This project contain application are deployed in azure cloud 

1. vnet

2. vm

3. CosomoDB mongodb with private access 

For connectivity update the clinet/src/api/index.js baseurl and in the backend create a .env file with db connection string with portnumber, jwt token


Application are exposed via pm2 

start application using a pm2 for that run following command
        F.E: npm run build
        npm install -g serve
        npm install -g pm2
        pm2 start "serve -s build -l 3000" --name fitness-fe

       B.E: npm run build
            pm2 start npm --name fitness-be -- start


<img width="512" height="103" alt="image" src="https://github.com/user-attachments/assets/7c0adcb8-75a8-4e38-a8f5-92ca75706c6e" />


With Nginx:

server {
    listen 80;
    server_name <ip>; or dns name;

    access_log /var/log/nginx/myapp_access.log;
    error_log  /var/log/nginx/myapp_error.log;

    # FRONTEND STATIC FILES
    root  /home/azureuser/FItnessTrack/client/build;
    index index.html;

    location / {
        try_files $uri /index.html;
    }

    # BACKEND API
    location /api/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

IP INTO DNS:

login into dns site 

with yous dns name paste your ip and check with nslookup

<img width="373" height="150" alt="image" src="https://github.com/user-attachments/assets/a9535193-8af8-49af-8f69-65be7cce559a" />









