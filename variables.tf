
#AWS Provider Settings
variable "aws_region" {
  description = "Région AWS dans laquelle déployer l'infrastructure"
  type        = string
  default     = "eu-west-3" # Modifier si besoin
}

#Tags Globaux
variable "map_migrated_tag" {
  description = "Tag de migration utilisé pour identifier les ressources migrées"
  type        = string
}

variable "environment" {
  description = "Environnement (ex: dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Nom du projet utilisé dans les tags"
  type        = string
}

#VPC & Sous-réseaux
variable "main_vpc_name" {
  description = "Nom du VPC principal (utilisé pour la NLB)"
  type        = string
}

variable "company_name" {
  description = "Nom de l'entreprise pour identifier le VPC secondaire"
  type        = string
}

#Sous-réseaux privés (AZ1, AZ2, AZ3)
variable "private_az1_subnet_name" {
  description = "Nom du subnet privé dans la zone de disponibilité 1"
  type        = string
}

variable "private_az2_subnet_name" {
  description = "Nom du subnet privé dans la zone de disponibilité 2"
  type        = string
}

variable "private_az3_subnet_name" {
  description = "Nom du subnet privé dans la zone de disponibilité 3"
  type        = string
}

#Sous-réseau privé secondaire (autre AZ)
variable "second_private_az1_subnet_name" {
  description = "Nom du second subnet privé dans AZ1"
  type        = string
}

#Sous-réseaux publics
variable "public_az1_subnet_name" {
  description = "Nom du subnet public dans AZ1"
  type        = string
}

variable "public_az2_subnet_name" {
  description = "Nom du subnet public dans AZ2"
  type        = string
}

variable "public_az3_subnet_name" {
  description = "Nom du subnet public dans AZ3"
  type        = string
}

variable "public_az_wildcard_subnet_name" {
  description = "Nom générique pour retrouver tous les subnets publics"
  type        = string
}

#IAM / Instance Profile
variable "iam_instance_profile_name" {
  description = "Nom du profil d'instance IAM à associer aux EC2"
  type        = string
}

#Security Groups
variable "global_sg_name" {
  description = "Nom du security group global (commun à toutes les ressources)"
  type        = string
}

variable "global_app_sg_name" {
  description = "Nom du security group global pour les applications"
  type        = string
}

#Route 53
variable "route53_zone_name" {
  description = "Nom de la zone Route 53 publique"
  type        = string
}

variable "domain" {
  description = "Nom de domaine (ex: exemple.cloud)"
  type        = string
}

#EC2 / DRS
variable "ec2_instance_haproxy_name" {
  description = "Nom de l’instance EC2 HAProxy principale"
  type        = string
}

variable "ec2_instance_haproxy_2_name" {
  description = "Nom de l’instance EC2 HAProxy secondaire"
  type        = string
}

#NLB / Network Load Balancer
variable "nlb_name" {
  description = "Nom de la Network Load Balancer (NLB)"
  type        = string
}

variable "nlb_sg_name" {
  description = "Nom du security group pour la NLB"
  type        = string
}

variable "eip_nlb_onprem1_name" {
  description = "Nom du tag pour l'EIP utilisé sur la NLB (subnet 1)"
  type        = string
}

variable "eip_nlb_onprem2_name" {
  description = "Nom du tag pour l'EIP utilisé sur la NLB (subnet 2)"
  type        = string
}

variable "eip_nlb_onprem3_name" {
  description = "Nom du tag pour l'EIP utilisé sur la NLB (subnet 3)"
  type        = string
}

#NLB Listener / Target Group
variable "listener_port" {
  description = "Port d'écoute utilisé par la NLB (ex: 3389 pour RDP)"
  type        = number
}

variable "ingress_rule_description" {
  description = "Description de la règle d'ingress autorisant l'accès public"
  type        = string
}

variable "target_group_name" {
  description = "Nom du target group attaché à la NLB"
  type        = string
}
