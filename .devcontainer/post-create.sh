#!/bin/bash
set -e

echo "🔧 Running post-create setup..."

# Ensure uv is in PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Setup Python environment for backend
if [ -d "backend" ]; then
    echo "📦 Setting up Python environment for backend..."
    cd backend
    
    # Check if uv is available and use it, otherwise fall back to pip
    if command -v uv &> /dev/null; then
        echo "Using uv for dependency management..."
        uv sync
    else
        echo "uv not found, falling back to pip..."
        if [ -f "pyproject.toml" ]; then
            pip install -e .
        elif [ -f "requirements.txt" ]; then
            pip install -r requirements.txt
        fi
    fi
    
    cd ..
fi

# Setup Node.js environment for web
if [ -d "web" ]; then
    echo "📦 Setting up Node.js environment for web..."
    cd web
    
    # Install dependencies
    if [ -f "package.json" ]; then
        npm install
    fi
    
    cd ..
fi

# Setup Node.js environment for mobile
if [ -d "mobile" ]; then
    echo "📦 Setting up Node.js environment for mobile..."
    cd mobile
    
    # Install dependencies
    if [ -f "package.json" ]; then
        npm install
    fi
    
    cd ..
fi

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file..."
    cat > .env << EOF
# Environment Configuration
DEBUG=true
HOST=0.0.0.0
PORT=8000

# Add your environment variables here
EOF
fi

# Add alias for dev command
echo "🔗 Setting up dev alias..."
echo 'alias dev="claude --dangerously-skip-permissions"' >> ~/.bashrc

echo "✅ Post-create setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Update the .env file with your configuration"
echo "2. Start the backend: cd backend && python -m main (or your entry point)"
echo "3. Start the web app: cd web && npm run dev"
echo "4. Start the mobile app: cd mobile && npm run start"
echo ""