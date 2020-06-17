# terraform-aws-confluent-platform

Terraform Module(s) for Deploying the Confluent Platform within AWS.

# Features

## Feature Metric

| CP Component    | EC2 Instance | EBS Volumes | Route53 DNS | Security Groups | Load Balancers | Multi AZ | Auto Scaling Groups | Multi Cluster |
|:--------------- |:------------:|:------------:|:-----------:|:---------------:|:--------------:|:--------:|:-------------------:|:-------------:|
| Zookeeper       | X            | X            | X           | X               | N/A            | X        | N/A                 | N/A           |
| Kafka Broker    | X            | X            | X           | X               |                | X        | N/A                 | N/A           |
| Kafka Connect   | X            | X            | X           | X               |                | X        |                     |               |
| ksqlDB          | X            | X            | X           | X               |                | X        |                     |               |
| Rest Proxy      | X            | X            | X           | X               |                | X        |                     | N/A           |
| Schema Registry | X            | X            | X           | X               |                | X        | N/A                 | N/A           |
| Control Center  | X            | X            | X           | X               | N/A            | X        | N/A                 | N/A           |

## Feature Limitations

1. Out of the box all nodes and security groups are required to live in the same VPC

NOTE: If you leverage the individual component modules, some of these limitations can be worked around.
These limitation just haven't be able to be baked into a single unified parent module yet, or may not be possible to at all.

## Defining separate providers

As of 2.4.3 you can now define separate providers for your EC2 instance creation and your DNS creation. 
This is to support those users that may need to use separate IAM accounts to for DNS then they do to create EC2, EBS, and SecGroups.

These provider alias are as follows:

```
provider "aws" {
    alias = "default"
}
provider "aws" {
    alias = "dns"
}
```

Example of how to pass these references:

```
module "shared-cp-aws" {
    source  = "nerdynick/confluent-platform/aws"
    version = "2.4.4"
    
    providers = {
        aws.default = aws.default
        aws.dns = aws.dns
    }
    
    ....
}
```