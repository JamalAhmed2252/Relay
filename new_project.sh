#!/bin/bash

echo "=============================="
echo "     Project Bootstrapper"
echo "=============================="

# Ask for project name
read -p "Enter project name: " project_name

# Create project structure
mkdir -p "$project_name/src"
mkdir -p "$project_name/tests"

# Create .env.example
cat > "$project_name/.env.example" <<EOF
PORT=3000
DATABASE_URL=
API_KEY=
EOF

# Create .gitignore
cat > "$project_name/.gitignore" <<EOF
.env
*.log
temp/
EOF

# Create README
cat > "$project_name/README.md" <<EOF
# $project_name

This project was created using Project Bootstrapper.

## Structure

- src/   - source code
- tests/ - tests
EOF

# Initialize Git
cd "$project_name"
git init

# Create commit message hook
cat > .git/hooks/commit-msg <<'EOF'
#!/bin/bash

commit_message=$(head -n 1 "$1")

if [[ "$commit_message" =~ ^(feat|fix|docs|chore): ]]; then
    exit 0
else
    echo "ERROR: Invalid commit message."
    echo "Use: feat|fix|docs|chore: your message"
    exit 1
fi
EOF

# Make hook executable
chmod +x .git/hooks/commit-msg

cd ..

echo ""
echo "Project '$project_name' created successfully!"
echo ""
echo "Next steps:"
echo "cd $project_name"
echo "git status"
echo "git add ."
echo "git commit -m \"docs: initial commit\""
