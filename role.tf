#AWS CodePipeline requires an IAM service role to be created with the necessary permissions. Create a file titled role.tf within terraform-projects folder.

#This file should define a role and associated policy with the following specs and permissions:

#Role name: iam_role_for_codepipeline
#Policy name: codepipeline_policy
#Service: codepipeline.amazonaws.com
#Action: sts:AssumeRole
#Permissions: All permissions for S3, Codecommit, Codebuild, Elastic Beanstalk, Cloudformation, AutoScaling, EC2 and PassRole permission for IAM.
#Resource scope: All resources
#Create this role using the configuration you created.


resource "aws_iam_role" "codepipeline_role" {
  name = "iam_role_for_codepipeline"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline_policy" {

  name = "codepipeline_policy"
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*",
          "codecommit:*",
          "codebuild:*",
          "elasticbeanstalk:*",
          "cloudformation:*",
          "autoscaling:*",
          "ec2:*",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}
