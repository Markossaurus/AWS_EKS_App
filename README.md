# AWS_EKS_App

The build will deploy an EKS cluster with 1 worker node (small fees will apply)
It will create 2 pods one will be webserver 1 and the other webserver 2, each containing one container of an NGINX web server with a costum index.html file.
It will then deploy an ELB to the cluster, in this project I use HAProxy K8s Ingress Controller as a load balancer (the load is balanced using the round-robin method).


# Prerequisites

1. Running Jenkins instance is a must
2. Install required plugins on the Jenkins server: Git & AWS credentials
3. Dockerhub account
4. Terraform
5. Docker 
6. Must run on Linux
7. A tfvars file, containing the AWS credentials for terraform to use, can be located anywhere.

# Setting up the environment

There are somethings the user needs to do before running the job for the build to compelete successfully

First thing, create and env variable (in my case the file to create permanent env var was located at /etc/environment) called KUBECONFIG and set its value to /var/lib/jenkins/.kube/config - this is done so the kubectl could access the cluster using your day to day user instead of su'ing to the Jenkins user, because Kubectl runs a diffrent instance for each user.

for convinience copy the following line - KUBECONFIG = "/var/lib/jenkins/.kube/config"


Second thing, set up the credentials, create new AWS credentials in the Jenkins plugin credential manager, name it 'aws-creds' and insert the access and secret key that you got from AWS.

Now also create the Dockerhub creds using the username and password option, be sure to name it 'dockerhub_creds'.

When I say naming I mean setting the Id - there is usually no specific name field in the plugin.

# Known bugs (to be fixed)

To destroy the Terraform resources you must first manually delete the the load balancer from the AWS, that's because it is not created using the Terraform script, it is created when deploying the HAProxy Ingress controller, in the future, will create a second job for smooth, automatic deletion.
If the above step is not executed, terraform destroy will delete some of the resources and it may consume additional fees.



# Workflow

The pipleline will:
Build costum docker images for the webservers.
Execute terraform apply to deploy and configure the cloud infrastracture.
Create a kubeconfig file for remote management of the cluster.
Grant 777 permissions to the file, so that it could be used by any user on the system (not secure, but ok for personal project)
Deploy the webserver images to the K8s (2 pods - 1 container in each pod - each container runs a diffrent webserver)
Deploy the HAProxy K8s Ingress controller together with the neccessary ingress resource and ingress class.


You can get the external IP of the ingress controller using - kubectl get service command.
Use this long DNS name to access your K8s cluster from anywhere, each time you refresh the page, it suppossed to print webserver1 or webserver2 accordingly, that way you know it works.



