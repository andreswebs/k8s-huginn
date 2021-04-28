apiVersion: v1
kind: Secret
metadata:
  namespace: huginn
  name: huginn-db-secret
type: Opaque
data:
  POSTGRES_USER: ${POSTGRES_USER}
  POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
