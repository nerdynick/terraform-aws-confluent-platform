# terraform-aws-confluent-platform

Terraform Module for Deploying the Confluent Platform to AWS.

# Features

| CP Component    | EC2 Instance | Route53 DNS | Security Groups |
|:--------------- |:------------:|:-----------:|:---------------:|
| Zookeeper       | X | X |  |
| Kafka Broker    | X | X |  |
| Kafka Connect   | X | X |  |
| ksqlDB          | X | X |  |
| Rest Proxy      | X | X |  |
| Schema Registry | X | X |  |
| Control Center  | X | X |  |