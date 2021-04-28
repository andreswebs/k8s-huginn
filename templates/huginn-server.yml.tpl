---
apiVersion: v1
kind: ConfigMap
metadata:
  name: huginn-server-config
  namespace: huginn
data:
  DATABASE_ADAPTER: postgresql
  DATABASE_HOST: huginn-db
  DATABASE_PORT: "5432"
  SMTP_DOMAIN: amazonaws.com
  SMTP_SERVER: ${SMTP_SERVER}
  SMTP_PORT: "${SMTP_PORT}"
  SMTP_AUTHENTICATION: plain
  SMTP_ENABLE_STARTTLS_AUTO: "true"
  SEND_EMAIL_IN_DEVELOPMENT: "true"
  EMAIL_FROM_ADDRESS: ${EMAIL_FROM_ADDRESS}

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: huginn-server
  namespace: huginn
  labels:
    app.kubernetes.io/name: huginn
    app.kubernetes.io/instance: huginn-server
    app.kubernetes.io/version: "12.6"
    app.kubernetes.io/component: server
    app.kubernetes.io/part-of: huginn
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/instance: huginn-server
  template:
    metadata:
      labels:
        app.kubernetes.io/name: huginn
        app.kubernetes.io/instance: huginn-server
        app.kubernetes.io/version: latest
        app.kubernetes.io/component: server
        app.kubernetes.io/part-of: huginn
    spec:
      containers:
        - name: huginn
          image: huginn/huginn-single-process:latest
          envFrom:
            - configMapRef:
                name: huginn-server-config
            - secretRef:
                name: huginn-server-secret
            - secretRef:
                name: huginn-invitation-secret

---
apiVersion: v1
kind: Service
metadata:
  name: huginn
  namespace: huginn
  labels:
    app.kubernetes.io/name: huginn
    app.kubernetes.io/instance: huginn-server
    app.kubernetes.io/version: latest
    app.kubernetes.io/component: server
    app.kubernetes.io/part-of: huginn
spec:
  selector:
    app.kubernetes.io/instance: huginn-server
  ports:
    - protocol: TCP
      port: 3000
