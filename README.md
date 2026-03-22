# Dotfiles Symlink Setup (Multi-Tool)

This guide shows how to manage **multiple dotfiles** (Neovim, Zsh, Tmux, etc.) in a Git repository and link them into your home directory using symbolic links.

---

## 📁 Prerequisites

- Git installed
- Tools you want to manage (Neovim, Zsh, Tmux, etc.)
- A dotfiles repository, for example:

```bash
~/dotfiles
```

---

## 🗂️ Recommended Folder Structure

Two common patterns are shown below.

### Option A — Simple folders (manual symlinks)

```bash
~/dotfiles/
├── nvim/
├── zsh/
├── tmux/
```

### Option B — Stow-friendly (recommended for scale)

```bash
~/dotfiles/
├── nvim/.config/nvim/
├── zsh/.zshrc
├── tmux/.tmux.conf
```

---

# 🔗 Option 1: Manual Symlinks (Simple)

## 1. Remove existing configs (if needed)

⚠️ Only run if you don’t need current configs:

```bash
rm -rf ~/.config/nvim
rm -f ~/.zshrc
rm -f ~/.tmux.conf
```

---

## 2. Create symlinks

```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

---

## 3. Verify

```bash
ls -l ~
ls -l ~/.config
```

Expected example:

```bash
nvim -> /Users/<your-username>/dotfiles/nvim
.zshrc -> /Users/<your-username>/dotfiles/zsh/.zshrc
```

---

# 🚀 Option 2: GNU Stow (Recommended)

Best for managing multiple dotfiles cleanly.

---

## 1. Install Stow

```bash
brew install stow
```

---

## 2. Use Stow-friendly structure

```bash
~/dotfiles/
├── nvim/.config/nvim/
├── zsh/.zshrc
├── tmux/.tmux.conf
```

---

## 3. Apply symlinks

```bash
cd ~/dotfiles
stow nvim
stow zsh
stow tmux
```

👉 This will automatically create symlinks in the correct locations.

---

## 4. Remove symlinks

```bash
stow -D nvim
```

---

# 🧪 Test Setup

```bash
nvim
zsh
```

Ensure configurations load correctly.

---

# ⚠️ Common Issues

### ❌ File exists

```bash
ln: File exists
```

Fix:

```bash
rm -rf <target>
```

---

### ❌ Wrong symlink direction

Incorrect:

```bash
ln -s ~/.config/nvim ~/dotfiles/nvim
```

Correct:

```bash
ln -s SOURCE DESTINATION
```

---

### ❌ Broken symlink

```bash
ls -l ~/.config/nvim
```

If path is invalid → recreate symlink.

---

# 🧠 Benefits

- Centralized dotfiles management
- Easy machine setup (clone + stow)
- Clean and reproducible environment
- Works across macOS/Linux

---

# 📌 Tips

- Keep secrets out of repo (use `.gitignore`)
- Commit frequently
- Use branches for experimentation

---

Happy hacking 🚀
