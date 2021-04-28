apiVersion: v1
kind: Secret
metadata:
  name: huginn-server-secret
  namespace: huginn
type: Opaque
data:
  DATABASE_USERNAME: ${DATABASE_USERNAME}
  DATABASE_PASSWORD: ${DATABASE_PASSWORD}
  SMTP_USER_NAME: ${SMTP_USER_NAME}
  SMTP_PASSWORD: ${SMTP_PASSWORD}
