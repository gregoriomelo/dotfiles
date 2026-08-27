# Homebrew
$env.HOMEBREW_PREFIX = '/opt/homebrew'
$env.HOMEBREW_CELLAR = '/opt/homebrew/Cellar'
$env.HOMEBREW_REPOSITORY = '/opt/homebrew'
$env.PATH = ($env.PATH | split row (char esep)
    | prepend '/opt/homebrew/sbin'
    | prepend '/opt/homebrew/bin'
    | prepend ($env.HOME | path join '.opencode' 'bin')
    | uniq)

# Custom dirs referenced in aliases
$env.DEV_HOME = ($env.HOME | path join 'dev')
$env.DOTFILES_HOME = ($env.HOME | path join 'dev' 'dotfiles')

# Proton Pass CLI
$env.PROTON_PASS_KEY_PROVIDER = 'fs'

# ai
$env.OPENSPEC_TELEMETRY = '0'
if ($env.CONTEXT7_API_KEY? | is-empty) {
    let dotfiles_env = ($env.DOTFILES_HOME? | default ($env.HOME | path join 'dev' 'dotfiles') | path join '.env')
    let home_env = ($env.HOME | path join '.env')
    let env_file = if ($dotfiles_env | path exists) {
        $dotfiles_env
    } else if ($home_env | path exists) {
        $home_env
    } else {
        null
    }

    let file_key = if ($env_file != null) {
        let lines = (open $env_file | lines | each { str trim | str replace -r '^export\s+' '' } | where ($it | str starts-with 'CONTEXT7_API_KEY='))
        if ($lines | is-not-empty) {
            $lines | first | parse "CONTEXT7_API_KEY={val}" | get 0?.val? | default "" | str trim -c '"' | str trim -c "'"
        } else {
            ""
        }
    } else {
        ""
    }

    if ($file_key | is-not-empty) {
        $env.CONTEXT7_API_KEY = $file_key
    } else if (which pass-cli | is-not-empty) {
        let res = (do { pass-cli item view "pass://Personal/Context7/password" } | complete)
        if $res.exit_code == 0 {
            $env.CONTEXT7_API_KEY = ($res.stdout | str trim)
        } else {
            $env.CONTEXT7_API_KEY = ""
        }
    } else {
        $env.CONTEXT7_API_KEY = ""
    }
}

# gpg
$env.GPG_TTY = (try { tty } catch { "" })
