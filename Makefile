cluster:
	k3d cluster create istio-testing -p "8000:30000@loadbalancer" --agents 2

istio:
	istioctl install -y

label:
	kubectl label namespace default istio-injection=enabled

dashboards:
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/addons/grafana.yaml
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/addons/kiali.yaml
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/addons/prometheus.yaml
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/addons/jaeger.yaml
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/httpbin/sample-client/fortio-deploy.yaml
	export FORTIO_POD=$(kubectl get pods -lapp=fortio -o 'jsonpath={.items[0].metadata.name}')

reqs:
	kubectl exec $(FORTIO_POD) -c fortio -- fortio load -c 2 -qps 0 -t 200s -loglevel Warning http://app-service:8000