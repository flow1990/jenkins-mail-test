# Verwenden Sie das Nginx-Image als Basisimage
FROM nginx

# Kopieren Sie die Compodoc-Dateien in das Standard-Verzeichnis von Nginx
COPY documentation /usr/share/nginx/html

# Exponieren Sie den Port, auf dem der Webserver laufen wird (z.B. Port 80)
EXPOSE 80

# Starten Sie Nginx, wenn der Container ausgeführt wird
CMD ["nginx", "-g", "daemon off;"]
