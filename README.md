# Farmer Identity Smart Contract (Sui Move)

This project provides a secure **Farmer Identity Management** solution built using **Sui Move**.  
It enables farmers, cooperatives, and external organizations to register, update, verify, and revoke digital farmer identities on the **Sui blockchain**.

The module defines an on-chain **FarmerIdentity** object that stores key information such as farmer name, location, crop type, certification details, and ownership. It also emits structured events for transparent auditing.

---

## 🚜 Features

### ✔ Create Farmer Identity  
A new on-chain identity object is generated and automatically transferred to the sender.

### ✔ Update Farmer Details  
The owner can modify farmer-related attributes and emit audit events.

### ✔ Verify Farmer  
External systems or contracts can quickly check whether a farmer identity is active.

### ✔ Revoke Identity  
Farmers can deactivate their identity, preventing further verification checks.

### ✔ Transfer Ownership  
Supports optional future use cases such as cooperative-to-farmer mapping or multi-stakeholder workflows.

---

## 🔧 Tech Stack

- **Language**: Sui Move  
- **Blockchain**: Sui  
- **Core modules used**:
  - `sui::object`
  - `sui::event`
  - `sui::transfer`
  - `sui::tx_context`

---

## 📂 Module Structure

