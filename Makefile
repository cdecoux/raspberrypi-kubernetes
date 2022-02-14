install: 
	ansible-playbook ansible/site.yml -i inventory/hosts.ini

kubeconfig:
	mkdir -p ~/.kube
	scp pi@raspberry-driver:~/.kube/config ~/.kube/config-pi

sandbox-alpine:
	KUBECONFIG=~/.kube/config-pi kubectl exec -i -t -n sandbox alpine -c alpine -- sh -c "clear; (bash || ash || sh)"

sandbox-ubuntu:
	KUBECONFIG=~/.kube/config-pi kubectl exec -i -t -n sandbox ubuntu -c ubuntu -- sh -c "clear; (bash || ash || sh)"

.PHONY: install kubeconfig attach-alpine docker-build