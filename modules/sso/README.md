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

### How to Customize the AWS access portal URL

By default, AWS access portal is accessible through a URL of the form d-xxxxxxxxxx.awsapps.com/start. However, you can customize the URL to your_subdomain.awsapps.com/start. This change to the AWS access portal URL is permanent, and you will not be able to edit it later.

To customize your URL

1. Sign in to your AWS access portal. For more information, see How to sign in to the AWS access portal.

2 .In the IAM Identity Center console, under Dashboard, go to the AWS access portal section at the bottom of the page.

3. Choose Customize.

4. Enter your desired domain name and choose Save.

You can now sign in to the AWS Console through your AWS access portal with your customized URL.