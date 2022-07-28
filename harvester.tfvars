harv_kube = <<-EOT
              apiVersion: v1
              kind: Config
              clusters:
              - name: "harvester-nue"
                cluster:
                  server: "https://rancher.susedemo.com/k8s/clusters/c-m-mps4f4n6"
              
              users:
              - name: "harvester-nue"
                user:
                  token: "kubeconfig-u-ulzn6thzbw9xwzj:26gnxllhxhrgn5txctr9p8jrdd2z68fhj4gmvkxdg7j8qhpqglnd4l"
              
              
              contexts:
              - name: "harvester-nue"
                context:
                  user: "harvester-nue"
                  cluster: "harvester-nue"
              
              current-context: "harvester-nue"
              EOT
