#!/bin/bash

set -e

echo "Starting Security + Performance Pipeline"

echo "Running JMeter Load Test..."
jmeter -n -t jmeter/test-plan.jmx -l result.jtl

echo "Generating JMeter HTML Report..."
jmeter -g result.jtl -o jmeter-report

echo "Running OWASP ZAP Security Scan..."
docker run -v $(pwd):/zap/wrk/:rw \
owasp/zap2docker-stable \
zap-baseline.py \
-t https://jsonplaceholder.typicode.com \
-r zap-report.html

echo "All tests completed successfully"
