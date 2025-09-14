# Scaffold management commands

# Convert chromext from git submodule to regular folder
detach-chromext:
    #!/usr/bin/env bash
    set -euo pipefail
    
    echo "🔄 Converting chromext from submodule to regular folder..."
    
    # Check if chromext exists
    if [ ! -d "chromext" ]; then
        echo "❌ chromext directory not found"
        exit 1
    fi
    
    # Remove the .git file/directory from chromext
    if [ -e "chromext/.git" ]; then
        rm -rf chromext/.git
        echo "✓ Removed chromext/.git"
    fi
    
    # Remove from git cache (ignore errors if not cached)
    git rm --cached chromext 2>/dev/null || true
    echo "✓ Removed chromext from git cache"
    
    # Handle .gitmodules
    if [ -f ".gitmodules" ]; then
        # Remove chromext section from .gitmodules
        if grep -q '\[submodule "chromext"\]' .gitmodules; then
            # Use sed to remove the chromext submodule section
            sed -i.bak '/\[submodule "chromext"\]/,+2d' .gitmodules
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
    if [ -d ".git/modules/chromext" ]; then
        rm -rf .git/modules/chromext
        echo "✓ Removed .git/modules/chromext"
    fi
    
    # Add chromext as regular folder
    git add chromext
    echo "✓ Added chromext as regular folder"
    
    echo ""
    echo "✅ Successfully converted chromext to a regular folder!"
    echo ""
    echo "📝 Next steps:"
    echo "  1. Review changes: git status"
    echo "  2. Commit changes: git commit -m \"Convert chromext from submodule to regular folder\""

# List all available commands
default:
    @just --list