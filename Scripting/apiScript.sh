FOLDER=movie-analyst-api
echo '=======> update apt'
sudo apt-get update
echo '=======> install node, npm, git'
sudo apt-get install -y nodejs npm git
echo '=======> install pm2'
sudo npm install pm2 -g
echo '=======>'
pm2 ls
if [ "$(pm2 id api_movie)"="[]" ]; then
    if test -d "$FOLDER"; then
        echo '=======> repository already download'
    else
        echo '=======> download repository'
        git clone https://github.com/juan-ruiz/movie-analyst-api.git
    fi
    cd "$FOLDER"
    npm i
    pm2 start "server.js" -n "api_movie"
    /usr/local/bin/pm2 startup systemd -u ${USER} --hp ${HOME}
    sudo env PATH=$PATH:/usr/bin /usr/local/bin/pm2 startup systemd -u ${USER} --hp ${HOME}
    /usr/local/bin/pm2 save 
else
    echo '=======> Service already up'
fi