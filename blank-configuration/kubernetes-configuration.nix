{ config, pkgs, ... }:
let
  kubeMasterIP = "10.0.0.107";
  kubeMasterHostname = "master.micro-slab";
  kubeMasterAPIServerPort = 6443;
in
{
  # resolve master hostname
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  services.kubernetes = let
    api = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
  in
  {
    roles = ["node"];
    masterAddress = kubeMasterHostname;
    easyCerts = true;

    # point kubelet and other services to kube-apiserver
    kubelet.kubeconfig.server = api;
    apiserverAddress = api;

    # use coredns
    addons.dns.enable = true;

    # needed if you use swap
    kubelet.extraOpts = "--fail-swap-on=false --cgroup-driver=systemd";
  };

  system.activationScripts.kubernetes-key-perms = {
    text = ''
      chmod 640 /var/lib/kubernetes/secrets/cluster-admin-key.pem
    '';
    deps = [];
  };
}