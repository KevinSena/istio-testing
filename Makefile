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

reqs:
	while true;do curl http://localhost:8000; echo; sleep 0.5; done;