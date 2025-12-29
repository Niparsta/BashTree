# Используем легкий базовый образ
FROM alpine:latest

# Устанавливаем bash, так как в Alpine по умолчанию sh
RUN apk add --no-cache bash

# Создаем рабочую директорию
WORKDIR /app

# Копируем скрипт в контейнер
COPY tree.sh .

# Делаем скрипт исполняемым
RUN chmod +x tree.sh

# Указываем команду запуска
ENTRYPOINT ["./tree.sh"]
