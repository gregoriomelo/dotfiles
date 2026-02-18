# Homebrew
$env.HOMEBREW_PREFIX = '/opt/homebrew'
$env.HOMEBREW_CELLAR = '/opt/homebrew/Cellar'
$env.HOMEBREW_REPOSITORY = '/opt/homebrew'
$env.PATH = ($env.PATH | split row (char esep)
    | prepend '/opt/homebrew/sbin'
    | prepend '/opt/homebrew/bin'
    | prepend '/Users/gregoriomelo/.opencode/bin'
    | uniq)

# Custom dirs referenced in aliases
$env.DEV_HOME = '/Users/gregoriomelo/dev'
$env.DOTFILES_HOME = '/Users/gregoriomelo/dev/dotfiles'
