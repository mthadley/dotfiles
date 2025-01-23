# nix
begin
    set -l nix_default_profile /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    if test -e $source
        source $nix_default_profile
    end
end

# Add nix and others to path
fish_add_path "$HOME/.cargo/bin" "$HOME/.local/bin"
