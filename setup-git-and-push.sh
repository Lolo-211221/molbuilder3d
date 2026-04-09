#!/bin/bash
# Run this in Terminal.app (not inside Cursor): double-click won't work — open Terminal, then:
#   cd "/Users/lorenzohoussier/Desktop/coding/Chem molbuilder3d"
#   chmod +x setup-git-and-push.sh
#   ./setup-git-and-push.sh

set -e
cd "$(dirname "$0")"

echo "== MolBuilder 3D — Git setup =="
echo ""

if ! command -v git &>/dev/null; then
  echo "Install Xcode Command Line Tools: xcode-select --install"
  exit 1
fi

# One-time identity (skip if already set)
if [[ -z "$(git config user.email 2>/dev/null)" ]]; then
  echo "Git needs your name and email (shown on commits). Example:"
  echo '  git config --global user.name "Your Name"'
  echo '  git config --global user.email "you@example.com"'
  echo ""
  read -r -p "Enter your name for Git commits: " GIT_NAME
  read -r -p "Enter your email (same as GitHub is fine): " GIT_EMAIL
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
  echo "Saved global git identity."
fi

if [[ -d .git ]]; then
  echo "Already a git repo (.git exists). Skipping git init."
else
  git init
  git branch -M main
fi

git add molecule-builder.html netlify.toml .gitignore setup-git-and-push.sh
git status
git commit -m "Initial commit: MolBuilder 3D" || { echo "Nothing new to commit (already committed)."; }

echo ""
echo "== Next: create an empty repo on GitHub (no README), then run: =="
echo ""
echo "  git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
echo "  git push -u origin main"
echo ""
echo "If GitHub CLI is installed: gh auth login && gh repo create molbuilder3d --public --source=. --remote=origin --push"
echo ""
echo "Then in Netlify: Site → Build & deploy → Link repository → pick this repo."
