#!/usr/bin/env bash
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Wrapper around iverilog binary. Adds the path to the dependencies to
# the command line of iverilog.

set -eu

iverilog_path="$(find . -name iverilog-bin | head -n 1)"
if [ "$iverilog_path" == "" ]; then
  iverilog_path="$(command -v iverilog-bin)"
fi

dir=$(dirname "$iverilog_path")

if [[ ! -d "$dir" ]]; then
  echo "Unable to find dependencies (looking under $dir)." 1>&2
  exit 1
fi

exec "$dir/iverilog-bin" -B"$dir" -DIVERILOG "$@"
