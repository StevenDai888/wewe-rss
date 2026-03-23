# WeWe RSS - Railway 兼容版
FROM node:20-alpine

# 安装必要的工具
RUN apk add --no-cache git

WORKDIR /app

# 复制 package 文件
COPY package*.json pnpm-lock.yaml ./

# 用 pnpm 安装（不使用缓存挂载）
RUN npm install -g pnpm@9
RUN pnpm install --no-frozen-lockfile

# 复制所有源码
COPY . .

# 构建
RUN pnpm run -r build

# 只保留 server 生产环境
RUN pnpm deploy --filter=server --prod /app/prod

WORKDIR /app/prod
COPY apps/server/src/config/docker.ts ./src/config/docker.ts

ENV PORT=3333
ENV DATABASE_TYPE="sqlite"
ENV DATABASE_URL="file:./data/wewe-rss.db"
ENV AUTH_CODE="muge2026"

EXPOSE 3333
CMD ["node", "src/main.js"]
