FROM nginx:latest
COPY index.html /usr/share/nginx/html
COPY assets /usr/share/nginx/html/assets
COPY vendors /usr/share/nginx/html/vendors
CMD ["nginx", "-g", "daemon off;"]
