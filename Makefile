cluster:
	k3d cluster create istio-testing -p "8000:30000@loadbalancer" --agents 2

kind:
	kind create cluster --name istio-testing

label:
	kubectl label namespace default istio-injection=enabled

dashboards:
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/addons/grafana.yaml
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/addons/kiali.yaml
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/addons/prometheus.yaml
