docker build -t friedmanss/multi-client:latest -t friedmanss/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t friedmanss/multi-server:latest -t friedmanss/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t friedmanss/multi-worker:latest -t friedmanss/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push friedmanss/multi-client:latest
docker push friedmanss/multi-server:latest
docker push friedmanss/multi-worker:latest

docker push friedmanss/multi-client:$SHA
docker push friedmanss/multi-server:$SHA
docker push friedmanss/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=friedmanss/multi-client:$SHA
kubectl set image deployments/server-deployment server=friedmanss/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=friedmanss/multi-worker:$SHA