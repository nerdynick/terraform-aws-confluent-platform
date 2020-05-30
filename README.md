# terraform-aws-confluent-platform

Terraform Module(s) for Deploying the Confluent Platform within AWS.

# Features

## Feature Metric

| CP Component    | EC2 Instance | Route53 DNS | Security Groups | Load Balancers | Multi AZ |
|:--------------- |:------------:|:-----------:|:---------------:|:--------------:|:--------:|
| Zookeeper       | X | X | X | N/A |  |
| Kafka Broker    | X | X | X |  |  |
| Kafka Connect   | X | X | X |  |  |
| ksqlDB          | X | X | X |  |  |
| Rest Proxy      | X | X | X |  |  |
| Schema Registry | X | X | X |  |  |
| Control Center  | X | X | X | N/A |  |

## Feature Limitations

1. Out of the box all nodes and security groups are required to live in the same VPC

NOTE: If you leverage the individual component modules, some of these limitations can be worked around.
These limitation just haven't be able to be baked into a single unified parent module yet, or may not be possible to at all.