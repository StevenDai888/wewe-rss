FROM cooderl/wewe-rss:latest

ENV PORT=3333
ENV AUTH_CODE=muge2026
ENV DATABASE_URL="file:./data/wewe-rss.db"
ENV DATABASE_TYPE="sqlite"

EXPOSE 3333
