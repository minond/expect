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

pretty_output=$(./expect "${test_file}_"* -o pretty --no-color)
tap_output=$(./expect "${test_file}_"* -o tap)
error_output=$(./expect "invalid does not exists")
help_output=$(./expect -h)

check_output() {
    local label="$1"
    local expected_output_file="$2"
    local test_run_output_str="$3"

    if ! test "$(cat "$expected_output_file")" = "$test_run_output_str"; then
        echo "$label output looks broken!!"
        exit 1
    else
        echo "$label output looks good"
    fi
}

check_output tap "test/outputs/tap-output.txt" "$tap_output"
check_output pretty "test/outputs/pretty-output.txt" "$pretty_output"
check_output error "test/outputs/error-output.txt" "$error_output"
check_output help "test/outputs/help-output.txt" "$help_output"
