#!/bin/bash
set -e

bash ./build_it.sh

bash ./test_meteor_app.sh
bash ./test_meteor_app_with_devbuild.sh

# Disabled by @abernix.  I don't understand how this test is intended to work.
#bash ./test_bundle_local_mount.sh

# These use BUNDLE_URL
bash ./test_bundle_web.sh
bash ./test_binary_build_on_base.sh
bash ./test_binary_build_on_bin_build.sh

bash ./test_phantomjs.sh
bash ./test_no_app.sh
