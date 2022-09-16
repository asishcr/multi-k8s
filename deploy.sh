docker build -t asishcr/multi-client-k8s:latest -t asishcr/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t asishcr/multi-server-k8s:latest -t asishcr/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t asishcr/multi-worker-k8s:latest -t asishcr/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push asishcr/multi-client-k8s:latest
docker push asishcr/multi-server-k8s:latest
docker push asishcr/multi-worker-k8s:latest

docker push asishcr/multi-client-k8s:$SHA
docker push asishcr/multi-server-k8s:$SHA
docker push asishcr/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=asishcr/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=asishcr/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=asishcr/multi-worker-k8s:$SHA