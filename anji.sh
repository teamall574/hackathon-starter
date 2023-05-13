#!/bin/bash
trivy_output=$(trivy image anji1592/kubetest:latest --severity HIGH,CRITICAL --no-progress)

if echo "$trivy_output" | grep -q "HIGH" || echo "$trivy_output" | grep -q "CRITICAL"; then 
echo "Aborting build due to HIGH or CRITICAL vulnerabilites"
exit 1
fi 
