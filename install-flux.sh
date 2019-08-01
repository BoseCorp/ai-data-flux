#!/bin/bash

echo "Applying the Helm Release CRD to the cluster"
kubectl apply -f https://raw.githubusercontent.com/fluxcd/flux/master/deploy-helm/flux-helm-release-crd.yaml

echo "starting helm"
helm init --upgrade

echo "locally adding the flux helm repo to your local helm settings"

helm repo add fluxcd https://fluxcd.github.io/flux

echo" Install Flux and its Helm Operator to the cluster"

helm install \
  --name flux \
  --values flux-helm-options.yaml \
  --namespace flux \
  fluxcd/flux


sleep 20

echo "Add the bellow key to https://github.com/BoseCorp/ai-data-flux/settings/keys with write access"

fluxctl identity --k8s-fwd-ns flux
