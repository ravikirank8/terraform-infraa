#Finally, create a file titled pipeline.tf that defines the configuration for a pipeline in AWS CodePipeline with the following specs:

#Pipeline name: terraform-web-app-pipeline
#Role: Iam _role_for_codepipeline
#Artifact location: Bucket with prefix terraform-web-app-bucket-
#Source: GitHub repository terraform-infra on branch main
#Add the repository owner name and personal access token in the configuration section under source.
#Deploy: Elastic beanstalk application terraform-web-app to environment devm
#Use the Source and Deploy actions for creating these stages.
#The source stage should create an output artifact named source_output which should be used by the deploy stage as input artifact.

#Note: Use the previously created S3 bucket for artifact.

resource "aws_codepipeline" "terraform-web-app-pipeline" {
  name     = "terraform-web-app-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = "terraform-web-app-bucket-1015bca27aef"  
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = "ravikirank8"                
        Repo       = "terraform-infraa"               # Repository name
        Branch     = "main"                          # Branch name
        OAuthToken = "xxxx"          
      }
    }
  }


  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "ElasticBeanstalk"
      version          = "1"
      input_artifacts  = ["source_output"]

      configuration = {
        ApplicationName = "terraform-web-app"
        EnvironmentName = "devm"
      }
    }
  }
}

#Navigate to the terraform-web-app-pipeline from the AWS management console. You should see the pipeline failed. This happened because our repo has currently no files and therefore no main branch present.

#Upload the contents of the static-web-app folder to the terraform-infra GitHub repository.

#Before pushing the files, make a minor change to the index.html file. Replace the following line:

#This is a simple static web app.

#with

#This is a web app created using terraform.

#Copy the contents of the static-web-app folder to the terraform-infra repository:
#cp /root/static-web-app/* /root/terraform-infra/
#Edit the index.html file within terraform-infra folder:

#Run the git status command and you should see an output displaying all the newly added files.

#Run the following commands to push the changes to main branch:

#git add .
#git commit -m "Deploying application via pipeline"
#git push origin main


#Navigate to the terraform-web-app-pipeline from the AWS management console. Wait for some time, refresh the pipeline and you should see the pipeline running and succeeding.

#Go to the Elastic beanstalk application page and check the domain URL for the terraform-web-app application. You should see the updated message on the UI.
