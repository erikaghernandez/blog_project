#!/bin/bash
##to help debug stop when fail
set -e

DB_INSTANCE_IDENTIFIER="coursera-mysql-instance"
DB_NAME="blog_db"
MASTER_USERNAME="coursera"
MASTER_PASSWORD="coursera"
DB_INSTANCE_CLASS="db.t3.micro"
ENGINE="mysql"
#remove engine version bc comand create db does not require explixit version
ALLOCATED_STORAGE=20

aws rds create-db-instance \
  --db-instance-identifier "$DB_INSTANCE_IDENTIFIER" \
  --db-name "$DB_NAME" \
  --engine "$ENGINE" \
  --db-instance-class "$DB_INSTANCE_CLASS" \
  --allocated-storage "$ALLOCATED_STORAGE" \
  --master-username "$MASTER_USERNAME" \
  --master-user-password "$MASTER_PASSWORD" \
  --publicly-accessible

aws rds wait db-instance-available \
  --db-instance-identifier "$DB_INSTANCE_IDENTIFIER"

ENDPOINT=$(aws rds describe-db-instances \
  --db-instance-identifier "$DB_INSTANCE_IDENTIFIER" \
  --query "DBInstances[0].Endpoint.Address" \
  --output text)

echo "RDS MySQL instance created. Endpoint: $ENDPOINT"

