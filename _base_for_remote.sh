BASH_HELPERS_BASE_DIR_PATH=$(dirname ${BASH_SOURCE})/

BASH_HELPERS_SOURCED_SCRIPTS_LIST=(
    '_base.sh              _base.sh'
    '_inc_colors.sh        _inc_colors.sh'
    '_inc_io.sh            _inc_io.sh'
    '_inc_tool_files.sh    _inc_tool_files.sh'
    '_inc_tool_check.sh    _inc_tool_check.sh'
    '_inc_tool_vendor.sh   _inc_tool_vendor.sh'
    '_inc_tool_sql.sh      _inc_tool_sql.sh'
    '_inc_notify.sh        _inc_notify.sh'
    '_inc_git.sh           _inc_git.sh'
    '_inc_www.sh           _inc_www.sh'
    '_inc_s3.sh            _inc_s3.sh'
    '_inc_ftp.sh           _inc_ftp.sh'
)

for i in "${!BASH_HELPERS_SOURCED_SCRIPTS_LIST[@]}"; do
    if [[ "$i" > 0 ]]; then
        file_info=(${BASH_HELPERS_SOURCED_SCRIPTS_LIST[$i]})
        local_file_name=${file_info[0]}
        source ${BASH_HELPERS_BASE_DIR_PATH}${local_file_name}
    fi
done
