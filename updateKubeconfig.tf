// it is necessary to create a empty file on ~/.kube/config named kubeconfig

resource "null_resource" "kubectl" {
    provisioner "local-exec" {
        command = "aws eks update-kubeconfig --name \"${aws_eks_cluster.cluster.name}\""
    }
}