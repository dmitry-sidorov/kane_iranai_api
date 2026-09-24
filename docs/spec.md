# Specification

## Overview

This document describes the specifications for the project, including system architecture, data models, and API contracts.

## User flow

### Auth

1. User can sign up with signup form. User should confirm email address.
2. Known user can sign in with email and password.
3. User can reset password via email recovery link.
4. User can update profile information and change password.
5. User can sign out from the application.

### Account

1. User can create debit accounts.
2. User can view account details and transaction history.
3. User can delete debit accounts. Deleting an account should not remove all associated transactions, if this is not specified by the user.
4. User can edit debit account details.
5. Account currency couldn't be changed after creation.

### Operations

1. User can create new operation (debit/credit) for their accounts.
2. User can view operation details and filter by date range, category, or amount.
3. User can edit operation details including amount, category, date, and description.
4. User can delete opearation from their history.

### Currencies

1. User can view available currencies for account creation.
2. User can convert amounts between different currencies using current exchange rates. (optional)

### Operation Categories

1. User can view available operation categories.
2. User can categorize operations by selecting from predefined categories.
3. User can create custom operation categories.
4. User can edit and delete their custom categories.
5. Default categories are preloaded when user is created.

### User Operation Categories

1. User can assign specific operation categories to their accounts.
2. User can view which categories are associated with each account.
3. User can remove category associations from accounts.
4. User can manage the order of categories within their account view.

### Groups

1. User can create groups to manage accounts with another users. User becomes an admin for group he created.
2. User can view group details and associated accounts.
3. User can edit group information including name and description.
4. User can delete groups, optionally reassigning accounts to other groups or removing them.
5. User can add or remove accounts from groups.
6. User can invite or remove members from groups.

### Transfer operations

1. User can transfer funds between their own debit accounts.
2. User can view transfer history and filter by date range or amount.
3. User can edit transfer details including amount, source account, destination account, and description.
4. User can cancel pending transfers.

### Budget plans

1. User can create budget plans with specified amounts and time periods.
2. User can view existing budget plans and their current status.
3. User can edit budget plan details including title, amount, category, and duration.
4. User can delete budget plans.
5. User can track spending against budget categories and receive notifications when limits are approached or exceeded.
6. User can generate reports showing budget utilization and remaining balances.
7. User can use budget plan in group with another users.

### Planned operations

1. User can add planned operations to budget plan by categories.
2. Planned operations are tracked against real operations in given dates in current budget plan for corresponding categories.
3. User can edit planned operation details including amount, category, date, and description.
4. User can delete planned operations from budget plan.