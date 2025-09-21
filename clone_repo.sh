rm -rf sports.db
git clone --no-checkout --filter=blob:none git@github.com:Kingson4Wu/sports.db.git
cd sports.db
git sparse-checkout init --no-cone
git checkout main -- exclude_data.sh dir.txt exclude.txt
chmod +x exclude_data.sh
./exclude_data.sh



# curl -fsSL https://raw.githubusercontent.com/Kingson4Wu/sports.db/main/clone_repo.sh | bash
