# Authentication Integration

## Introduction

Authentication drivers handle OP5 Monitor's authentication system. Each driver handles both authentication of the user and resolution of the group memberships for the given user. The groups are then mapped to permissions by the authorization layer, which we will describe later.

An authentication driver can rely on either:

-     Local storage (Driver Default);
-     Apache authentication (Driver apache);
-     An external system for managing users (Driver LDAP).

We can configure the authentication system using the **Auth Modules** option in Configure:

![](images/16482389/16679133.png) \


We store the configuration for the authentication system in '`/etc/op5/auth.yml`*'.*

**Child Pages**

- [Apache](Apache)
- [Default](Default)
- [Header Authentication Method, or SSO (single sign on)](Header_auth_SSO)
- [LDAP and Active Directory](LDAP_and_Active_Directory)
