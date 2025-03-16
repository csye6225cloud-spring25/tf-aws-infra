#!/bin/bash
set -e
exec > /var/log/user_data.log 2>&1

cat <<EOF > /opt/app/backend/.env
DATABASE_URL="postgresql://${db_username}:${db_password}@${rds_endpoint}/${db_name}?schema=public"
AWS_REGION="${aws_region}"
AWS_S3_BUCKET="${s3_bucket_name}"
EOF

chown csye6225:csye6225 /opt/app/backend/.env
cd /opt/app/backend
npx prisma migrate deploy

systemctl enable csye6225.service
systemctl start csye6225.service