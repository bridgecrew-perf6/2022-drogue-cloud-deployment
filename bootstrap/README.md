# Bootstrap configuration

This contains the configuration too boostrap the actual deployment, which will be performed using ArgoCD.

## Sync certificates once

You need to initially create empty secrets.

```yaml
kind: Job
apiVersion: batch/v1
metadata:
  name: sync-certs-once
  namespace: cluster-tools
spec:
  template:
    spec:
      containers:
        - name: kubectl
          image: 'ghcr.io/ctron/kubectl:latest'
          env:
            - name: CERT_SECRET_NAME
              value: summit-demo-dev-primary-cert-bundle-secret
          command:
            - /bin/bash
            - '-c'
            - |
              function sync () {
                echo "Syncing: $1/$2 ..."
                kubectl get secret ${CERT_SECRET_NAME} -o json --namespace openshift-ingress | jq 'del(.metadata)' | jq ".metadata.name = \"$2\"" | kubectl replace -n "$1" -f  -
              }
              sync drogue-iot mqtt-endpoint-tls
              sync drogue-iot http-endpoint-tls
          imagePullPolicy: IfNotPresent
      restartPolicy: OnFailure
      terminationGracePeriodSeconds: 30
      serviceAccountName: cert-syncer
```