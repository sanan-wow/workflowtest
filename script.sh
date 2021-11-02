GITHUBUSER=$(cat /etc/environment | grep  GITHUB_USER | cut -f2- -d=)
GITHUBPASS=$(cat /etc/environment | grep  GITHUB_PASS | cut -f2- -d=)

STT=$(curl -u "$GITHUBUSER":"$GITHUBPASS" --request POST 'https://api.github.com/orgs/woolworthslimited/actions/runners/registration-token' | grep -oP '(?<="token": ")[^"]*')

runuser -l packer -c "/home/packer/actions-runner/config.sh --url https://github.com/woolworthslimited --token "$STT" --unattended"

runuser -l packer -c "/home/packer/actions-runner/run.sh" &
