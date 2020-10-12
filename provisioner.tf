resource "null_resource" "ansible_provisioning_rmqcluster" {
  provisioner "local-exec" {
    command = <<EOF

az vm wait -g rmqRG -n node01 --created
az vm wait -g rmqRG -n node02 --created
az vm wait -g rmqRG -n node03 --created

/bin/bash inventory/inventory_setup.sh

ansible-playbook  install.yaml > stdout/play.stdout

EOF
  }
}
