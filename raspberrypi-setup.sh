#!/bin/bash
sudo apt update
sudo apt upgrade -y

echo "swapfile作成"
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

echo "日本語入力のインストール"
sudo apt install -y ibus ibus-mozc --install-recommends

echo "dockerのインストール"
sudo apt install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker $USER

echo "voltaのインストール"
curl https://get.volta.sh | bash
volta install node
volta install npm

echo "不要なパッケージの削除"
sudo apt autoremove -y

echo "inotifyの上限を設定"
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "/etc/fstabに「/swapfile none swap sw 0 0 0」を追記してください。"
echo "ログアウトしてください"
