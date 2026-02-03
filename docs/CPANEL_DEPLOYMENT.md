# cPanel Deployment Guide

## Nova Energy Invest - Deployment Steps for cPanel

### Prerequisites
- cPanel hosting account
- FTP credentials or File Manager access
- Domain name configured

---

## Method 1: File Manager Upload (Recommended for beginners)

### Step 1: Prepare Files for Upload
1. Exclude development files:
   - Delete `node_modules/` folder (not needed on server)
   - Remove `.git/` folder (optional, for security)
   - Keep all other files and folders

### Step 2: Access cPanel File Manager
1. Log into your cPanel account
2. Navigate to **Files** → **File Manager**
3. Go to `public_html` directory (or your domain's root folder)

### Step 3: Upload Files
1. Click **Upload** button in File Manager
2. Select and upload these folders/files:
   ```
   ✓ 404.html
   ✓ index.html
   ✓ robots.txt
   ✓ sitemap.xml
   ✓ assets/         (entire folder)
   ✓ api/            (entire folder)
   ✓ blog/           (entire folder)
   ✓ pages/          (entire folder)
   ✓ pricing/        (entire folder)
   ✓ projects/       (entire folder)
   ✓ services/       (entire folder)
   ✓ .htaccess       (if created)
   ```

3. **DO NOT upload:**
   - node_modules/
   - .git/
   - .gitignore
   - package.json
   - package-lock.json
   - .env.example
   - docs/

### Step 4: Verify File Structure
Your `public_html` should look like:
```
public_html/
├── index.html
├── 404.html
├── robots.txt
├── sitemap.xml
├── assets/
│   ├── css/
│   ├── js/
│   ├── images/
│   └── favicon.ico
├── api/
├── blog/
├── pages/
├── pricing/
├── projects/
└── services/
```

---

## Method 2: FTP Upload (Recommended for large sites)

### Step 1: Get FTP Credentials
1. In cPanel, go to **Files** → **FTP Accounts**
2. Use existing FTP account or create new one
3. Note down:
   - FTP Server: `ftp.yourdomain.com`
   - Username: `your-username`
   - Password: `your-password`
   - Port: `21`

### Step 2: Connect via FTP Client
1. Download FTP client (FileZilla, Cyberduck, etc.)
2. Create new connection with your credentials
3. Connect to server

### Step 3: Upload Files
1. Navigate to `public_html` on server (right panel)
2. Select all files/folders from your local project
3. Right-click → **Upload**
4. Wait for transfer to complete

---

## Method 3: Git Deployment (Advanced)

### Step 1: Enable SSH Access
1. In cPanel, go to **Security** → **SSH Access**
2. Enable SSH if available
3. Note SSH details

### Step 2: Connect via SSH
```bash
ssh username@yourdomain.com
```

### Step 3: Clone Repository
```bash
cd public_html
git clone https://github.com/Kgahliso/nova.git .
```

### Step 4: Clean Up
```bash
rm -rf .git node_modules docs
```

---

## Post-Deployment Configuration

### 1. Create .htaccess File
Create `.htaccess` in your `public_html` directory with this content:

```apache
# Enable Rewrite Engine
RewriteEngine On

# Force HTTPS (Optional but recommended)
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# Remove .html extension
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_FILENAME}.html -f
RewriteRule ^(.*)$ $1.html [L]

# Custom 404 Error Page
ErrorDocument 404 /404.html

# Protect sensitive files
<FilesMatch "^\.">
    Require all denied
</FilesMatch>

# Enable Compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript
</IfModule>

# Browser Caching
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType text/html "access plus 1 hour"
</IfModule>

# Security Headers
<IfModule mod_headers.c>
    Header set X-Content-Type-Options "nosniff"
    Header set X-Frame-Options "SAMEORIGIN"
    Header set X-XSS-Protection "1; mode=block"
</IfModule>
```

### 2. Set File Permissions
In File Manager or via FTP:
- Directories: `755` (rwxr-xr-x)
- Files: `644` (rw-r--r--)
- PHP files in api/: `644` (rw-r--r--)

To set via SSH:
```bash
cd public_html
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
```

### 3. Configure Email (for contact form)
1. Go to cPanel **Email Accounts**
2. Create email: `info@novaenergyinvest.co.za`
3. Update `api/form-processor.php` with correct email

### 4. Test PHP Email Functionality
1. Navigate to **cPanel** → **MultiPHP Manager**
2. Ensure PHP version is 7.4 or higher
3. Test contact form submissions

### 5. Update Sitemap
Edit `sitemap.xml` and replace `www.novaenergyinvest.co.za` with your actual domain name

---

## Domain Configuration

### For Main Domain
Files go directly in `public_html/`

### For Subdomain
1. In cPanel, go to **Domains** → **Subdomains**
2. Create subdomain (e.g., `nova.yourdomain.com`)
3. Upload files to the subdomain folder
4. Update all paths if needed

### For Addon Domain
1. In cPanel, go to **Domains** → **Addon Domains**
2. Add your domain
3. Upload files to the addon domain folder

---

## Verification Checklist

After deployment, verify:

- [ ] Homepage loads: `https://yourdomain.com`
- [ ] All images display correctly
- [ ] Navigation links work
- [ ] CSS styles applied
- [ ] JavaScript functions work
- [ ] Forms submit properly
- [ ] 404 page displays for invalid URLs
- [ ] Mobile responsive design works
- [ ] All pages accessible:
  - [ ] /pages/about-us.html
  - [ ] /pages/contact-us.html
  - [ ] /services/
  - [ ] /projects/
  - [ ] /blog/
  - [ ] /pricing/

---

## Troubleshooting

### Images Not Displaying
- Check file paths are correct
- Verify images uploaded to `assets/images/`
- Check file permissions (should be 644)

### CSS Not Loading
- Check `assets/css/` folder uploaded
- Verify file permissions
- Clear browser cache

### Contact Form Not Working
- Check PHP version (7.4+)
- Verify email configured in cPanel
- Test `api/form-processor.php` exists
- Check mail() function enabled

### 404 Errors
- Verify `.htaccess` file created
- Check mod_rewrite enabled in cPanel
- Ensure file names match (case-sensitive)

### SSL Certificate Issues
- In cPanel, go to **Security** → **SSL/TLS Status**
- Install Let's Encrypt certificate (free)
- Force HTTPS in .htaccess

---

## Performance Optimization

### 1. Enable Gzip Compression
Already included in .htaccess above

### 2. Optimize Images
Before uploading, compress images:
- Use TinyPNG, ImageOptim, or similar
- Target: < 200KB per image

### 3. Enable CloudFlare (Optional)
1. Sign up at cloudflare.com
2. Add your domain
3. Update nameservers in domain registrar
4. Benefits: CDN, DDoS protection, caching

### 4. Enable Browser Caching
Already included in .htaccess above

---

## Maintenance

### Regular Updates
1. Update content locally
2. Test changes
3. Upload modified files via FTP/File Manager
4. Clear browser cache and test

### Backups
1. In cPanel → **Backup Wizard**
2. Create full backup monthly
3. Download and store safely

### Security
1. Keep cPanel password strong
2. Regular security scans
3. Monitor error logs
4. Update PHP version as needed

---

## Quick Deployment Script (SSH)

If you have SSH access, save this as `deploy.sh`:

```bash
#!/bin/bash
# Nova Energy Invest Deployment Script

echo "Starting deployment..."

# Navigate to web root
cd ~/public_html

# Backup current version (optional)
if [ -d "backup" ]; then
    rm -rf backup
fi
mkdir backup
cp -r * backup/ 2>/dev/null

# Pull latest changes (if using git)
# git pull origin main

# Set correct permissions
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;

# Remove development files
rm -rf node_modules .git .gitignore package.json package-lock.json

echo "Deployment complete!"
echo "Visit your site to verify: https://yourdomain.com"
```

Make executable: `chmod +x deploy.sh`
Run: `./deploy.sh`

---

## Support Resources

- **cPanel Documentation**: https://docs.cpanel.net/
- **FileZilla Guide**: https://filezilla-project.org/
- **Let's Encrypt SSL**: https://letsencrypt.org/

---

## Contact

For deployment assistance:
- Email: info@novaenergyinvest.co.za
- Repository: https://github.com/Kgahliso/nova

---

**Last Updated**: January 24, 2026
