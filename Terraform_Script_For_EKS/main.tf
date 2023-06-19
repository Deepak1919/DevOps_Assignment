# Specify the provider and region
provider "aws" {
  region = "eu-west-2"
}

# Create the EKS cluster
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.cluster.arn
  version  = "1.24"
  vpc_config {
    subnet_ids         = ["subnet-05e87e22f745f0d4e", "subnet-0825cfb278cd890d4"] # Replace with your subnet IDs
    security_group_ids = ["sg-0685212f0eb82457e"]                       # Replace with your security group IDs
  }
}

# Create the EKS cluster worker nodes
resource "aws_launch_configuration" "my_launch_config" {
  name          = "my-launch-config"
  image_id      = "ami-0eb260c4d5475b901"                              # Replace with your desired worker node AMI ID
  instance_type = "t3.medium"                                 # Replace with your desired instance type
  security_groups = ["${aws_security_group.cluster_worker_nodes.id}"]
}

resource "aws_autoscaling_group" "my_autoscaling_group" {
  name             = "my-autoscaling-group"
  launch_configuration = aws_launch_configuration.my_launch_config.name
  min_size         = 1
  max_size         = 3
  desired_capacity = 2
  vpc_zone_identifier = ["subnet-05e87e22f745f0d4e", "subnet-0825cfb278cd890d4"] # Replace with your subnet IDs
}

# Create IAM role for the EKS cluster
resource "aws_iam_role" "cluster" {
  name = "my-eks-cluster-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach required policies to the IAM role
resource "aws_iam_role_policy_attachment" "cluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.cluster.name
}

# Create security group for the cluster worker nodes
resource "aws_security_group" "cluster_worker_nodes" {
  name        = "my-cluster-worker-nodes"
  description = "Security group for cluster worker nodes"
  vpc_id      = "vpc-0f865239dd4234f54"  # Replace with your VPC ID

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
