# cPanel Deployment Checklist

## Pre-Deployment Checklist

### ✅ Files & Folders Ready
- [ ] `.htaccess` - Server configuration file
- [ ] `404.html` - Custom error page
- [ ] `index.html` - Homepage
- [ ] `robots.txt` - SEO robots file
- [ ] `sitemap.xml` - SEO sitemap
- [ ] `assets/` - All CSS, JS, images, videos
- [ ] `api/` - PHP form processor
- [ ] `blog/` - Blog pages
- [ ] `pages/` - Static pages
- [ ] `pricing/` - Pricing pages
- [ ] `projects/` - Project pages
- [ ] `services/` - Services pages
- [ ] `includes/` - Footer and reusable components

### ✅ Configuration Updates
- [ ] Update email address in `api/form-processor.php` (currently: info@novaenergyinvest.co.za)
- [ ] Verify HTTPS redirect in `.htaccess`
- [ ] Check all internal links use relative paths
- [ ] Verify all image paths are correct

### ✅ Remove Development Files (DO NOT upload)
- [ ] `node_modules/` folder
- [ ] `.git/` folder
- [ ] `.gitignore`
- [ ] `.gitattributes`
- [ ] `package.json`
- [ ] `package-lock.json`
- [ ] `.env.example`
- [ ] `docs/` folder
- [ ] `auto-reload.js`
- [ ] `live-reload.html`
- [ ] `vercel.json`
- [ ] `update-all-footers.sh`
- [ ] `update-footer.sh`
- [ ] `cpanel-deploy.sh`
- [ ] `.vscode/` folder
- [ ] `.DS_Store` files

---

## Deployment Steps

### Option 1: Automated Script (Recommended)

```bash
# Make script executable
chmod +x cpanel-deploy.sh

# Run deployment preparation
./cpanel-deploy.sh

# This creates a 'cpanel-deploy' folder with only necessary files
# Compress this folder and upload to cPanel
```

### Option 2: Manual File Manager Upload

1. **Access cPanel**
   - Log into your cPanel account
   - Navigate to **Files** → **File Manager**
   - Go to `public_html` directory

2. **Upload Files**
   - Click **Upload** button
   - Upload all files and folders (except development files listed above)
   - Wait for upload to complete

3. **Set Permissions**
   - Set folder permissions to `755`
   - Set file permissions to `644`
   - Set `api/form-processor.php` to `644`

### Option 3: FTP Upload

1. **Get FTP Credentials**
   - cPanel → **FTP Accounts**
   - Note: Server, Username, Password, Port (usually 21)

2. **Upload via FTP Client**
   - Use FileZilla, Cyberduck, or similar
   - Connect to your server
   - Navigate to `public_html`
   - Upload all necessary files

---

## Post-Deployment Verification

### Test Checklist
- [ ] Homepage loads: `https://yourdomain.com`
- [ ] All pages accessible (About, Services, Projects, Contact, etc.)
- [ ] All images display correctly
- [ ] CSS styles load properly
- [ ] JavaScript functionality works
- [ ] Sticky navigation bar works
- [ ] Section anchor links work (#why-choose-us, #services, etc.)
- [ ] Contact form submits successfully
- [ ] Newsletter subscription works
- [ ] Mobile responsive design displays correctly
- [ ] HTTPS redirect works (HTTP → HTTPS)
- [ ] Custom 404 page displays
- [ ] No broken links

### PHP Configuration Check
- [ ] Verify PHP is enabled on server
- [ ] Check PHP version (7.4+ recommended)
- [ ] Verify `mail()` function is enabled
- [ ] Test email delivery from contact form

### Performance & SEO
- [ ] Check page load speed
- [ ] Verify robots.txt is accessible
- [ ] Verify sitemap.xml is accessible
- [ ] Test on multiple browsers (Chrome, Firefox, Safari, Edge)
- [ ] Test on mobile devices

---

## Troubleshooting Common Issues

### Contact Form Not Working
1. Check PHP is enabled in cPanel
2. Verify email address in `api/form-processor.php`
3. Check server supports `mail()` function
4. Review PHP error logs in cPanel

### 404 Errors on Pages
1. Verify `.htaccess` uploaded correctly
2. Check file permissions (644 for files, 755 for folders)
3. Ensure all HTML files are in correct directories

### Images Not Loading
1. Check image paths are relative (not absolute)
2. Verify `assets/images/` folder uploaded completely
3. Check file name case sensitivity (Linux servers are case-sensitive)

### Styles Not Applying
1. Verify `assets/css/` folder uploaded
2. Check CSS file paths in HTML
3. Clear browser cache
4. Check file permissions

### HTTPS Not Working
1. Verify SSL certificate installed in cPanel
2. Check `.htaccess` HTTPS redirect rules
3. Update mixed content (HTTP resources on HTTPS page)

---

## Server Requirements

### Minimum Requirements
- **Web Server**: Apache with mod_rewrite
- **PHP**: Version 7.4 or higher
- **PHP Extensions**: 
  - `mail()` function enabled
  - `mbstring` extension
- **Storage**: Minimum 50MB
- **Bandwidth**: Based on traffic expectations

### Recommended Settings
- PHP memory limit: 128MB or higher
- Max execution time: 30 seconds
- Upload file size: 10MB
- Enable gzip compression
- Enable browser caching

---

## Domain Configuration

### DNS Settings
If using a custom domain:
1. Point A record to your server's IP address
2. Add CNAME for www subdomain
3. Wait 24-48 hours for DNS propagation

### cPanel Domain Setup
1. Go to **Domains** in cPanel
2. Add your domain if not already added
3. Point document root to `public_html`

---

## Security Recommendations

### After Deployment
- [ ] Change default cPanel password
- [ ] Enable two-factor authentication
- [ ] Keep PHP version updated
- [ ] Regular backups (use cPanel backup tools)
- [ ] Install SSL certificate (Let's Encrypt free option)
- [ ] Monitor server logs regularly
- [ ] Set strong file permissions
- [ ] Consider Cloudflare for additional security

---

## Contact Information

**Website Email**: info@novaenergyinvest.co.za

For technical support, contact your hosting provider.

---

## Quick Deploy Command Summary

```bash
# Prepare deployment package
chmod +x cpanel-deploy.sh
./cpanel-deploy.sh

# Creates 'cpanel-deploy' folder with production files
# Compress and upload to cPanel File Manager
# Extract in public_html directory
```

---

**Last Updated**: January 30, 2026
**Version**: 1.0
