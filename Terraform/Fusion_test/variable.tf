############################ variable.tf

############ 임시 포트(all)
variable "tempPORT" {
  type = string
}

############ K8s 보안그룹
#ssh_port
variable "ssh_port" {
  type = string
}

#k8s_port
variable "k8s_port" {
  type = string
}


############ K8s 마스터&워커
## 워커 AMI
variable "WorkerAMI" {
  type = string
}

##workernode1
variable "workernode1" {
  type = string
}

##workernode2
variable "workernode2" {
  type = string
}

#nat_gatway
variable "nat_gateway_name" {
  type = string
}

#subet public
variable "pub2a_subnet1_name" {
  type = string
}
variable "pub2c_subnet1_name" {
  type = string
}
#subnet private 2a
variable "pri2a_subnet2_name" {
  type = string
}
variable "pri2a_subnet3_name" {
  type = string
}
#subnet private 2c
variable "pri2c_subnet2_name" {
  type = string
}
variable "pri2c_subnet3_name" {
  type = string
}