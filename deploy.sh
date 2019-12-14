docker build -t oeswww/multi-client:latest -t oeswww/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t oeswww/multi-server:latest -t oeswww/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t oeswww/multi-worker:latest -t oeswww/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push oeswww/multi-client:latest
docker push oeswww/multi-server:latest
docker push oeswww/multi-worker:latest

docker push oeswww/multi-client:$SHA
docker push oeswww/multi-server:$SHA
docker push oeswww/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=oeswww/multi-server:$SHA
kubectl set image deployments/client-deployment client=oeswww/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=oeswww/multi-worker:$SHA
