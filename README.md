# Deploy app in private ec2 using Jenkins 

## infrastructure of the project 
- 1 VPC
- 2 public subnets
- 2 private subnets 
- NAT gateway
- 2 ec2 one for bastion in public subnet and one to deploy app in private subnet
- RDS
- ElastiCache
- loadbalancer      >to expose the app

you have to create S3 bucket to save state file or you need to update backend.tf file
Build infrastructure by running
```
terraform init
terraform apply --var-file dev.tfvars
```
## configure your jenkins container to access private ec2 through bastion ##
**open ~/.ssh/config and write**
```
host bastion
   HostName [3.227.19.162]--> bastion public ip
   User ubuntu
   identityFile ~/.ssh/key-pair-3.pem

host private_instance
   HostName  10.0.2.37  --> slave private ip 
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   identityFile ~/.ssh/key-pair-3.pem
```
**take the downloaded file [key-pair-3]*.pem and put it in .ssh**
test yor connection by type `ssh private_instance`

## run ansible playbook in ansible directory 
`ansible-playbook apply -f ec2-ansible.yml`

## open jenkins server and create a new node
![ec2 node configration](/Jenkins-Project/ec2-configration.png)

## Download .jar file and copy it to ec2 instance in path ~/bin
`scp agent.jar ubuntu@private_instance:~/bin`

## use jenkins pipeline to deploy app
```
pipeline{
    agent { label 'ec2' }
    stages {
        stage('preparation'){
            steps{
                git branch:"rds_redis", url:'https://github.com/mahmoud254/jenkins_nodejs_example'
            }
        }
        stage('ci'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub',usernameVariable:'USER', passwordVariable:'PASSWORD')]){
                sh """
                docker build . -f dockerfile -t node_noenv
                docker tag node_noenv belalhany/iti_jenkins:3.0
                docker login -u ${USER} -p ${PASSWORD}
                docker push belalhany/iti_jenkins:3.0
                """                
                }
            }
        }
        stage('cd'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'rds',usernameVariable:'USER', passwordVariable:'PASSWORD')]){
                    sh "docker run -d -p 3000:3000 \
                        -e RDS_HOSTNAME=[ terraform-20220730025830436100000001.c4hdb2mnodut.us-east-1.rds.amazonaws.com] >created rds instance endpoint \
                        -e RDS_USERNAME=${USER} \
                        -e RDS_PASSWORD=${PASSWORD} \
                        -e RDS_PORT=3306 \
                        -e REDIS_HOSTNAME=[ cluster-example.q6tl2l.0001.use1.cache.amazonaws.com:6379 ] created cluster id \
                        -e  REDIS_PORT=6379 \
                        belalhany/iti_jenkins:3.0"
                }
            }
        }
    }
    
}
```
![pipeline result](/Jenkins-Project/pipeline.png)

go to RDS and create securitygroup to allow port 3306 and 22 inpound traffic

test the app by running in the container
```
ssh private_instance
curl locathost:3000/db
```


