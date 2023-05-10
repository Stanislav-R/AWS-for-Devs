cat <<EOF >s3_sample.txt
Hello Wolrd!!!
EOF

aws s3 mb s3://srudyi-s3-demo --region us-west-2
aws s3api put-bucket-versioning --bucket srudyi-s3-demo --versioning-configuration Status=Enabled
aws s3 cp s3_sample.txt s3://srudyi-s3-demo/