# Ansible Instructions

### How to Build Ansible Controller.

Below Command will Build the Ansible Controller running on Ubuntu16.04

```bash
docker build -t nishanthkp/ansiblecontroller:ubuntu16 --file AnsibleControllerUbuntu16 .
```

### Run the container:

Ubuntu16.04

```bash
docker run --rm -it -d --name ansiblecontroller16 --hostname ansiblecontroller16 -v "$(pwd)":/ansible/playbooks nishanthkp/ansiblecontroller:ubuntu16
```

### View Docker Container Names and there IP Addresses

Filter for Name and IP Address of the running Containers

```bash
docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)
```

### Login to the Container SSH

```bash
ssh username@<CONTAINERIP>
```

Username: root
Password: Passw0rd

------------------

# Target Instructions


### How to Build Target Servers

Below Command will Build the Target Servers running on Ubuntu16.04

```bash
docker build -t nishanthkp/targetserver:ubuntu16 --file TargetServerDockerfile16 .
```

### Create a Target1 Server

```bash
docker run --rm -it -d --name targetserver1 --hostname targetserver1 nishanthkp/targetserver:ubuntu16
```

### Create a Target1 Server

```bash
docker run --rm -it -d --name targetserver2 --hostname targetserver2 nishanthkp/targetserver:ubuntu16
```

### View Docker Container Names and there IP Addresses

Filter for Name and IP Address of the running Containers

```bash
docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)
```


# Test Weather you are able to reach your Target Servers or not

```bash
ansible all -m ping -i inventory.txt
```