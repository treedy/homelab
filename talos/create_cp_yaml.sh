talosctl gen config homek8s https://192.168.0.1:6443 \
	-t controlplane \
	--config-patch @certsans.patch.yaml \
	--config-patch @cp${1}.patch.yaml \
	--config-patch @hpED800G3_cp_image.patch.yaml \
	--with-secrets cluster_secrets.yaml \
	--with-docs=false \
	--with-examples=false \
	-o cp${1}.yaml
