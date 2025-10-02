#!/bin/bash

# Adim 1: Homebrew'u kur.
echo "1. Homebrew kurulumu basliyor..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Adim 2: GitHub'dan .zshrc dosyasini indir.
echo "2. .zshrc dosyasini indiriyorum..."
curl -o ~/.zshrc https://raw.githubusercontent.com/nFluDev/dot-conf-pub/main/Developer-s-PC/.zshrc

# Adim 3: ZSH shell'ini guncelle.
echo "3. ZSH ayarlarini guncelliyorum..."
source ~/.zshrc

# Adim 4: NVM (Node Version Manager) ve en son LTS Node.js surumunu kur.
echo "4. NVM ve en son LTS Node.js surumunu kuruyorum..."
brew install nvm
source ~/.zshrc
nvm install --lts

# Adim 5: Oh My Posh'u ve Meslo fontunu kur.
echo "5. Oh My Posh ve Meslo fontunu kuruyorum..."
brew install oh-my-posh
oh-my-posh font install Meslo

# Adim 6: GitHub CLI (gh) kurulumu ve giris islemi.
echo "6. GitHub CLI (gh) kurup giris yapiyorum..."
brew install gh
gh auth login

# Adim 7: Grafik arayuzlu uygulamalari kur.
echo "7. Visual Studio Code ve Warp Terminal'i kuruyorum..."
brew install --cask visual-studio-code
brew install --cask warp

# Adim 8: Son guncellemeyi yap.
echo "8. Son guncelleme icin ZSH shell'ini yeniden baslatiyorum..."
source ~/.zshrc

# Adim 9: PM2 global paketini kur.
echo "9. PM2 global paketini kuruyorum..."
npm install -g pm2

echo "Kurulum otomasyonu tamamlandi. Hayirli olsun!"
