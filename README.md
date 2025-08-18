# Failover WireGuard Cluster

![Project Architecture](images/project-wg-bgp.jpg)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![WireGuard](https://img.shields.io/badge/WireGuard-1.0+-blue.svg)](https://www.wireguard.com/)
[![BGP](https://img.shields.io/badge/BGP-FRRouting-green.svg)](https://frrouting.org/)

A high-availability WireGuard VPN cluster with automatic failover and optimized routing using BGP and keepalived.

## 🏗️ Architecture

The project implements a resilient VPN infrastructure consisting of:

- **4 Virtual Machines**: 3 nodes with public IP addresses (gateway nodes) + 1 internal node without public IP
- **Full Mesh WireGuard Network**: Every node connects to every other node for maximum redundancy
- **BGP Dynamic Routing**: Optimizes packet routing between peers automatically
- **Keepalived High Availability**: Ensures automatic failover when nodes become unavailable
