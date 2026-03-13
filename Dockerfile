# 使用 Nginx 作为 Web 服务器
FROM nginx:alpine

# 复制 HTML 文件到 Nginx 默认目录
COPY form.html /usr/share/nginx/html/
COPY admin.html /usr/share/nginx/html/
COPY backup.html /usr/share/nginx/html/

# 复制自定义 Nginx 配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 创建备份目录
RUN mkdir -p /usr/share/nginx/html/backups

# 暴露 80 端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
