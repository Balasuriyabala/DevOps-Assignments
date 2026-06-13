# FitnessTrack Deployment Guide

## Stack
- **Frontend**: React (served via `serve` on port 3000)
- **Backend**: Node.js / Express on port 8080
- **Database**: Azure Cosmos DB for MongoDB
- **Web Server**: Nginx (reverse proxy + SSL)
- **Process Manager**: PM2

---

## 1. MongoDB Connection

Password with special characters (`&`) must be **URL-encoded** in `.env`:

```env
MONGODB_URL=mongodb+srv://food:password@food-db.global.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000
PORT=8080
```

> `&` → `%26` in connection string only. Raw `&` is safe inside `.env` files too.

To connect via mongosh:
```bash
mongosh "mongodb+srv://food-db.global.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000" \
  --username food \
  --password 'your-password'
```

---

## 2. PM2 Setup

```bash
npm install -g pm2 serve

# Start frontend
cd /home/azureuser/FItnessTrack/client

pm2 start "serve -s build -l 3000" --name fitness-fe

# Start backend

cd /home/azureuser/FItnessTrack/server
pm2 start npm --name fitness-be -- start

# Save and enable auto-start on reboot
pm2 save
pm2 startup  # run the command it outputs
```

---

## 3. SSL Certificate Setup

Upload certificates from local machine:
```bash
scp ca.cer fitnesscnapp.work.gd.cer fitnesscnapp.work.gd.key azureuser@<server-ip>:/home/azureuser/
```

Move to ssl directory on server:
```bash
sudo mkdir -p /etc/ssl/fitnesscnapp
sudo cp ca.cer /etc/ssl/fitnesscnapp/ca.crt
sudo cp fitnesscnapp.work.gd.cer /etc/ssl/fitnesscnapp/fitnesscnapp.work.gd.crt
sudo cp fitnesscnapp.work.gd.key /etc/ssl/fitnesscnapp/fitnesscnapp.work.gd.key
sudo chmod 600 /etc/ssl/fitnesscnapp/fitnesscnapp.work.gd.key
```

---

## 4. Nginx Config

File: `/etc/nginx/sites-available/fitnesstrack`

```nginx
# Redirect HTTP to HTTPS
server {
    listen 80;
    server_name fitnesscnapp.work.gd www.fitnesscnapp.work.gd;
    return 301 https://$host$request_uri;
}

# HTTPS server
server {
    listen 443 ssl;
    server_name fitnesscnapp.work.gd www.fitnesscnapp.work.gd;

    ssl_certificate     /etc/ssl/fitnesscnapp/fitnesscnapp.work.gd.crt;
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
```

Enable and restart:
```bash
sudo ln -s /etc/nginx/sites-available/fitnesstrack /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

---

## 5. Azure Firewall — Open Ports

In **Azure Portal → VM → Networking → Add inbound port rule**:
- Port `80` (HTTP)
- Port `443` (HTTPS)

---

## Quick Reference

```bash
pm2 list                  # check running processes
pm2 logs fitness-be       # backend logs
pm2 logs fitness-fe       # frontend logs
pm2 restart all           # restart everything
sudo systemctl restart nginx  # restart nginx
sudo nginx -t             # test nginx config
```
