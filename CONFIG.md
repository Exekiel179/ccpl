# 配置指南

## 端口配置

### 方法 1：使用环境变量（推荐）

创建 `.env` 文件：
```bash
cp .env.example .env
```

编辑 `.env` 文件修改端口：
```env
PORT=8080  # 修改为你想要的端口
```

然后启动：
```bash
docker-compose up -d
```

### 方法 2：直接指定端口

```bash
# 使用 docker run
docker run -d -p 3000:80 --name lab-system ghcr.io/exekiel179/ccpl:latest

# 使用 docker-compose 临时覆盖
PORT=3000 docker-compose up -d
```

## LocalStorage 数据管理

### 问题说明

浏览器的 localStorage 数据存储在客户端，每个浏览器独立存储。容器重启不会丢失数据，但以下情况会导致数据丢失：
- 清除浏览器缓存
- 更换浏览器或设备
- 使用隐私模式

### 解决方案

#### 1. 定期备份（推荐）

访问备份页面：`http://localhost:8080/backup.html`

功能：
- **导出数据**：将 localStorage 数据导出为 JSON 文件
- **恢复数据**：从备份文件恢复数据
- **查看数据**：查看原始 JSON 数据

建议每周备份一次数据。

#### 2. 使用管理后台导出

访问：`http://localhost:8080/admin.html`
- 登录后点击"导出 CSV"按钮
- 数据会以 CSV 格式下载

#### 3. 浏览器开发者工具手动备份

1. 打开浏览器开发者工具（F12）
2. 进入 Console 标签
3. 运行以下命令：

```javascript
// 导出数据
const data = localStorage.getItem('lab-submissions');
console.log(data);
// 复制输出的 JSON 字符串保存到文件

// 恢复数据
const backupData = '粘贴你的备份 JSON 数据';
localStorage.setItem('lab-submissions', backupData);
location.reload();
```

## 管理员密码配置

默认密码：`lab2024`

### 修改密码

编辑 `admin.html` 文件第 99 行：

```javascript
const ADMIN_PWD = 'your-new-password';  // 修改为你的密码
```

然后重新构建镜像：

```bash
docker build -t ghcr.io/exekiel179/ccpl:latest .
docker-compose up -d --build
```

## 数据持久化最佳实践

### 方案 1：定期自动备份（推荐）

创建定时任务，每天自动访问备份页面并下载数据：

```bash
# Linux/Mac crontab
0 2 * * * curl http://localhost:8080/backup.html > /dev/null
```

### 方案 2：迁移到后端存储

如果数据量大或需要多人协作，建议：
1. 添加后端 API（如 Node.js + MongoDB）
2. 将 localStorage 改为 API 调用
3. 使用数据库持久化存储

### 方案 3：使用云存储

修改代码，将数据同步到：
- GitHub Gist
- 云存储服务（OSS、S3）
- 自建 API 服务

## 容器数据卷配置

当前配置已包含备份目录挂载：

```yaml
volumes:
  - ./backups:/usr/share/nginx/html/backups
```

这允许你在容器内保存备份文件到宿主机的 `./backups` 目录。

## 完整部署示例

```bash
# 1. 克隆仓库
git clone https://github.com/Exekiel179/ccpl.git
cd ccpl

# 2. 配置端口
cp .env.example .env
# 编辑 .env 修改 PORT=8080

# 3. 启动服务
docker-compose up -d

# 4. 访问服务
# 表单页面: http://localhost:8080/form.html
# 管理后台: http://localhost:8080/admin.html
# 数据备份: http://localhost:8080/backup.html

# 5. 定期备份
# 每周访问 backup.html 导出数据
```

## 故障排查

### 端口被占用

```bash
# 查看端口占用
netstat -ano | findstr :8080  # Windows
lsof -i :8080                 # Linux/Mac

# 修改 .env 中的 PORT 为其他端口
```

### 数据丢失

1. 检查浏览器是否清除了缓存
2. 确认访问的是同一个域名和端口
3. 从备份文件恢复数据

### 容器无法启动

```bash
# 查看日志
docker logs lab-member-system

# 重启容器
docker-compose restart
```
