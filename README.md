<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=600&size=26&pause=1000&color=00E5FF&center=true&vCenter=true&width=600&lines=%F0%9F%95%B8%EF%B8%8F+DevOps+VPC+Architecture;%E2%9A%A1+Jenkins+%2B+Terraform+%2B+AWS;" alt="Animated Header" />
</div>

<br>

<div align="center">
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" height="35">
  &nbsp;&nbsp;
  <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white" height="35">
  &nbsp;&nbsp;
  <img src="https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white" height="35">
  &nbsp;&nbsp;
  <img src="https://img.shields.io/badge/Cloud_Networking-00E5FF?style=for-the-badge&logo=linux&logoColor=black" height="35">
</div>

<br>

<h3>
  <span style="color: #00E5FF;">🚀 Project Overview</span><br>
  <img src="https://placehold.co/1000x2/00E5FF/00E5FF.png" width="100%" height="2" alt="Cyan Divider"/>
</h3>

An automated, enterprise-grade cloud networking deployment engine. This project provisions a custom Virtual Private Cloud (VPC) architecture on AWS using Terraform, orchestrated entirely through Jenkins CI/CD pipelines.

**CI/CD Visual Flow Diagram:**
> **`[ Jenkins (Trigger) ]  ➔  [ GitHub (Code) ]  ➔  [ Terraform (Plan/Apply/Destroy) ]  ➔  [ AWS (Infrastructure) ]`**

**Technical Logic (Verified):**
* **🕸️ Network Isolation:** Custom VPC design featuring segregated Public and Private Subnets across multiple Availability Zones for high availability.
* **🔄 Pipeline Orchestration:** Implements distinct `Jenkinsfile` logic for both the base infrastructure and backend setups, allowing the user to explicitly choose between `apply` or `destroy` actions before deployment.
* **🔐 Segmented State Vault:** The repository is cleanly split into two separate dependency folders (`main` and `bootstrap`) to isolate the S3-backed remote state setup from the core VPC deployment, preventing state corruption.
* **🛣️ Traffic Routing:** Automated provisioning of Internet Gateways (IGW) and custom Route Tables to manage inbound/outbound internet access for public resources.
<br>

<h3>
  <span style="color: #39FF14;">📁 Project Structure</span><br>
  <img src="https://placehold.co/1000x2/39FF14/39FF14.png" width="100%" height="2" alt="Green Divider"/>
</h3>

```text
devops-vpc/
├── bootstrap/                 # S3 Infrastructure
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   └── providers.tf
├── main/                      # Core VPC Infrastructure
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   ├── network.tf
│   ├── outputs.tf
│   ├── providers.tf
│   └── variables.tf
├── .gitignore
├── Jenkinsfile_bootstrap      # Pipeline for state infrastructure
└── Jenkinsfile_main           # Pipeline for VPC infrastructure
```
<h3>
  <span style="color: #BC13FE;">🧠 Code Review & Complexity</span><br>
  <img src="https://placehold.co/1000x2/BC13FE/BC13FE.png" width="100%" height="2" alt="Purple Divider"/>
</h3>

<div align="center">
  <img src="https://img.shields.io/badge/OVERALL_DIFFICULTY-ADVANCED_NETWORK-FE428E?style=for-the-badge&logoColor=white" height="35">
</div>

<br>

> <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=600&size=18&pause=1000&color=00E5FF&vCenter=true&width=400&lines=>_ANALYZING_NETWORK_COMPLEXITY..." alt="Animated Loading" />
> 
> <table>
>   <tr>
>     <td width="260"><b><span style="color: #00E5FF;">CI/CD Orchestration (Jenkins)</span></b></td>
>     <td width="200"><img src="https://placehold.co/180x10/00E5FF/00E5FF.png"/><img src="https://placehold.co/20x10/2F2F2F/2F2F2F.png"/></td>
>     <td width="50"><b><span style="color: #00E5FF;">90%</span></b></td>
>   </tr>
>   <tr>
>     <td width="260"><b><span style="color: #39FF14;">State Isolation (S3 Split)</span></b></td>
>     <td width="200"><img src="https://placehold.co/180x10/39FF14/39FF14.png"/><img src="https://placehold.co/20x10/2F2F2F/2F2F2F.png"/></td>
>     <td width="50"><b><span style="color: #39FF14;">90%</span></b></td>
>   </tr>
>   <tr>
>     <td width="260"><b><span style="color: #BC13FE;">Subnet Architecture</span></b></td>
>     <td width="200"><img src="https://placehold.co/170x10/BC13FE/BC13FE.png"/><img src="https://placehold.co/30x10/2F2F2F/2F2F2F.png"/></td>
>     <td width="50"><b><span style="color: #BC13FE;">85%</span></b></td>
>   </tr>
>   <tr>
>     <td width="260"><b><span style="color: #00E5FF;">Traffic Routing (RT/IGW)</span></b></td>
>     <td width="200"><img src="https://placehold.co/160x10/00E5FF/00E5FF.png"/><img src="https://placehold.co/40x10/2F2F2F/2F2F2F.png"/></td>
>     <td width="50"><b><span style="color: #00E5FF;">80%</span></b></td>
>   </tr>
> </table>

<br>

**🟢 High-Impact Wins:**
* **End-to-End Automation:** Eliminated manual `terraform` CLI commands by integrating the entire workflow into Jenkins, complete with user-prompted `apply` and `destroy` safety checks.
* **Modular Backend Architecture:** Successfully refactored the infrastructure into two distinct folders (`main` and `bootstrap`), each with its own dedicated `Jenkinsfile`, ensuring a completely decoupled approach to dependency storage and environment state.

**🔧 Technical Debt / Next Steps:**
* **NAT Gateways:** Currently, private subnets lack outbound internet access. Future iterations will provision NAT Gateways to allow secure outbound patching.
* **VPC Endpoints:** Plan to implement AWS PrivateLink (VPC Endpoints) to allow internal services to communicate with AWS APIs (like S3) without traversing the public internet.

<br>

<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=500&size=16&duration=3000&pause=1000&color=39FF14&center=true&vCenter=true&width=500&lines=[NETWORK_SCAN_COMPLETE]-----------------------" alt="Animated Scan Divider" />
</div>
