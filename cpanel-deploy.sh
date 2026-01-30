#!/bin/bash

#==============================================================================
# Nova Energy - cPanel Deployment Preparation Script
# Version: 1.0
# Description: Prepares the website for cPanel deployment by creating a clean
#              production-ready package with automatic ZIP compression
#==============================================================================

set -e  # Exit on error

#------------------------------------------------------------------------------
# Configuration
#------------------------------------------------------------------------------
readonly DEPLOY_DIR="cpanel-deploy"
readonly ZIP_FILE="novaenergy-cpanel-$(date +%Y%m%d-%H%M%S).zip"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Color codes for output
readonly COLOR_RESET="\033[0m"
readonly COLOR_GREEN="\033[0;32m"
readonly COLOR_BLUE="\033[0;34m"
readonly COLOR_YELLOW="\033[1;33m"
readonly COLOR_RED="\033[0;31m"

# Files and directories to copy
readonly FILES_TO_COPY=(
    "404.html"
    "index.html"
    "robots.txt"
    "sitemap.xml"
    ".htaccess"
)

readonly DIRS_TO_COPY=(
    "assets"
    "api"
    "blog"
    "pages"
    "pricing"
    "projects"
    "services"
    "includes"
)

#------------------------------------------------------------------------------
# Helper Functions
#------------------------------------------------------------------------------

# Print colored output
print_info() {
    echo -e "${COLOR_BLUE}ℹ ${1}${COLOR_RESET}"
}

print_success() {
    echo -e "${COLOR_GREEN}✓ ${1}${COLOR_RESET}"
}

print_warning() {
    echo -e "${COLOR_YELLOW}⚠ ${1}${COLOR_RESET}"
}

print_error() {
    echo -e "${COLOR_RED}✗ ${1}${COLOR_RESET}"
}

print_header() {
    echo ""
    echo -e "${COLOR_BLUE}================================================${COLOR_RESET}"
    echo -e "${COLOR_BLUE}${1}${COLOR_RESET}"
    echo -e "${COLOR_BLUE}================================================${COLOR_RESET}"
    echo ""
}

# Check if required files exist
validate_files() {
    local missing_files=0
    
    for file in "${FILES_TO_COPY[@]}"; do
        if [[ ! -f "$file" ]]; then
            print_error "Required file not found: $file"
            ((missing_files++))
        fi
    done
    
    for dir in "${DIRS_TO_COPY[@]}"; do
        if [[ ! -d "$dir" ]]; then
            print_error "Required directory not found: $dir"
            ((missing_files++))
        fi
    done
    
    if [[ $missing_files -gt 0 ]]; then
        print_error "Missing $missing_files required files/directories"
        return 1
    fi
    
    return 0
}

# Create deployment directory
create_deploy_directory() {
    print_info "Creating deployment directory: $DEPLOY_DIR"
    
    if [[ -d "$DEPLOY_DIR" ]]; then
        print_warning "Removing existing deployment directory..."
        rm -rf "$DEPLOY_DIR"
    fi
    
    mkdir -p "$DEPLOY_DIR"
    print_success "Deployment directory created"
}

