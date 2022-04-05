# CHECK before run this script

- Validate your GKE API is enabled 
- Your Account service have following permissions with a custom role or search for a role how have these permitions

    - compute.instanceGroupManagers.get
    - compute.networks.create
    - compute.networks.delete
    - compute.networks.get
    - compute.networks.updatePolicy
    - compute.subnetworks.create
    - compute.subnetworks.delete
    - compute.subnetworks.get
    - container.clusters.create
    - container.clusters.delete
    - container.clusters.get
    - container.operations.get

- And the role of iam.seviceAccountUser with the following permissions would be applyed
    - iam.serviceAccounts.actAs
    - iam.serviceAccounts.get
    - iam.serviceAccounts.list
    - resourcemanager.projects.get
    - resourcemanager.projects.list