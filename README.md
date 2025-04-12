# Rclone Easy User's Home

A simple Bash automation script that makes it easier to use **rclone** to copy or sync common user directories (`/home/$USER`), such as:

- `Documents/`
- `Downloads/`
- `Pictures/`
- `Music/`
- `Desktop/`
- `Directory/`

---

## Requirements

- Linux (script written in Bash)
- [rclone](https://rclone.org/) installed and configured     **IMPORTANT**

---

## Usage

1. Clone this repository or copy the `sync-home.sh` file:

```bash
git clone https://github.com/anndev75/rclone-easy-home.git
cd rclone-easy-home
chmod +x sync-home.sh
```
Or just download it manually...

2. **Edit the file and replace** the `remoto` variable with the name of the remote you configured in `rclone`.

```bash
remoto="MyDrive:"  # Change this to your remote name
```

3. List your available remotes:

```bash
rclone listremotes
```

This will show the remotes you've configured using `rclone config`.

4. Run the script:

```bash
./sync-home.sh
```

5. Follow the menu to copy or sync only the folders you want.

---

## Extra

If you'd like to sync other directories:

- Edit the `directorios` variable in the script:

```bash
directorios=("Downloads" "Documents" "Pictures" "Music" "Desktop" "ISOs" "YourNewDirectory")
```

You can also change the `directorio_padre` variable to use a different root folder instead of `/home/$USER`.

---

This tool **does not configure your cloud account automatically**.
You must have at least one remote already configured.

### Installing `rclone`:

**Debian / Ubuntu:**
```bash
sudo apt install rclone
```

**Arch Linux / Manjaro:**
```bash
sudo pacman -S rclone
```

**Fedora / RHEL / CentOS:**
```bash
sudo dnf install rclone
```

### Configure `rclone`:

You can configure and add remotes to **rclone** with:

```bash
rclone config
```

And then verify them with:

```bash
rclone listremotes
```

The remote name must match the one assigned in the script (e.g., `Linux-Home:` or `MyDrive:`).

---

