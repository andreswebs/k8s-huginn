apiVersion: v1
kind: Secret
metadata:
  name: huginn-invitation-secret
  namespace: huginn
type: Opaque
data:
  HUGINN_INVITATION_CODE: ${HUGINN_INVITATION_CODE}
