#!/bin/bash

# Script to update all HTML pages with dynamic footer placeholder

echo "Updating all HTML pages to use dynamic footer..."

# Array of all HTML files to update (excluding footer.html itself and 404/live-reload)
declare -a pages=(
  "pages/about-us.html"
  "pages/careers.html"
  "pages/contact-us.html"
  "pages/faq.html"
  "pages/our-expertise.html"
  "pages/testimonials.html"
  "services/index.html"
  "services/details.html"
  "pricing/index.html"
  "projects/index.html"
  "projects/details.html"
  "blog/index.html"
  "blog/post.html"
)

for page in "${pages[@]}"; do
  if [ -f "$page" ]; then
    echo "Processing: $page"
    
    # Check if page already has footer-placeholder
    if grep -q 'id="footer-placeholder"' "$page"; then
      echo "  ✓ Already updated"
    else
      # Check if page has footer section
      if grep -q '<footer class="footer' "$page"; then
        echo "  → Needs manual update (has footer)"
      else
        echo "  ⚠ No footer found"
      fi
    fi
  else
    echo "  ✗ File not found: $page"
  fi
done

echo ""
echo "Manual steps needed:"
echo "1. Replace <footer>...</footer> with <div id=\"footer-placeholder\"></div>"
echo "2. Add <script src=\"../assets/js/load-footer.js\"></script> before closing body tag"
echo "   (Note: Use correct relative path based on file location)"
