provider "aws" {
  region  = "us-east-1"
}

resource "aws_iam_role" "firehose_role" {
  name = "firehose_test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

module "kinesis-firehose" {
  source                                = "../"
  kinesis_firehose_stream_name          = "test_stream"
  region  = "us-east-1"
  bucket_arn                           = "arn:aws:s3:::script-files-test"
  role_arn                              = "${aws_iam_role.firehose_role.arn}"
  
}
