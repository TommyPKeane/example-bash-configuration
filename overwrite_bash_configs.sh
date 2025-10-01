#!/usr/bin/env bash
# bash Setup Script to Overwrite the Current User's bash Configurations
#
# ⚠️🚨
# This repo has my preferred configurations, and you may not want all these same
#	configurations, or your environment may have built-in configurations that you don't
#	want to just wholesale override. So you should only run this script if you've
#	checked your current configuration and compared to the setup here, and it all makes
#	sense.
#
# You could always fork/clone this repo and make overrides to the configuration files
#	to suite your own needs, as well. So feel free to do that! 😄🤓
# ⚠️🚨
#
# References:
#   - https://github.com/TommyPKeane/example-bash-configuration

set -eu


# Bash Configs Overwrite
echo "💾 Overwriting bash Configuration Files..."
cp -Rv ./.bashrc.d/ ~/.bashrc.d
cp -v ./.bashrc ~/
cp -v ./.bash_profile ~/


# Update current Shell without needing to close Terminal
source ~/.bashrc
