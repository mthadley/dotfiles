function swatch --description "Watch files and run a command"
    argparse 'c/cmd=?' -- $argv

    if not set -q _flag_cmd
        if test -f Makefile
            set _flag_cmd make
        else if test -f Shakefile.hs
            set _flag_cmd shake
        else if test -f rush.json
            set _flag_cmd rush build
        end

        if not set -q _flag_cmd
            echo "Unable to infer a command based on the current directory."
            echo
            echo "Try supplying the command to run with --cmd"
            return 1
        end
    end

    rg --files | entr -rc "$_flag_cmd" $argv
end
