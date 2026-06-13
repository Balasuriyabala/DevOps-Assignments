This project contain application are deployed in azure cloud 
VNET, VM, COSMODB mongodb (private access)

For connectivity update the clinet/src/api/index.js baseurl and in the backend create a .env file with db connection string with portnumber, jwt token

Application are exposed via pm2 Host based application

start application using a pm2 for that run following command

FrontEnd:

npm run build
        
npm install -g serve
        
npm install -g pm2
       
pm2 start "serve -s build -l 3000" --name fitness-fe

BackEnd:

npm run build
            
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

SSL CERTIFICATE:

we have generated from website downloaded in local machine and moved to server

scp -i "C:\Users\DELL\Desktop\food-vnet_key.pem" ca.cer fitnesscnapp.work.gd.cer fitnesscnapp.work.gd.key 

azureuser@<ip>:/home/azureuser/

once the files are moved to server and then move ssl folder [etc/ssl/fintnesscnapp/] and correct the permission for those.

<img width="393" height="58" alt="image" src="https://github.com/user-attachments/assets/70061cb6-987a-4a11-8eb3-8712b4dc7ac5" />


nginx configuration:

root@food-vnet:/etc/nginx/sites-available# cat fitnessapp

# Redirect HTTP to HTTPS

server {
    listen 80;
    
    server_name fitnesscnapp.work.gd www.fitnesscnapp.work.gd;
    
    return 301 https://$host$request_uri;

}


# HTTPS

server {

    listen 443 ssl;
    
    server_name fitnesscnapp.work.gd www.fitnesscnapp.work.gd;

    ssl_certificate /etc/ssl/fitnesscnapp/fitnesscnapp.work.gd.crt;
    
    ssl_certificate_key /etc/ssl/fitnesscnapp/fitnesscnapp.work.gd.key;
    
    ssl_trusted_certificate /etc/ssl/fitnesscnapp/ca.crt;


    ssl_protocols TLSv1.2 TLSv1.3;
    
    ssl_ciphers HIGH:!aNULL:!MD5;

    # Frontend
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # Backend API
    location /api/ {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}












