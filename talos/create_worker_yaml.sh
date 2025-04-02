talosctl gen config homek8s https://192.168.0.1:6443 \
	-t worker \
	--config-patch @certsans.patch.yaml \
	--config-patch @worker01.patch.yaml \
	--config-patch @lenovoY40-80_worker_image.patch.yaml \
	--with-secrets cluster_secrets.yaml \
	--with-docs=false \
	--with-examples=false \
	-o worker01.yaml
