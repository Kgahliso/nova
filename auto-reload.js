// Auto-reload script for development
(function() {
    'use strict';
    
    let lastCheck = Date.now();
    const CHECK_INTERVAL = 1000; // Check every 1 second
    
    function checkForUpdates() {
        fetch(window.location.href, {
            method: 'HEAD',
            cache: 'no-cache'
        })
        .then(response => {
            const modified = response.headers.get('last-modified');
            const currentTime = Date.now();
            
            // On subsequent checks, reload if the page has been modified
            if (modified && lastCheck) {
                const modifiedTime = new Date(modified).getTime();
                if (modifiedTime > lastCheck) {
                    console.log('🔄 Changes detected - reloading page...');
                    window.location.reload();
                }
            }
            
            lastCheck = currentTime;
        })
        .catch(error => {
            console.error('Auto-reload check failed:', error);
        });
    }
    
    // Start checking for updates
    setInterval(checkForUpdates, CHECK_INTERVAL);
    
    console.log('✨ Auto-reload is active - watching for file changes');
})();
