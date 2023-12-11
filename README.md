# CICD Pipeline Documentation

This documentation outlines the Continuous Integration and Continuous Deployment (CICD) pipeline for a Flask web application. The pipeline automates the building, testing, and deployment process using GitHub Actions, AWS ECR (Elastic Container Registry), and EC2 instances.

## Workflow Overview

The CICD pipeline consists of the following steps:

1. **Checkout Repository:**
   - Action: Uses GitHub Actions to checkout the repository.

2. **Setup Python:**
   - Action: Sets up Python 3.8 for the workflow.

3. **Install AWS CLI:**
   - Action: Installs the AWS CLI on the Ubuntu environment.

4. **Install Docker:**
   - Action: Installs Docker by executing the Docker installation script.

5. **Check Docker Version:**
   - Action: Verifies the installed Docker version.

6. **Install Dependencies:**
   - Action: Installs Python dependencies specified in `requirements.txt`.

7. **Login to AWS ECR:**
   - Action: Logs in to the specified AWS ECR repository using AWS CLI and Docker.

8. **Build Docker Image:**
   - Action: Builds a Docker image named `my-app` based on the provided Dockerfile.

9. **Tag Docker Image:**
   - Action: Tags the Docker image with the appropriate ECR repository information.

10. **Push Docker Image to AWS ECR:**
    - Action: Pushes the Docker image to the specified AWS ECR repository.

11. **Get EC2 Instance IP Address:**
    - Action: Retrieves the public IP address of a running EC2 instance.

12. **Deploy to EC2 Instance:**
    - Action: Deploys the Docker image to the EC2 instance, configures Docker settings, and pulls the latest image from ECR.

13. **Run Docker Container on EC2 Instance:**
    - Action: Runs the Docker container on the EC2 instance, exposing the Flask app on port 5000.

## GitHub Secrets

Ensure the following secrets are configured in the GitHub repository:

- `AWS_ACCESS_KEY_ID`: Access key for AWS IAM user.
- `AWS_SECRET_ACCESS_KEY`: Secret key for AWS IAM user.
- `SSH_PRIVATE_KEY`: SSH private key for accessing the EC2 instance.

## Workflow Execution

1. **Trigger Workflow:**
   - The workflow is triggered on each push to the `main` branch.

2. **Build and Deploy:**
   - The workflow builds the Docker image, pushes it to AWS ECR, retrieves the EC2 instance IP address, and deploys the Docker image to the EC2 instance.

3. **Accessing the Flask App:**
   - The Flask app is accessible on the public IP address of the EC2 instance at `http://<EC2-IP>:5000`.
   - The authenticity of host 'ec2-18-207-116-57.compute-1.amazonaws.com (18.207.116.57)' can't be established.
ED25519 key fingerprint is SHA256:Xidhd+sBnhKpcZ2IEyHEhvPGcIO1f0qSNLwlM5/+dog.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:10: [hashed name]
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'ec2-18-207-116-57.compute-1.amazonaws.com' (ED25519) to the list of known hosts.
   ,     #_
   ~\_  ####_        Amazon Linux 2023
  ~~  \_#####\
  ~~     \###|
  ~~       \#/ ___   https://aws.amazon.com/linux/amazon-linux-2023
   ~~       V~' '->
    ~~~         /
      ~~._.   _/
         _/ _/
       _/m/'
Last login: Sat Dec  9 13:19:06 2023 from 102.68.79.231
[ec2-user@ip-172-31-27-139 ~]$ docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
[ec2-user@ip-172-31-27-139 ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
[ec2-user@ip-172-31-27-139 ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
[ec2-user@ip-172-31-27-139 ~]$ docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE


## Conclusion

This CICD pipeline automates the deployment of a Flask web application, providing a streamlined and efficient workflow for continuous integration and deployment.
