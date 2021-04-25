# afrender-formula
A SaltStack formula for deploying and managing Afanasy's render hosts. 

You can try it with Vagrant, simply by running `vagrant up`
Example pillars used for configuring the render node can be found in pillar.example

The AMI for ec2 instances can be built using Packer, the region defaults to eu-central-1, but can be changed using a variable:

```
packer build -var 'region=us-east-1' -var 'buster_ami=ami-07d02ee1eeb0c996c' aws.pkr.hcl
```

Note that base AMIs are stored per-region, so if you change the region, you need to pass the relevant base AMI ID for Debian as well. 


This formula is made for Debian 10.

