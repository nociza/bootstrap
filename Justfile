# Scaffold management commands

# Convert a git submodule to regular folder (preserves content)
# Usage: just detach-submodule <submodule-path>
detach-submodule SUBMODULE:
    #!/usr/bin/env bash
    set -euo pipefail
    
    SUBMODULE="{{SUBMODULE}}"
    
    echo "🔄 Converting $SUBMODULE from submodule to regular folder..."
    
    # Check if submodule directory exists
    if [ ! -d "$SUBMODULE" ]; then
        echo "❌ $SUBMODULE directory not found"
        exit 1
    fi
    
    # Check if it's actually a submodule
    if ! git ls-files --stage "$SUBMODULE" | grep -q "^160000"; then
        echo "⚠️  $SUBMODULE doesn't appear to be a git submodule"
        echo "    Continuing anyway..."
    fi
    
    # Create a backup of the content first (optional safety measure)
    echo "📦 Creating safety backup of $SUBMODULE content..."
    cp -r "$SUBMODULE" "${SUBMODULE}.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Remove the .git file/directory from submodule (keeps content intact)
    if [ -e "$SUBMODULE/.git" ]; then
        rm -rf "$SUBMODULE/.git"
        echo "✓ Removed $SUBMODULE/.git (content preserved)"
    fi
    
    # Remove from git cache without deleting files (--cached keeps working tree)
    git rm --cached "$SUBMODULE" 2>/dev/null || true
    echo "✓ Removed $SUBMODULE from git cache (files preserved)"
    
    # Handle .gitmodules
    if [ -f ".gitmodules" ]; then
        # Remove submodule section from .gitmodules
        if grep -q "\[submodule \"$SUBMODULE\"\]" .gitmodules; then
            # Use sed to remove the submodule section (typically 3 lines)
            sed -i.bak "/\[submodule \"$SUBMODULE\"\]/,+2d" .gitmodules
            rm -f .gitmodules.bak
            
            # If .gitmodules is now empty or only has whitespace, remove it
            if [ ! -s .gitmodules ] || [ -z "$(grep -v '^[[:space:]]*$' .gitmodules)" ]; then
                rm -f .gitmodules
                git rm -f .gitmodules 2>/dev/null || true
                echo "✓ Removed empty .gitmodules"
            else
                echo "✓ Updated .gitmodules"
            fi
        fi
    fi
    
    # Remove from .git/modules if exists
    if [ -d ".git/modules/$SUBMODULE" ]; then
        rm -rf ".git/modules/$SUBMODULE"
        echo "✓ Removed .git/modules/$SUBMODULE"
    fi
    
    # Remove from .git/config
    git config --remove-section "submodule.$SUBMODULE" 2>/dev/null || true
    
    # Add the directory back as regular folder with all its content
    git add "$SUBMODULE"
    echo "✓ Added $SUBMODULE as regular folder with all content"
    
    # Clean up backup if everything went well
    echo "🗑️  Removing backup (original content is safe)..."
    rm -rf "${SUBMODULE}.backup."*
    
    echo ""
    echo "✅ Successfully converted $SUBMODULE to a regular folder!"
    echo "   All content has been preserved."
    echo ""
    echo "📝 Next steps:"
    echo "  1. Review changes: git status"
    echo "  2. Commit changes: git commit -m \"Convert $SUBMODULE from submodule to regular folder\""

# Convert chromext from git submodule to regular folder (shortcut)
detach-chromext:
    @just detach-submodule chromext

# Development container management
container:
    cuti container

# Install cuti tool
install-cuti:
    uv tool install cuti

# Clone repository with submodules
clone-with-submodules URL:
    git clone --recurse-submodules {{URL}}

# Initialize/update submodules (if already cloned)
submodule-init:
    git submodule update --init --recursive

# Update chromext submodule to latest version
update-chromext:
    #!/usr/bin/env bash
    set -euo pipefail
    cd chromext
    git pull origin main
    cd ..
    git add chromext
    echo "✓ Updated chromext submodule"
    echo "📝 Next step: git commit -m 'Update chromext submodule to latest version'"

# List all available commands
default:
    @just --list