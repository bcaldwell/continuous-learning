# Getting started

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


start local kubernetes cluster

```
minikube start
```

### Hello world application

run hello world container

```
kubectl run hello-world --image=benjamincaldwell/hello-world --port=80
```

create hello-world service

```
kubectl expose deployment hello-world --type="NodePort"
```

### Nginx load balancer

run nginx. Replace KUBERNETES_SERVICE_HOST with IP from `kubectl describe service hello-world`

```
kubectl run nginx --image=quay.io/benjamincaldwell/hello-nginx --port=80 --env="NGINX_PROXY_PASS_HOST=http://KUBERNETES_SERVICE_HOST"
```

Create service for nginx

```
kubectl expose deployment nginx --type="NodePort"
```

Make sure nginx is running and get port for nginx

```
kubectl get pods
kubectl describe service nginx
```

scale hello-world container

```
kubectl scale deployment hello-world --replicas=3
```


[source](https://blog.codeship.com/getting-started-with-kubernetes/)