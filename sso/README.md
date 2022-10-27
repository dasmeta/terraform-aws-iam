## This module configures AWS Single Sign-On (SSO). AWS SSO makes it easy to centrally manage access to multiple AWS accounts and business applications and provide users with single sign-on access to all their assigned accounts and applications from one place. 

### Usage

This module contains two sub-modules that can be used in conjunction to provision AWS SSO Permission Sets and to 
assign AWS SSO Users and Groups to Permissions Sets in accounts.

- [modules/account-assignments](/modules/account-assignments) - a module for assigning groups to permission 
sets in particular accounts
- [modules/permission-sets](/modules/permission-sets) - a module for provisioning AWS SSO permission sets

### Example

```hcl
module "sso_setup" {
  source = "./"

  associations = [
    {
      group  = "AWSMarketplaceFullAccess"
      policy = "arn:aws:iam::aws:policy/AWSMarketplaceFullAccess" s"
      // You can set AWS account id (default is current account)
      account_id = ""
    },
    {
      group  = "AmazonGlacierReadOnlyAccess"
      policy = "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess"
    },
  ]
}
```

