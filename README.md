# INCEPTION - Docker Infrastructure Project

A 42 Common Core project that builds a complete web infrastructure using Docker containers with NGINX, WordPress, and MariaDB.

## Overview

Inception is a system administration project that creates a multi-service web infrastructure using Docker containers. The project implements a complete LEMP stack (Linux, NGINX, MariaDB, PHP) with WordPress, all running in separate containers orchestrated by Docker Compose.

## Learning Objectives

This project serves as a comprehensive introduction to **Docker containerization** and modern DevOps practices. Key learning outcomes include:

### Docker Fundamentals
- **Container Concepts**: Understanding the difference between containers and virtual machines
- **Image Creation**: Building custom Docker images from scratch using Dockerfiles
- **Container Lifecycle**: Managing container states (build, run, stop, remove)
- **Best Practices**: Writing efficient, secure, and maintainable Dockerfiles

### Container Orchestration
- **Docker Compose**: Multi-container application orchestration
- **Service Dependencies**: Managing startup order and inter-service communication  
- **Networking**: Creating and configuring custom Docker networks
- **Volume Management**: Implementing persistent data storage across container restarts

### Infrastructure as Code
- **Declarative Configuration**: Defining infrastructure through YAML files
- **Environment Management**: Using environment variables for configuration
- **Automation**: Creating reproducible deployments with make commands
- **Version Control**: Tracking infrastructure changes in Git

### DevOps Skills
- **Service Architecture**: Designing microservices with single responsibilities
- **Security**: Implementing SSL/TLS, container isolation, and secure configurations
- **Troubleshooting**: Debugging containerized applications and networking issues
- **Monitoring**: Analyzing logs and container health

### Real-World Applications
Through this project, you'll gain hands-on experience with:
- Setting up production-like web infrastructures
- Understanding how modern web applications are deployed
- Learning industry-standard tools used in DevOps workflows
- Building skills applicable to cloud platforms (AWS, GCP, Azure)

This foundation in Docker prepares you for advanced topics like Kubernetes, CI/CD pipelines, and cloud-native development.

## Quick Start

### Prerequisites
- Docker
- Docker Compose
- Make
- sudo privileges

### Installation
```bash
git clone https://github.com/BeAzarym/42-INCEPTION.git
cd 42-INCEPTION
```

### Configuration
Create a `.env` file in the `srcs/` directory with your environment variables:
```bash
# Database Configuration
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=your_password
MYSQL_ROOT_PASSWORD=your_root_password

# WordPress Configuration  
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=your_admin_password
WP_ADMIN_EMAIL=admin@example.com
WP_USER=user
WP_USER_PASSWORD=user_password
WP_USER_EMAIL=user@example.com

# Domain Configuration
DOMAIN_NAME=your_domain.42.fr
```

### Basic Usage
```bash
make          # Build and start all services
make up       # Start the infrastructure
make down     # Stop all containers  
make clean    # Stop containers and clean system
make re       # Full rebuild
```

## Project Architecture

### Services Overview
The infrastructure consists of three main services:

| Service   | Container | Port | Description |
|-----------|-----------|------|-------------|
| NGINX     | nginx     | 443  | Reverse proxy with SSL/TLS |
| WordPress | wordpress | 9000 | PHP-FPM WordPress application |
| MariaDB   | mariadb   | 3306 | Database server |

### Container Details

#### NGINX Container
- **Base Image**: Debian Bullseye
- **Features**: 
  - SSL/TLS encryption (self-signed certificate)
  - Reverse proxy to WordPress
  - Custom configuration
- **Volumes**: Shared WordPress files

#### WordPress Container  
- **Base Image**: Debian Bullseye
- **Features**:
  - PHP-FPM 7.4
  - WordPress with custom configuration
  - Automated setup script
- **Volumes**: WordPress files persistence

#### MariaDB Container
- **Base Image**: Debian Bullseye  
- **Features**:
  - MySQL-compatible database
  - Custom database initialization
  - Data persistence
- **Volumes**: Database files persistence

## Network & Storage

### Docker Network
- **Network Name**: `inception`
- **Type**: Bridge network for inter-container communication

### Persistent Volumes
```
/home/$USER/data/
├── wordpress/    # WordPress files
└── mariadb/      # Database files
```

## Project Structure
```
Inception/
├── Makefile                          # Build automation
├── srcs/
│   ├── docker-compose.yml           # Container orchestration
│   ├── .env                         # Environment variables
│   └── requirements/
│       ├── mariadb/
│       │   ├── Dockerfile           # MariaDB container
│       │   ├── conf/50-server.cnf   # Database configuration
│       │   └── tools/init-db.sh     # Database setup script
│       ├── nginx/
│       │   ├── Dockerfile           # NGINX container
│       │   └── conf/nginx.conf      # Web server configuration
│       └── wordpress/
│           ├── Dockerfile           # WordPress container
│           ├── conf/www.conf        # PHP-FPM configuration
│           └── tools/init-wp.sh     # WordPress setup script
└── README.md
```

## Advanced Usage

### Manual Container Management
```bash
# Build specific service
sudo docker-compose -f srcs/docker-compose.yml build nginx

# View logs
sudo docker-compose -f srcs/docker-compose.yml logs -f wordpress

# Execute commands in container
sudo docker exec -it nginx bash
sudo docker exec -it wordpress bash
sudo docker exec -it mariadb bash
```

### Troubleshooting
```bash
# Check container status
sudo docker ps

# View container logs
sudo docker logs nginx
sudo docker logs wordpress  
sudo docker logs mariadb

# Clean Docker system
make clean
sudo docker system prune -a
```

## Technical Requirements

### Project Constraints
- Each service runs in a dedicated container
- Containers built from Debian Bullseye base image
- Custom Dockerfiles for each service
- No pre-built Docker images from DockerHub
- NGINX with SSL/TLS only
- WordPress with PHP-FPM (no Apache)
- MariaDB database
- Persistent volumes for data
- Docker network for container communication
- Environment variables for configuration
- Containers restart on crash

### Security Features
- SSL/TLS encryption for HTTPS
- Isolated container network
- Non-root container execution where possible
- Environment variable configuration
- Persistent data outside containers

## Build Commands

| Command | Description |
|---------|-------------|
| `make` | Build and start all services |
| `make req` | Create required directories |  
| `make compose` | Build containers without cache |
| `make up` | Start the complete infrastructure |
| `make down` | Stop all containers and remove volumes |
| `make clean` | Full cleanup (containers, networks, data) |
| `make re` | Complete rebuild |

## Access Points

After successful deployment:
- **Website**: `https://your_domain.42.fr` (or localhost)
- **WordPress Admin**: `https://your_domain.42.fr/wp-admin`
