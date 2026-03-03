# Project Tracking System

## 项目概述
项目管理系统 - 类似 Asana 的协作平台

## 技术栈

### 后端
- Java 17
- Spring Boot 3.x
- Oracle Database
- Spring Data JPA / MyBatis
- Spring Security

### 前端
- React 18
- Vite
- Ant Design Pro
- Redux Toolkit / Zustand
- React Router

### 部署
- Docker
- Nginx

## 项目结构

```
Project-tracking/
├── backend/          # 后端服务
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/projecttracking/
│   │   │   │   ├── config/
│   │   │   │   ├── controller/
│   │   │   │   ├── service/
│   │   │   │   ├── repository/
│   │   │   │   ├── model/
│   │   │   │   ├── security/
│   │   │   │   └── dto/
│   │   │   └── resources/
│   │   └── test/
│   ├── pom.xml
│   └── Dockerfile
├── frontend/         # 前端应用
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── store/
│   │   ├── api/
│   │   └── utils/
│   ├── package.json
│   └── vite.config.js
├── docs/            # 文档
└── scripts/         # 部署脚本
```

## 快速开始

### 环境要求
- Java 17+
- Node.js 18+
- Oracle Database 19c+
- Docker & Docker Compose

### 初始化数据库

```bash
# 创建数据库和用户
sqlplus system/oracle@localhost:1521/XE

# 执行 schema 脚本
@backend/src/main/resources/schema.sql
```

### 启动后端

```bash
cd backend
mvn spring-boot:run
```

### 启动前端

```bash
cd frontend
npm install
npm run dev
```

## Git 仓库
https://github.com/kirkfranzyimyalw-bot/Project-tracking.git

## License
MIT
