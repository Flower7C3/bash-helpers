###############################################################
### GIT
###############################################################

function email_to_hash() {
    if (hash "md5" 2>/dev/null); then
        # shellcheck disable=SC2021
        echo -n "$1" | tr '[A-Z]' '[a-z]' | md5
    elif (hash "md5sum" 2>/dev/null); then
        echo -n "$1" | md5sum | cut -d ' ' -f 1
    else
        echo -n "undefined"
    fi
}

function gravatar_url() {
    local email=$1
    local size=${2:-'256'}
    local fallback=${3:-'identicon'}
    local HASH
    HASH=$(email_to_hash "$email")
    local URL="http://www.gravatar.com/avatar/${HASH}?s=${size}&d=${fallback}"
    echo -n "$URL"
}

function git_current() {
    current_repo_url=$(git config --get remote.origin.url)
    current_repo_web_url=$(echo -n "$current_repo_url" | sed -e 's/\(.*\)@\(.*\)\:\(.*\)\.git/http:\/\/\2\/\3/')
    current_branch_name=$(git rev-parse --abbrev-ref HEAD)
    current_commit_id=$(git rev-parse --verify HEAD)
    current_commit_message=$(git --no-pager log -1 --pretty=format:"%B")
    current_commit_time=$(git --no-pager log -1 --pretty=format:"%ct")
    current_commit_datetime=$(git --no-pager log -1 --pretty='format:%cd')
    current_commit_author_name=$(git --no-pager log -1 --pretty=format:"%an")
    current_commit_author_email=$(git --no-pager log -1 --pretty=format:"%ae")
    current_commit_author_gravatar=$(gravatar_url "$current_commit_author_email" 80)

    printf "${COLOR_INFO_B}Git current commit hash is ${COLOR_INFO_H}%s${COLOR_INFO_B}${COLOR_OFF}\n" "$current_commit_id"
}

function git_fetch() {
    # shellcheck disable=SC2059
    printf "${COLOR_INFO_B}Git fetch data from upstream${COLOR_OFF}\n"
    git fetch
}

function git_fetch_tags() {
    # shellcheck disable=SC2059
    printf "${COLOR_INFO_B}Git fetch data and tags from upstream${COLOR_OFF}\n"
    git fetch --tags
}

function git_checkout() {
    local branch=${1:-master}

    printf "${COLOR_INFO_B}Git checkout to ${COLOR_INFO_H}%s${COLOR_INFO_B}${COLOR_OFF}\n" "${branch}"
    git checkout "$branch"
}

function git_revert_changes() {
    # shellcheck disable=SC2059
    printf "${COLOR_INFO_B}Git revert changes${COLOR_OFF}\n"
    git checkout -- .
}

function git_pull() {
    local branch=${1:-master}

    git_current

    printf "${COLOR_INFO_B}Git pull ${COLOR_INFO_H}%s${COLOR_INFO_B} branch from origin${COLOR_OFF}\n" "${branch}"
    git pull origin "$branch"
}
