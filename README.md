# terraform-pra-aws

# 🛡️ Infrastructure as Code - Plan de Reprise d’Activité (PRA) sur AWS avec Terraform

Ce dépôt présente un exemple complet de déploiement Infrastructure as Code (IaC) d’un Plan de Reprise d’Activité (PRA) sur AWS à l’aide de Terraform.

L’objectif principal est de montrer, à travers un cas concret, comment automatiser la mise en place d'une infrastructure de secours, avec notamment :
- un Network Load Balancer (NLB) multi-AZ,
- des instances HAProxy configurées pour la redirection TCP (ex : RDP),
- une Launch Template EC2 pour des serveurs PRA,
- des règles de sécurité réseau, EIP, DNS Route53, etc.

---

## 📚 À propos

Ce projet a été réalisé à des fins d’apprentissage dans un contexte professionnel, puis anonymisé et partagé ici pour :
- servir de référence pédagogique à ceux qui débutent avec Terraform sur AWS,
- montrer un cas réel et structuré d’implémentation cloud avec haute disponibilité,
- démontrer ma capacité à modulariser et documenter un projet DevOps orienté infrastructure.

📄 Un rapport technique anonymisé accompagne ce dépôt pour décrire le raisonnement et les choix faits.



## 🚀 Objectif éducatif

🎓 Ce dépôt est destiné à toute personne souhaitant :
- apprendre à structurer un projet Terraform propre et maintenable,
- comprendre l’intégration de plusieurs services AWS en environnement hybride,
- s’exercer à un cas d’usage concret et reproductible : la mise en place d’un PRA.

---

## ✅ Utilisation

Ce projet peut être utilisé comme base ou inspiration pour vos propres projets.  
⚠️ Aucune donnée sensible n’est incluse — tout a été anonymisé.

---

## 🪪 Licence

Ce dépôt est partagé à des fins éducatives, non commerciales et communautaires.  
Améliorations bienvenues ✨

---

## 🙋‍♀️ Auteure

Projet réalisé par une administratrice systèmes DevOps en alternance, dans le cadre de sa formation.  
Spécialisation : Infrastructure Cloud, DevOps, PRA, Automatisation Terraform.

Pour toute questions ou retour sur ce projet me contacter via Github ou likedin : https://www.linkedin.com/in/laetitia-lafarge-4a3235191/
