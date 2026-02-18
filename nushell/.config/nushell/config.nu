# Starship prompt
# Generate once with: starship init nu | save -f ~/.cache/starship/init.nu
source ~/.cache/starship/init.nu

# Aliases (defined in aliases package — single place to edit)
source ~/.config/nushell/aliases.nu

# direnv
$env.config = {
    hooks: {
        env_change: {
            PWD: [{ |before, after|
                if (which direnv | is-empty) { return }
                let out = (direnv export json | str trim)
                if ($out | is-empty) or ($out == "{}") { return }
                $out | from json | load-env
            }]
        }
    }
}
