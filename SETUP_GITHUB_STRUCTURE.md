# GitHub Repository Setup Guide
## AirBnB Clone Project Organization

---

## 🎯 **Goal Structure**

```
GitHub Organization: airbnbclone
│
├── AirBnB-CLONE-PROJECT/          # Main application repository
│   ├── backend/
│   ├── frontend/
│   ├── docker/
│   └── README.md
│
└── alx-airbnb-database/           # Database design repository
    ├── ERD/
    ├── normalization.md
    ├── database-script-0x01/
    ├── database-script-0x02/
    └── README.md
```

---

## 📝 **Step-by-Step Setup**

### **Step 1: Create GitHub Repositories**

#### Option A: Using GitHub Website

1. Go to https://github.com/new
2. Create **first repository:**
   - Repository name: `alx-airbnb-database`
   - Description: `Database design, normalization, and schema for AirBnB Clone`
   - Visibility: Public
   - ❌ **DO NOT** initialize with README (we have our own)
   - Click **"Create repository"**

3. Create **second repository:**
   - Repository name: `AirBnB-CLONE-PROJECT`
   - Description: `AirBnB Clone - Full-stack vacation rental platform`
   - Visibility: Public
   - ✅ Initialize with README (optional)
   - Click **"Create repository"**

#### Option B: Using GitHub CLI (if installed)

```bash
# Create alx-airbnb-database repository
gh repo create alx-airbnb-database --public --description "Database design, normalization, and schema for AirBnB Clone"

# Create main application repository
gh repo create AirBnB-CLONE-PROJECT --public --description "AirBnB Clone - Full-stack vacation rental platform"
```

---

### **Step 2: Set Up alx-airbnb-database (Today's Work)**

#### Method A: Automated Setup (Recommended)

```powershell
# Run the setup script from current directory
cd C:\Users\USER\Desktop\PROJECTS\AirBnB-Clone-project\AirBnB-Clone-project
.\setup-database-repo.ps1
```

#### Method B: Manual Setup

```powershell
# Create new directory for database repo
cd C:\Users\USER\Desktop\PROJECTS
mkdir alx-airbnb-database
cd alx-airbnb-database

# Initialize git
git init
git branch -M main

# Copy files from current project
$source = "C:\Users\USER\Desktop\PROJECTS\AirBnB-Clone-project\AirBnB-Clone-project"

# Copy directories
Copy-Item "$source\ERD" -Destination . -Recurse
Copy-Item "$source\database-script-0x01" -Destination . -Recurse
Copy-Item "$source\database-script-0x02" -Destination . -Recurse

# Copy files
Copy-Item "$source\normalization.md" -Destination .
Copy-Item "$source\.gitignore" -Destination .
Copy-Item "$source\database-repo-README.md" -Destination .\README.md
```

---

### **Step 3: Commit and Push Database Repository**

```bash
# Make sure you're in the alx-airbnb-database directory
cd C:\Users\USER\Desktop\PROJECTS\alx-airbnb-database

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: AirBnB Clone database design

- Add Entity-Relationship Diagram (ERD)
- Include normalization analysis (3NF compliant)
- Provide SQL DDL schema scripts
- Include sample data seeding scripts
- Add comprehensive documentation"

# Add GitHub remote (replace YOUR_USERNAME with your actual GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/alx-airbnb-database.git

# Push to GitHub
git push -u origin main
```

---

### **Step 4: Verify GitHub Repository**

1. Go to `https://github.com/YOUR_USERNAME/alx-airbnb-database`
2. You should see:
   - README.md displaying properly
   - ERD/ directory with diagram files
   - normalization.md file
   - database-script-0x01/ directory
   - database-script-0x02/ directory
   - .gitignore file

3. Click on `ERD/erd_mermaid_diagram.md` - the Mermaid diagram should render automatically on GitHub!

---

### **Step 5: Set Up Main Application Repository (Future)**

```bash
# Create directory for main application
cd C:\Users\USER\Desktop\PROJECTS
mkdir AirBnB-CLONE-PROJECT
cd AirBnB-CLONE-PROJECT

# Initialize git
git init
git branch -M main

# Create basic structure
mkdir backend frontend docker docs

# Create README
echo "# AirBnB Clone Project" > README.md
echo "" >> README.md
echo "Full-stack vacation rental platform" >> README.md

# Add and commit
git add .
git commit -m "Initial commit: Project structure"

# Add remote and push
git remote add origin https://github.com/YOUR_USERNAME/AirBnB-CLONE-PROJECT.git
git push -u origin main
```

---

## 🔗 **Linking Repositories**

### Update Main Application README

Add this section to `AirBnB-CLONE-PROJECT/README.md`:

```markdown
## Related Repositories

- **Database Design:** [alx-airbnb-database](https://github.com/YOUR_USERNAME/alx-airbnb-database)
  - Entity-Relationship Diagrams
  - Normalization analysis
  - SQL schema scripts
  - Sample data
```

### Update Database README

The database README already includes:

