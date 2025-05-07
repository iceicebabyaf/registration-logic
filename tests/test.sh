#!/bin/bash

# Тест регистрации
REG_RESPONSE=$(curl -X POST "http://127.0.0.1:8000/user_registration" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"testpass"}' \
  -w "%{http_code}" -o /tmp/reg_response.json)
REG_STATUS=$(echo $REG_RESPONSE | tail -n 1)
if [ "$REG_STATUS" != "201" ]; then
  echo "Registration failed with status $REG_STATUS"
  cat /tmp/reg_response.json
  exit 1
fi

# Тест входа
LOGIN_RESPONSE=$(curl -X POST "http://127.0.0.1:8000/user_login" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"testpass"}' \
  -w "%{http_code}" -o /tmp/login_response.json)
LOGIN_STATUS=$(echo $LOGIN_RESPONSE | tail -n 1)
if [ "$LOGIN_STATUS" != "200" ]; then
  echo "Login failed with status $LOGIN_STATUS"
  cat /tmp/login_response.json
  exit 1
fi