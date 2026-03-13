# 快速部署指南

## 发布到 GitHub

1. **创建 GitHub 仓库**
   - 访问 https://github.com/new
   - 仓库名称：`lab-member-system`（或自定义）
   - 设置为 Public 或 Private
   - 不要初始化 README（已有文件）

2. **推送代码**
   ```bash
   cd "F:/Projects/成果收集系统/ccpl"
   git remote add origin https://github.com/你的用户名/lab-member-system.git
   git push -u origin main
   ```

3. **启用 GitHub Pages（可选）**
   - 进入仓库 Settings → Pages
   - Source 选择 `main` 分支
   - 访问 `https://你的用户名.github.io/lab-member-system/form.html`

## 发布到 Docker Hub

1. **登录 Docker Hub**
   ```bash
   docker login
   ```

2. **构建镜像**
   ```bash
   cd "F:/Projects/成果收集系统/ccpl"
   docker build -t 你的用户名/lab-member-system:latest .
   ```

3. **推送到 Docker Hub**
   ```bash
   docker push 你的用户名/lab-member-system:latest
   ```

4. **添加标签（可选）**
   ```bash
   docker tag 你的用户名/lab-member-system:latest 你的用户名/lab-member-system:v1.0.0
   docker push 你的用户名/lab-member-system:v1.0.0
   ```

## 使用已发布的 Docker 镜像

其他人可以直接使用：

```bash
# 拉取镜像
docker pull 你的用户名/lab-member-system:latest

# 运行容器
docker run -d -p 8080:80 --name lab-system 你的用户名/lab-member-system:latest

# 访问 http://localhost:8080/form.html
```

或使用 Docker Compose：

```yaml
version: '3.8'
services:
  web:
    image: 你的用户名/lab-member-system:latest
    ports:
      - "8080:80"
    restart: unless-stopped
```

## 本地测试 Docker

在推送前先本地测试：

```bash
# 构建
docker build -t lab-member-system .

# 运行
docker run -d -p 8080:80 --name test-lab lab-member-system

# 测试
curl http://localhost:8080/form.html

# 停止并删除
docker stop test-lab && docker rm test-lab
```

## 更新 README

记得在 README.md 中更新：
- 替换 `your-username` 为你的 GitHub 用户名
- 添加 Docker Hub 镜像地址
- 添加在线演示链接（如果使用 GitHub Pages）

## 添加徽章（可选）

在 README.md 顶部添加：

```markdown
![Docker Image Size](https://img.shields.io/docker/image-size/你的用户名/lab-member-system)
![Docker Pulls](https://img.shields.io/docker/pulls/你的用户名/lab-member-system)
![GitHub Stars](https://img.shields.io/github/stars/你的用户名/lab-member-system)
```
