# **RC Pipeline Monorepo**

Professional-grade full-stack monorepo managed by **Nx**, fully containerized with **Docker**, and pre-configured for **VS Code Dev Containers**.

## **1\. Architecture & Networking**

The project utilizes a **sidecar network architecture** to simplify service discovery and cross-origin communication.

* **Network Host (backend):** The PHP container manages the network namespace. It exposes all public ports (8080, 4200, 8081).  
* **Workspace Agent (workspace):** Runs Node.js/Nx. It attaches to the backend's network, allowing localhost communication between React and CodeIgniter.  
* **Infrastructure:** Uses Alpine-based images for minimal footprint and fast cold starts.

## **2\. Tech Stack**

| Component | Technology | Internal Path | Port |
| :---- | :---- | :---- | :---- |
| **Frontend** | React 19 \+ Vite | apps/frontend | 4200 |
| **Backend API** | CodeIgniter 4.x | apps/backend/codeigniter4 | 8080 |
| **DB Admin** | Adminer | N/A | 8081 |
| **Monorepo Tool** | Nx | Root | N/A |

## **3\. Project Structure**

.  
├── apps/  
│   ├── frontend/             \# React 19 \+ Tailwind/CSS  
│   │   ├── src/              \# Application logic  
│   │   └── vite.config.ts    \# Vite & Proxy configuration  
│   └── backend/  
│       └── codeigniter4/     \# PHP Framework Root  
│           ├── app/          \# PHP Logic (Controllers, Models)  
│           ├── public/       \# API Entry point  
│           └── writable/     \# Logs and Cache  
├── .devcontainer/            \# Infrastructure as Code (Docker/JSON)  
├── nx.json                   \# Nx workspace dependency graph  
└── package.json              \# Global scripts and dependencies

## **4\. Development Workflow**

### **Environment Setup**

1. Ensure **Docker Desktop** and **WSL2** (if on Windows) are running.  
2. Open the folder in VS Code.  
3. Click **"Reopen in Container"** when prompted.

### **Execution Commands**

| Task | Command | Context |
| :---- | :---- | :---- |
| **Start Frontend** | npx nx serve frontend | Workspace |
| **Build All** | npx nx run-many \-t build | Workspace |
| **CI4 Spark CLI** | php spark \[command\] | Backend |
| **Database Migrate** | php spark migrate | Backend |
| **Dependency Graph** | npx nx graph | Workspace |

## **5\. Development Guidelines**

* **API Calls:** Use relative paths (e.g., /api/endpoint). The Vite proxy is configured to redirect these to the backend container automatically.  
* **Permissions:** If you encounter EACCES during file creation, run sudo chown \-R $(whoami) . in the terminal.  
* **Code Style:** Nx enforces linting rules. Run npx nx lint frontend before pushing changes.

## **6\. Troubleshooting**

* **Port 4200 not loading:** Ensure the backend container is running; it owns the port mapping for the workspace.  
* **SQLite Locked:** Ensure the writable folder in the backend has 777 permissions if using SQLite.  
* **Vite HMR:** If Hot Module Replacement fails, ensure server.host is set to 0.0.0.0 in vite.config.ts.

