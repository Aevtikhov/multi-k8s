#!/usr/bin/env bash
docker build -t vokidoki130/multi-client:latest -t vokidoki130/multi-client:$SHA -f ./client/Dockerfile ./client/
docker build -t vokidoki130/multi-server:latest -t vokidoki130/multi-server:$SHA -f ./server/Dockerfile ./server/
docker build -t vokidoki130/multi-worker:latest -t vokidoki130/multi-worker:$SHA -f ./worker/Dockerfile ./worker/
docker push vokidoki130/multi-client:latest
docker push vokidoki130/multi-server:latest
docker push vokidoki130/multi-worker:latest

docker push vokidoki130/multi-client:$SHA
docker push vokidoki130/multi-server:$SHA
docker push vokidoki130/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vokidoki130/multi-server$SHA
kubectl set image deployments/client-deployment client=vokidoki130/multi-client$SHA
kubectl set image deployments/worker-deployment worker=vokidoki130/multi-worker$SHA