# Copy files to deployment directory
copy_files() {
    print_info "Copying website files..."
    
    local total_items=$((${#FILES_TO_COPY[@]} + ${#DIRS_TO_COPY[@]}))
    local current=0
    
    # Copy root files
    for file in "${FILES_TO_COPY[@]}"; do
        ((current++))
        if [[ -f "$file" ]]; then
            cp "$file" "$DEPLOY_DIR/" 2>/dev/null || {
                print_warning "Failed to copy: $file"
                continue
            }
            echo -ne "  Progress: [$current/$total_items] Copying: $file\r"
        fi
    done
    
    # Copy directories
    for dir in "${DIRS_TO_COPY[@]}"; do
        ((current++))
        if [[ -d "$dir" ]]; then
            cp -r "$dir" "$DEPLOY_DIR/" 2>/dev/null || {
                print_warning "Failed to copy: $dir"
                continue
            }
            echo -ne "  Progress: [$current/$total_items] Copying: $dir/\r"
        fi
    done
    
    echo ""  # New line after progress
    print_success "All files copied successfully"
}

# Clean up unnecessary files
cleanup_files() {
    print_info "Cleaning deployment directory..."
    
    local removed_count=0
    
    # Remove .DS_Store files
    while IFS= read -r -d '' file; do
        rm -f "$file"
        ((removed_count++))
    done < <(find "$DEPLOY_DIR" -name ".DS_Store" -print0 2>/dev/null)
    
    # Remove .map files
    while IFS= read -r -d '' file; do
        rm -f "$file"
        ((removed_count++))
    done < <(find "$DEPLOY_DIR" -name "*.map" -print0 2>/dev/null)
    
    # Remove .gitkeep files
    while IFS= read -r -d '' file; do
        rm -f "$file"
        ((removed_count++))
    done < <(find "$DEPLOY_DIR" -name ".gitkeep" -print0 2>/dev/null)
    
    print_success "Removed $removed_count unnecessary files"
}

# Calculate directory size
get_directory_size() {
    local size
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        size=$(du -sh "$1" | cut -f1)
    else
        # Linux
        size=$(du -sh "$1" | cut -f1)
    fi
    echo "$size"
}

# Create ZIP archive
create_zip() {
    print_info "Creating ZIP archive..."
    
    if command -v zip &> /dev/null; then
        cd "$(dirname "$DEPLOY_DIR")"
        zip -r "$ZIP_FILE" "$(basename "$DEPLOY_DIR")" > /dev/null 2>&1
        cd - > /dev/null
        
        if [[ -f "$ZIP_FILE" ]]; then
            local zip_size=$(get_directory_size "$ZIP_FILE")
            print_success "ZIP archive created: $ZIP_FILE ($zip_size)"
            return 0
        else
            print_warning "ZIP creation failed, but deployment folder is ready"
            return 1
        fi
    else
        print_warning "ZIP command not found. Please compress '$DEPLOY_DIR' manually"
        return 1
    fi
}

# Display deployment summary
display_summary() {
    local deploy_size=$(get_directory_size "$DEPLOY_DIR")
    
    print_header "Deployment Package Ready!"
    
    echo -e "${COLOR_GREEN}📦 Package Information:${COLOR_RESET}"
    echo "   Deployment folder: $DEPLOY_DIR/ ($deploy_size)"
    
    if [[ -f "$ZIP_FILE" ]]; then
        local zip_size=$(get_directory_size "$ZIP_FILE")
        echo "   ZIP archive: $ZIP_FILE ($zip_size)"
    fi
    
    echo ""
    echo -e "${COLOR_YELLOW}📋 Next Steps:${COLOR_RESET}"
    echo "   1. Log into your cPanel account"
    echo "   2. Navigate to: File Manager > public_html"
    
    if [[ -f "$ZIP_FILE" ]]; then
        echo "   3. Upload: $ZIP_FILE"
        echo "   4. Extract the ZIP file in public_html"
    else
        echo "   3. Upload all files from: $DEPLOY_DIR/"
    fi
    
    echo "   5. Set permissions: folders=755, files=644"
    echo "   6. Verify PHP mail() function is enabled"
    echo "   7. Test website: https://yourdomain.com"
    echo "   8. Test contact form and newsletter subscription"
    echo ""
    echo -e "${COLOR_BLUE}📖 Documentation:${COLOR_RESET}"
    echo "   Full guide: CPANEL_CHECKLIST.md"
    echo "   Troubleshooting: docs/CPANEL_DEPLOYMENT.md"
    echo ""
}

#------------------------------------------------------------------------------
# Main Execution
#------------------------------------------------------------------------------

main() {
    print_header "Nova Energy - cPanel Deployment"
    
    # Validation
    print_info "Validating project files..."
    if ! validate_files; then
        print_error "Validation failed. Please ensure all required files exist."
        exit 1
    fi
    print_success "All required files found"
    echo ""
    
    # Create deployment package
    create_deploy_directory
    copy_files
    cleanup_files
    echo ""
    
    # Create ZIP archive
    create_zip
    echo ""
    
    # Display summary
    display_summary
    
    print_success "Deployment preparation completed!"
}

# Run main function
main "$@"
