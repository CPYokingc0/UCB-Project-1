## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Update the path with the name of your diagram](Images/Azure-Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook files may be used to install only certain pieces of it, such as Filebeat.


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Damn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound access to the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file system of hte VMs on the network, as well as watch system metrics.
- Filebeat monitors for changes in files and generates logs on the file system.
- Metricbeat records system metrics like system uptime, CPU workloads, memory usage, etc.

The configuration details of each machine may be found below.

|   Name   	|             Function             	| IP Address 	| Operating System 	|
|:--------:	|:--------------------------------:	|:----------:	|:----------------:	|
| Jump Box 	|       Gateway/Provisioning       	|  10.0.0.4  	| Linux v18.04 LTS 	|
|   Web-1  	|            HTTP Server           	|  10.0.0.5  	| Linux v18.04 LTS 	|
|   Web-2  	|            HTTP Server           	|  10.0.0.6  	| Linux v18.04 LTS 	|
|   Web-3  	|            HTTP Server           	|  10.0.0.7  	| Linux v18.04 LTS 	|
|  ELK-SVR 	| Data Acquisition <br>& Analytics 	|  10.2.0.4  	| Linux v18.04 LTS 	|

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- IP address (174.50.161.39) from my home ISP vendor (Comcast).

Machines within the network can only be accessed by the Jump Box.
- All machines within the 10.0.0.0 network can communicate with the ELK server because of the peering         configuration between the two virtual subnets. 

A summary of the access policies in place can be found in the table below.

| Server Name 	| Publicly Accessible 	| Allowed IP Addresses 	|
|:-----------:	|:-------------------:	|:--------------------:	|
|   Jump Box  	|         Yes         	|     174.50.161.39    	|
|   ELK-SVR   	|         Yes         	|     174.50.161.39   	|
|    Web-1    	|          No         	|    10.0.0.1 to 254   	|
|    Web-2    	|          No         	|    10.0.0.1 to 254   	|
|    Web-3    	|          No         	|    10.0.0.1 to 254   	|


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because automation almost eliminates configuration errors and is so much more efficient because so many machines can be configured in a much shorter time frame. Changes and deployment can be implemented faster with less labor costs.

The [ELK Server Playbook File](Ansible%20and%20Config%20files/install-elk.yml) implements the following tasks:

- Specifies hosts and remote user names
- Downloads and installs app modules such as docker, python, docker python module
- Configures additional virtual memory
- Configures and opens TCP ports

 
The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![screenshot of docker ps output](Images/Docker_PS.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

| Server Name 	| Private IP Address 	|
|:-----------:	|:------------------:	|
|    Web-1    	|      10.0.0.5      	|
|    Web-2    	|      10.0.0.6      	|
|    Web-3    	|      10.0.0.7      	|

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:

- Filebeat collects and ships data from log files generated by the systems they are installed in. Examples of data collected include local and remote log-on attempts, failed & successful log-on, file access violations, privilege escalations, and many other events tracked and logged by the system.
- Metricbeat collects and ships data from system metrics in the systems they are installed in. Examples of system metrics include the status and state of various components of the system such as CPU load, CPU temperature, CPU load balancing, memory usage over time, storage capacity, predicted failure of storage devices, status of redundant components such as fans and power supplies, system temperature, and many others.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook files (*.yml) to the /etc/ansible directory.
- Update the [hosts](Images/hosts.png) file to include webservers and ELK server private IP addresses.
- Run the playbooks, and navigate to the ELK server's public IP address:5601 to check that the installation worked as expected. The sequence of commands are below:
- ansible-playbook /etc/ansible/install-elk.yml
- ansible-playbook /etc/ansible/filebeat-playbook.yml
- ansible-playbook /etc/ansible/metricbeat-playbook.yml


- The playbook files used in this deployment are *install-elk.yml, filebeat-playbook.yml* and *metricbeat-playbook.yml*. These files were copied into the /etc/ansible directory of the Ansible control node.
- The hosts file located in the /etc/ansible/ directory is updated so that it contains the private IP addresses of servers that will be monitored, under the [webservers] heading, and also the private IP address of the ELK server under the [elk] heading. The value of the hosts statement in each playbook file designates which devices will receive the actions specified in each playbook. The hosts statement is usually defined at or near the top of the playbook file and will follow what was configured in the hosts file.
 	
 
- The URL to navigate to is the *public IP address of the ELK server plus :5601/app/kibana*. If the webpage loads, the ELK server is running and configured. [Screenshot of my ELK server URL](Images/Kibana.png)
- If it becomes necessary to redeploy this ELK Stack configuration, or any part of it, I have created simple [scripts](Scripts) that can be executed faster than manually retyping the commands to run the various playbooks.


