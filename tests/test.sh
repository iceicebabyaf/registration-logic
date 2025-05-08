#!/bin/bash

# Тест регистрации
REG_STATUS=$(curl -X POST "http://127.0.0.1:8000/user_registration?email=test@example.com&password=testpass" \
  -H "accept: application/json" \
  -w "%{http_code}\n" -o /dev/null)
if [ "$REG_STATUS" != "200" ]; then
  echo "Registration failed with status $REG_STATUS"
  exit 1
fi

# Тест входа
LOGIN_STATUS=$(curl -X POST "http://127.0.0.1:8000/user_login?email=test@example.com&password=testpass" \
  -H "accept: application/json" \
  -w "%{http_code}\n" -o /dev/null)
if [ "$LOGIN_STATUS" != "200" ]; then
  echo "Login failed with status $LOGIN_STATUS"
  exit 1
fi

LOGAUT_STATUS=$(curl "http://127.0.0.1:8000/user_logout?email=test@example.com" \
  -H "accept: application/json" \
  -w "%{http_code}\n" -o /dev/null)
if [ "$LOGAUT_STATUS" != "200" ]; then
    echo "Logout failed with status $LOGAUT_STATUS"
    exit 1
fi