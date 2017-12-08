#!/usr/bin/env bash

# Create namespace
kubectl create -f namespaces/ht-namespace.yml

# Create limits
kubectl create -f limits/streaming-limits.yml

# Create deployments
kubectl create -f deployments/streaming-api.yml

# Create service
kubectl create -f services/api.yml
