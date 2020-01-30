docker build -t msurmei/multi-client:latest -t msurmei/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t msurmei/multi-server:latest -t msurmei/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t msurmei/multi-worker:latest -t msurmei/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push msurmei/multi-client:latest
docker push msurmei/multi-server:latest
docker push msurmei/multi-worker:latest
docker push msurmei/multi-client:$SHA
docker push msurmei/multi-server:$SHA
docker push msurmei/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=msurmei/multi-server:$SHA
kubectl set image deployments/client-deployment client=msurmei/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=msurmei/multi-worker:$SHA