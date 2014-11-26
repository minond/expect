#!/bin/bash

test_file="test/temp_output_test_file"
trap "rm "${test_file}_"*" EXIT

for i in {1..5}; do
    cat > "${test_file}_${i}" <<-TEXT
-expect "this will be skipped" \$(echo hi)
expect "this will fail" \$(exit 1)
expect "this fill pass" \$(exit 0)
-expect "this will be skipped" \$(echo hi)
expect "this will fail" \$(exit 1)
expect "this fill pass" \$(exit 0)
TEXT
done

pretty_output=$(./expect "${test_file}_"* -o pretty)
tap_output=$(./expect "${test_file}_"* -o tap)

check_output() {
    local label="$1"
    local expected_output_file="$2"
    local test_run_output_str="$3"

    if ! test "$(cat "$expected_output_file")" = "$test_run_output_str"; then
        echo "    $(tput bold)$(tput setaf 1)✕$(tput sgr0) $(tput setaf 7)$label output does not match$(tput sgr0)"
        exit 1
    else
        echo "    $(tput bold)$(tput setaf 2)✓$(tput sgr0) $(tput setaf 7)$label output looks ok$(tput sgr0)"
    fi
}

echo
check_output tap "test/outputs/tap-output.txt" "$tap_output"
check_output pretty "test/outputs/pretty-output.txt" "$pretty_output"
echo
