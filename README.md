# 课题组成员信息收集系统

[![GitHub Release](https://img.shields.io/github/v/release/Exekiel179/ccpl)](https://github.com/Exekiel179/ccpl/releases)
[![Docker Image](https://img.shields.io/badge/docker-ghcr.io-blue)](https://ghcr.io/exekiel179/ccpl)

一个轻量级的课题组成员信息收集与管理系统，纯前端实现，无需后端服务器。

## 功能特性

- 📝 **信息收集表单** - 收集成员基本信息、学术背景、论文成果等
- 🖼️ **证件照上传** - 支持 JPG/PNG 格式，最大 5MB
- 📊 **后台管理** - 密码保护的管理界面，查看、导出、删除数据
- 💾 **本地存储** - 使用 localStorage 存储数据，无需数据库
- 📱 **响应式设计** - 适配桌面和移动设备
- 📤 **CSV 导出** - 一键导出所有数据为 CSV 文件

## 快速开始

### 方式一：直接使用

1. 克隆仓库：
```bash
git clone https://github.com/your-username/lab-member-system.git
cd lab-member-system
```

2. 使用任意 Web 服务器打开 `form.html`：
```bash
# 使用 Python
python -m http.server 8000

# 使用 Node.js
npx serve

# 或直接用浏览器打开 form.html
```

3. 访问：
   - 表单页面：`http://localhost:8000/form.html`
   - 管理后台：`http://localhost:8000/admin.html`（默认密码：`lab2024`）
   - 数据备份：`http://localhost:8000/backup.html`

### 方式二：使用 Docker（从 GHCR 拉取）

```bash
# 拉取并运行镜像
docker run -d -p 8080:80 --name lab-system ghcr.io/exekiel179/ccpl:latest

# 访问 http://localhost:8080/form.html
```

### 方式三：使用 Docker（本地构建）

```bash
# 构建镜像
docker build -t lab-member-system .

# 运行容器
docker run -d -p 8080:80 --name lab-system lab-member-system

# 访问 http://localhost:8080/form.html
```

### 方式四：使用 Docker Compose

```bash
docker-compose up -d
```

## 配置说明

### 端口配置

使用环境变量自定义端口：

```bash
# 创建 .env 文件
cp .env.example .env

# 编辑 .env 修改端口
PORT=3000

# 启动服务
docker-compose up -d
```

或直接指定：
```bash
docker run -d -p 3000:80 ghcr.io/exekiel179/ccpl:latest
```

### LocalStorage 数据管理

访问 `http://localhost:8080/backup.html` 进行数据备份和恢复：
- **导出数据**：将浏览器 localStorage 数据导出为 JSON 文件
- **恢复数据**：从备份文件恢复数据
- **查看数据**：查看原始 JSON 数据

**重要**：建议定期备份数据，避免浏览器缓存清除导致数据丢失。

详细配置请查看 [CONFIG.md](CONFIG.md)。

### 修改管理员密码

编辑 `admin.html` 第 99 行：
```javascript
const ADMIN_PWD = 'lab2024';  // 修改为你的密码
```

### 自定义样式

两个 HTML 文件的 `<style>` 标签内包含所有样式，可根据需要修改颜色、字体等。

## 文件说明

```
.
├── form.html          # 信息收集表单页面
├── admin.html         # 后台管理页面
├── Dockerfile         # Docker 镜像构建文件
├── docker-compose.yml # Docker Compose 配置
├── nginx.conf         # Nginx 配置文件
└── README.md          # 项目说明文档
```

## 数据存储

- 数据存储在浏览器的 localStorage 中
- 键名：`lab-submissions`
- 格式：JSON 数组
- 注意：清除浏览器数据会导致数据丢失，建议定期导出备份

## 技术栈

- 纯 HTML + CSS + JavaScript
- 无框架依赖
- localStorage API
- FileReader API（图片上传）
- Blob API（CSV 导出）

## 浏览器兼容性

- Chrome 60+
- Firefox 55+
- Safari 11+
- Edge 79+

## 注意事项

1. **数据安全**：本系统使用前端存储，不适合存储敏感信息
2. **密码保护**：管理员密码硬编码在前端，仅提供基础保护
3. **数据备份**：定期使用"导出 CSV"功能备份数据
4. **存储限制**：localStorage 通常限制 5-10MB，大量数据可能超限

## 生产环境建议

如需在生产环境使用，建议：
- 使用 HTTPS 协议
- 定期备份 localStorage 数据
- 考虑迁移到后端数据库方案
- 实现真正的用户认证系统

## License

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！
