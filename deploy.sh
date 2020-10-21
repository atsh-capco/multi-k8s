docker build -t tshala/multi-client:latest -t tshala/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tshala/multi-server:latest -t tshala/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tshala/multi-worker:latest -t tshala/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tshala/multi-client:latest
docker push tshala/multi-server:latest
docker push tshala/multi-worker:latest

docker push tshala/multi-client:$SHA
docker push tshala/multi-server:$SHA
docker push tshala/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tshala/multi-server:$SHA
kubectl set image deployments/client-deployment client=tshala/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tshala/multi-worker:$SHA