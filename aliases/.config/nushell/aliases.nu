# Navigation
alias dev      = cd $env.DEV_HOME
alias dotfiles = cd $env.DOTFILES_HOME

# General (ls omitted — nushell built-in ls is preferred)
alias h = history
alias v = vim

# Search history (structured data in nushell, not text)
def hg [pattern: string] {
    history | where command =~ $pattern
}

# git
alias g    = git
alias gpom = git push origin main

def gpb [] {
    let branch = (git branch | lines
        | where { |l| $l | str starts-with '*' }
        | first | str trim | str replace '* ' '')
    git push origin $branch
}

# docker-compose
alias dcu  = docker-compose up
alias dcud = docker-compose up -d
alias dcr  = docker-compose run
alias dcb  = docker-compose build
alias dcs  = docker-compose stop
alias dce  = docker-compose exec
alias dcrw = docker-compose run web

def dcrwb [] { docker-compose run web bundle }

def dccu [] {
    docker-compose stop
    docker-compose rm --force
    docker-compose up -d
}

# brew
def brewup [] {
    brew update
    brew upgrade
    brew cleanup --prune=all
}

# http server
def http_server [port?: int] {
    python -m SimpleHTTPServer $port
}
