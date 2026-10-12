\# Highly Available AWS Core Network (Terraform Modules)



A multi-AZ AWS network built with reusable Terraform modules in ap-south-1.



\## Architecture

Internet -> ALB (public subnets) -> Docker app on an Auto Scaling Group (private subnets) -> MySQL RDS (isolated DB subnets)



\- 2 Availability Zones, 3 subnet tiers (public, private, database)

\- One NAT gateway per AZ, so an AZ failure doesn't cut off the other

\- Security group chain: alb\_sg -> app\_sg -> db\_sg

\- RDS Multi-AZ, no public access, password managed by AWS Secrets Manager



\## Structure

```

modules/

&#x20; network/          VPC, subnets, IGW, NAT, route tables

&#x20; security-groups/  ALB, app and DB security groups

&#x20; alb/              Load balancer, target group, listener

&#x20; compute/          Launch template and Auto Scaling Group

&#x20; database/         DB subnet group and RDS instance

```



\## Usage

```

terraform init

terraform plan

terraform apply

```

Open the `alb\_dns\_name` output in a browser.



\## Cleanup

```

terraform destroy

```

NAT gateways and RDS cost money while running, so destroy when you're done.

