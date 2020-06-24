#Build images
docker build -t anoopviswappan/react-multi-client:latest -t anoopviswappan/react-multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t anoopviswappan/react-multi-server:latest -t anoopviswappan/react-multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t anoopviswappan/react-multi-worker:latest -t anoopviswappan/react-multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
#push latest tag
docker push anoopviswappan/react-multi-client:latest
docker push anoopviswappan/react-multi-server:latest
docker push anoopviswappan/react-multi-worker:latest
#push $GIT_SHA tag
docker push anoopviswappan/react-multi-client:$GIT_SHA
docker push anoopviswappan/react-multi-server:$GIT_SHA
docker push anoopviswappan/react-multi-worker:$GIT_SHA
#imperative command to update image
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anoopviswappan/react-multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=anoopviswappan/react-multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=anoopviswappan/react-multi-worker:$GIT_SHA