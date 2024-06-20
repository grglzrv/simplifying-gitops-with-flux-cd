module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.14.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }


  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  eks_managed_node_group_defaults = {
    disk_size = 100
  }

  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 10

      labels = {
        role = "general"
      }

      instance_types = ["t2.medium"]
      capacity_type  = "ON_DEMAND"
    }


  }

 # node_security_group_additional_rules = {

  #ingress_allow_access_from_control_plane = {
   # type                          = "ingress"
   # protocol                      = "tcp"
   # from_port                     = 9443
   # to_port                       = 9443
   # source_cluster_security_group = true
   # description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
  #}
#}

node_security_group_additional_rules = {

  ingress_allow_access_from_control_plane = {
    type                          = "ingress"
    protocol                      = "tcp"
    from_port                     = 15017
    to_port                       = 15017
    source_cluster_security_group = true
    description                   = "Allow access from control plane to webhook port i.e 15017 of istio"
  }
}

  tags = {
    Environment = "tofu-dev"
  }
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = try(module.eks.this[0].identity[0].oidc[0].issuer, null)
}
