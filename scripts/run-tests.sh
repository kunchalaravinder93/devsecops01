#!/usr/bin/env bash
set -e

echo "Starting Security + Performance Pipeline"

echo "Running JMeter Load Test (Docker)..."
docker run --rm \
  -v $(pwd):/test \
  justb4/jmeter:5.5 \
  -n -t /test/jmeter/test-plan.jmx -l /test/result.jtl
echo "Running OWASP ZAP Security Scan..."
docker run --rm \
  -u root \
  -v $(pwd):/zap/wrk \
  ghcr.io/zaproxy/zaproxy:stable \
  zap-baseline.py -t https://jsonplaceholder.typicode.com -r zap-report.html || true
