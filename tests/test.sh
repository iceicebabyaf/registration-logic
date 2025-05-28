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



UPDATE_BALANCE=$(curl  "http://127.0.0.1:8000/update_balance?email=test@example.com&amount=100.0" \
  -H "accept: application/json" \
  -w "%{http_code}\n" -o /dev/null)
if [ "$UPDATE_BALANCE" != "200"]; then
    echo "Update balance failed with status $UPDATE_BALANCE"
    exit 1
fi

GET_DATA=$(curl "http://127.0.0.1:8000/get_users_db" \
  -H "accept: application/json" \
  -w "%{http_code}\n" -o /dev/null)
if [ "$GET_DATA" != "200"]; then
    echo "Geting database failed with status $GET_DATA"
    exit 1
fi

LOGAUT_STATUS=$(curl "http://127.0.0.1:8000/user_logout?email=test@example.com" \
  -H "accept: application/json" \
  -w "%{http_code}\n" -o /dev/null)
if [ "$LOGAUT_STATUS" != "200" ]; then
    echo "Logout failed with status $LOGAUT_STATUS"
    exit 1
fi

