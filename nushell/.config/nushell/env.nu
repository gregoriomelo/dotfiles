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

# Proton Pass CLI
$env.PROTON_PASS_KEY_PROVIDER = 'fs'

# ai
$env.OPENSPEC_TELEMETRY = '0'
if ($env.CONTEXT7_API_KEY? | is-empty) {
    $env.CONTEXT7_API_KEY = (try { pass-cli item view "pass://Personal/Context7/password" | str trim } catch { "" })
}

# gpg
$env.GPG_TTY = (try { tty } catch { "" })
