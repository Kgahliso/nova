/**
 * Dynamic Footer Loader
 * Loads the footer HTML from includes/footer.html and injects it into the page
 */

(function() {
  'use strict';

  // Function to calculate the correct path to the footer based on current page location
  function getFooterPath() {
    const path = window.location.pathname;
    const depth = (path.match(/\//g) || []).length - 1;
    
    // Calculate relative path based on directory depth
    let prefix = '';
    if (depth === 1) {
      prefix = './';
    } else if (depth === 2) {
      prefix = '../';
    } else if (depth >= 3) {
      prefix = '../../';
    }
    
    return prefix + 'includes/footer.html';
  }

  // Load footer when DOM is ready
  function loadFooter() {
    const footerPlaceholder = document.getElementById('footer-placeholder');
    
    if (!footerPlaceholder) {
      console.error('Footer placeholder not found. Add <div id="footer-placeholder"></div> to your HTML.');
      return;
    }

    const footerPath = getFooterPath();

    fetch(footerPath)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.text();
      })
      .then(html => {
        footerPlaceholder.innerHTML = html;
        
        // Re-initialize any form validation or scripts that need to run after footer is loaded
        if (typeof window.initializeSubscribeForm === 'function') {
          window.initializeSubscribeForm();
        }
      })
      .catch(error => {
        console.error('Error loading footer:', error);
        footerPlaceholder.innerHTML = '<footer class="footer"><div class="b-container py-4"><p class="text-center">Footer could not be loaded.</p></div></footer>';
      });
  }

  // Load footer when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', loadFooter);
  } else {
    loadFooter();
  }
})();
