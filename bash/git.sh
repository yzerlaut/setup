# ---------- GIT
alias gca='git commit -a -m'
alias gps='git push origin'
alias gpl='git pull origin'
alias gpsm='git push origin main'
alias gplm='git pull origin main'


gcp() {
    git commit -a -m "$1"
    git push
}

