# EKS with Karpenter

Configuration in this directory creates an AWS EKS cluster with [Karpenter](https://karpenter.sh/) provisioned for managing compute resource scaling.

## Usage

To provision the provided configurations you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```

Or fork the [repository](https://github.com/likhanov/aws-eks), set up secrets for AWS: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and manually run the GitHub Action [Terraform apply](https://github.com/likhanov/aws-eks/actions/workflows/apply.yml).

Once the cluster is up and running, you can check that Karpenter is functioning as intended with the following command:

```bash
# First, make sure you have updated your local kubeconfig
aws eks --region us-east-1 update-kubeconfig --name mediterraneum

# Second, deploy workloads for x86
kubectl apply -f https://raw.githubusercontent.com/likhanov/eks-workloads/refs/heads/main/workload-amd64.yaml

# and for arm64
kubectl apply -f https://raw.githubusercontent.com/likhanov/eks-workloads/refs/heads/main/workload-arm64.yaml

# You can watch Karpenter's controller logs with
kubectl logs -f -n kube-system -l app.kubernetes.io/name=karpenter -c controller
```

Validate if the Amazon EKS Addons Pods are running in the Managed Node Group and the `workload` application Pods are running on Karpenter provisioned Nodes.

```bash
kubectl get nodes -L karpenter.sh/registered
```

```sh
kubectl get pods -A -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName
```

### Tear Down & Clean-Up

Because Karpenter manages the state of node resources outside of Terraform, Karpenter created resources will need to be de-provisioned first before removing the remaining resources with Terraform.

1. Remove the example deployment created above and any nodes created by Karpenter

```bash
kubectl delete deployment workload-arm64
kubectl delete deployment workload-amd64
```

2. Remove the resources created by Terraform

```bash
terraform destroy --auto-approve
```

Or manually run the GitHub Action [Terraform destroy](https://github.com/likhanov/eks-infra/actions/workflows/destroy.yml).


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >~ 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >~ 5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.7 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 2.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >~ 5.0 |
| <a name="provider_aws.virginia"></a> [aws.virginia](#provider\_aws.virginia) | >~ 5.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.7 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 2.1.2 |
<!-- END_TF_DOCS -->
