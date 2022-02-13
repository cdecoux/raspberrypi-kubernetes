install: 
	ansible-playbook ansible/site.yml -i inventory/hosts.ini

kubeconfig:
	scp pi@raspberry-driver:~/.kube/config ~/.kube/config-pi

.PHONY: install