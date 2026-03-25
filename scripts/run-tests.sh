#!/usr/bin/env bash
set -e

echo "Starting Security + Performance Pipeline"

echo "Running JMeter Load Test..."
jmeter -n -t jmeter/test-plan.jmx -l result.jtl

echo "Running OWASP ZAP Security Scan..."
docker run --rm -v $(pwd):/zap/wrk ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t https://jsonplaceholder.typicode.com -r zap-report.html

echo "Pipeline completed"
