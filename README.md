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

## Conclusion

This CICD pipeline automates the deployment of a Flask web application, providing a streamlined and efficient workflow for continuous integration and deployment.