```markdown
## Related Repositories

- **Main Application:** [AirBnB-CLONE-PROJECT](https://github.com/YOUR_USERNAME/AirBnB-CLONE-PROJECT)
- **Database Design:** [alx-airbnb-database](https://github.com/YOUR_USERNAME/alx-airbnb-database)
```

---

## 📋 **Post-Setup Checklist**

### alx-airbnb-database Repository

- [ ] Repository created on GitHub
- [ ] Files copied from current project
- [ ] Git initialized locally
- [ ] Initial commit created
- [ ] Remote added
- [ ] Pushed to GitHub
- [ ] README displays correctly on GitHub
- [ ] Mermaid ERD renders on GitHub
- [ ] Repository description set
- [ ] Repository topics added (database, sql, erd, normalization)

### AirBnB-CLONE-PROJECT Repository

- [ ] Repository created on GitHub
- [ ] Directory structure created
- [ ] README with project overview
- [ ] Link to database repository added
- [ ] Pushed to GitHub

---

## 🔄 **Working with Both Repositories**

### Daily Workflow

```bash
# Work on database changes
cd C:\Users\USER\Desktop\PROJECTS\alx-airbnb-database
git checkout -b feature/new-database-feature
# Make changes...
git add .
git commit -m "feat(schema): add new feature"
git push origin feature/new-database-feature

# Work on application
cd C:\Users\USER\Desktop\PROJECTS\AirBnB-CLONE-PROJECT
git checkout -b feature/new-app-feature
# Make changes...
git add .
git commit -m "feat(backend): implement new feature"
git push origin feature/new-app-feature
```

### Keeping Repositories in Sync

When database schema changes:

1. Update `alx-airbnb-database` repository
2. Create migration scripts if needed
3. Update main application to use new schema
4. Reference database version/commit in application

---

## 🎨 **GitHub Repository Settings**

### For Both Repositories

1. **Add Topics:**
   - alx-airbnb-database: `database`, `sql`, `postgresql`, `mysql`, `erd`, `normalization`, `airbnb-clone`
   - AirBnB-CLONE-PROJECT: `django`, `react`, `postgresql`, `airbnb-clone`, `vacation-rental`

2. **Add Description:**
   - alx-airbnb-database: "Database design, normalization, and schema for AirBnB Clone"
   - AirBnB-CLONE-PROJECT: "AirBnB Clone - Full-stack vacation rental platform"

3. **Enable Issues:** ✅ (for both)

4. **Enable Wiki:** Optional

5. **Set Repository Social Preview:**
   - Go to Settings → General → Social Preview
   - Upload a relevant image (optional)

---

## 📊 **Repository Structure Comparison**

### Before (Current State)

```
AirBnB-Clone-project/
└── AirBnB-Clone-project/
    ├── ERD/
    ├── normalization.md
    ├── database-script-0x01/
    ├── database-script-0x02/
    └── README.md
```

### After (Organized Structure)

```
GitHub Account/
├── alx-airbnb-database/           ← Database work (today's work)
│   ├── ERD/
│   ├── normalization.md
│   ├── database-script-0x01/
│   ├── database-script-0x02/
│   └── README.md
│
└── AirBnB-CLONE-PROJECT/          ← Main application (future work)
    ├── backend/
    ├── frontend/
    ├── docker/
    └── README.md
```

---

## 🚨 **Common Issues and Solutions**

### Issue 1: "Remote already exists"

```bash
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/alx-airbnb-database.git
```

### Issue 2: "Permission denied (publickey)"

```bash
# Use HTTPS instead of SSH
git remote set-url origin https://github.com/YOUR_USERNAME/alx-airbnb-database.git

# Or set up SSH keys: https://docs.github.com/en/authentication/connecting-to-github-with-ssh
```

### Issue 3: "Files not copying correctly"

```powershell
# Verify source files exist
Get-ChildItem "C:\Users\USER\Desktop\PROJECTS\AirBnB-Clone-project\AirBnB-Clone-project"

# Run setup script with verbose output
.\setup-database-repo.ps1 -Verbose
```

### Issue 4: "Push rejected"

```bash
# Pull first if repository was initialized with README
git pull origin main --allow-unrelated-histories

# Then push
git push -u origin main
```

---

## ✅ **Verification Commands**

```bash
# Check git status
git status

# Check remote
git remote -v

# Check branch
git branch

# View commit history
git log --oneline

# Check GitHub connection
git ls-remote origin
```

---

## 📞 **Getting Help**

If you encounter issues:

1. Check git status: `git status`
2. Check remote configuration: `git remote -v`
3. Verify GitHub repository exists
4. Ensure correct username in URLs
5. Check internet connection

---

## 🎉 **Success Criteria**

You've successfully set up the repositories when:

✅ Both repositories exist on GitHub  
✅ alx-airbnb-database has all today's work  
✅ README displays correctly on GitHub  
✅ Mermaid ERD renders automatically  
✅ All files are committed and pushed  
✅ Repository links work correctly  
✅ Topics and descriptions are set  

---

**Ready to organize your GitHub repositories! Follow the steps above and you'll have a clean, professional structure.** 🚀

