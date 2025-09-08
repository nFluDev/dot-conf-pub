# --- GIT Temel Aliaslar ---
function gcm() {
  git clone "https://github.com/nFluDev/$1"
}
function gcu() {
  if [ -z "$2" ]; then
    git clone "https://github.com/$1"
  else
    git clone "https://github.com/$1/$2"
  fi
}
alias gc='git clone'
alias g='git'
alias ga='git add .'
alias gcom='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gs='git status -sb'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gm='git merge'

# --- GitHub CLI aliasları ---
alias ghc='gh auth login'                     # GitHub giriş
alias ghp='gh repo create --public --source=. --remote=origin --push'  # Repo oluşturup push et
alias ghppriv='gh repo create --private --source=. --remote=origin --push'  # Repo oluşturup push et
alias ghf='gh repo fork --clone'              # Repo forkla ve klonla
alias ghs='gh repo sync --push'                # Fork'u upstream ile güncelle ve push et
alias ghl='gh repo list'                       # Repo listesini göster
alias ghv='gh repo view --web'                 # Repo sayfasını webde aç
alias ghd='gh repo delete --yes'                     # Repo sil (onay sorar)

# --- Yeni proje başlatmak için hızlı alias ---
alias gitstart='git init && git add . && git commit -m "Initial commit" && gh repo create --public --source=. --remote=origin --push'
alias gitstartpriv='git init && git add . && git commit -m "Initial commit" && gh repo create --private --source=. --remote=origin --push'

# --- Güncelleme aliasları ---
alias gitup='git pull && git fetch'
alias gitpush='git add . && git commit -m "update" && git push'

# ----------------------------------------------------------------
# brew install sonrası yapılandırmaları ~/.zshrc'ye otomatik ekle (v2)
# ----------------------------------------------------------------
brew() {
  # Gerçek brew komutunu tüm argümanlarla çalıştır
  command brew "$@"

  # Sadece 'install' veya 'upgrade' komutlarından sonra devam et
  if [[ "$1" == "install" || "$1" == "upgrade" ]]; then
    # Komuttan sonraki tüm paket isimlerini al
    local packages=("${@:2}")

    if [ ${#packages[@]} -eq 0 ]; then
      return
    fi

    for package in $packages; do
      # Paketin "Caveats" (notlar/uyarılar) bölümünü al
      local caveats
      caveats=$(command brew info "$package" | sed -n '/Caveats/,$p' | sed '1d')

      if [[ -n "$caveats" ]]; then
        echo "-> Otomatik yapılandırma kontrol ediliyor: $package"

        # === DÜZELTME BURADA ===
        # Anahtar kelime aramak yerine, BAŞINDA BOŞLUK OLAN tüm satırları al.
        # Homebrew genellikle eklenecek kodları bu şekilde formatlar.
        local commands_to_add
        commands_to_add=$(echo "$caveats" | grep '^[[:space:]]\+')

        if [[ -n "$commands_to_add" ]]; then
          echo "$commands_to_add" | while IFS= read -r line; do
            # Baştaki ve sondaki boşlukları temizle
            local clean_line
            clean_line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

            if [[ -z "$clean_line" ]]; then continue; fi

            # Eğer temizlenmiş satır zaten ~/.zshrc içinde yoksa ekle
            if ! grep -qF -- "$clean_line" ~/.zshrc; then
              echo "   ✅ Ekleniyor: $clean_line"
              echo "\n# Homebrew Wrapper tarafından $package için eklendi" >> ~/.zshrc
              echo "$clean_line" >> ~/.zshrc
            else
              echo "   ↪️  Zaten mevcut: $clean_line"
            fi
          done
        else
          echo "   -> Eklenecek bir yapılandırma komutu bulunamadı."
        fi
      fi
    done
  fi
}

# Homebrew Wrapper tarafından nvm için eklendi
mkdir ~/.nvm

# Homebrew Wrapper tarafından nvm için eklendi
export NVM_DIR="$HOME/.nvm"

# Homebrew Wrapper tarafından nvm için eklendi
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# Homebrew Wrapper tarafından nvm için eklendi
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Oh My Posh Theme
eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/nFluDev/omp/refs/heads/main/bubbles.omp.json)"

clear