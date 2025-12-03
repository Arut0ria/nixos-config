# nixos-config

A modular, maintainable, and fully reproducible configuration for NixOS.  
This repository provides a clean structure for managing multiple machines, shared modules, home-manager integration, and system-level customization using Nix flakes.

---

## 📦 Features

- **Flake-enabled** NixOS configuration  
- **Modular structure** for systems, services, and user profiles  
- **Home Manager integration** (if applicable)  
- Machine-specific host configurations  
- Reusable modules for system options, packages, and services  
- Strong focus on **reproducibility** and **declarative system management**  
- Easy to extend and adapt to new devices  

---

## ⚙️ Repository Structure

### **`flake.nix`**
Defines inputs (Nixpkgs, Home Manager, etc.) and system configurations.

### **`hosts/`**
Contains machine-specific NixOS setups.  
Each folder represents one host with its hardware configuration.

### **`modules/`**
Reusable modules for system configuration, services, packages, and more.

### **`resources/`**
Optional folder for wallpapers, scripts, fonts, or other assets.

---

## 🧪 Testing in a VM

Build and run a VM for testing:
```sh
nix build .#nixosConfigurations.<hostname>.config.system.build.vm
./result/bin/run-*-vm
```

---

## 📜 License

This project is licensed under the MIT License unless otherwise specified.
