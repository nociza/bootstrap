# Claude Container Scaffolding

This repository serves as a scaffolding template to bootstrap development projects. It provides a foundational structure with pre-configured development containers, mobile and web applications, and backend infrastructure to accelerate the initial setup phase of new projects.

## Structure

- **Backend**: Essential backend files and configurations
- **Mobile**: Mobile application setup with core components
- **Web**: Web application with essential configurations
- **Chromext**: Chrome extension boilerplate (git submodule) - React + Vite based Chrome extension template
- **Development Container**: Pre-configured development environment with post-create scripts

## Getting Started

Use this repository as a starting point for your development projects by cloning and customizing the structure to fit your specific needs.

### Development Containers

This project uses `cuti` for managing development containers. To set up your development environment:

```bash
# Install cuti
uv tool install cuti

# Start the development container
cuti container
```

### Working with Submodules

The Chrome extension boilerplate is included as a git submodule. When cloning this repository, use:

```bash
git clone --recurse-submodules <repository-url>
```

Or if you've already cloned the repository:

```bash
git submodule update --init --recursive
```

To update the Chrome extension boilerplate to the latest version:

```bash
cd chromext
git pull origin main
cd ..
git add chromext
git commit -m "Update chromext submodule to latest version"
```