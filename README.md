# bash-helpers

To use functions defined in this repo simply add it as GIT submodule of Your project `git submodule add https://github.com/Flower7C3/bash-helpers/ vendor/Flower7C3/bash-helpers/` and import in bash scripts with `source $(dirname ${BASH_SOURCE})/vendor/Flower7C3/bash-helpers/_base.sh` code.

Some ready to go implementation are in [bash-tools](https://github.com/Flower7C3/bash-helpers/) repository.

To update submodule just run `git submodule update --init --recursive` command. Consider adding this command to update process of Your program.
