#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="linapple"
rp_module_desc="Apple 2 emulator LinApple"
rp_module_help="ROM Extensions: .dsk\n\nCopy your Apple 2 games to $romdir/apple2"
rp_module_licence="GPL2 https://raw.githubusercontent.com/Arthy000/linapple/master/COPYING.txt"
rp_module_repo="git https://github.com/Arthy000/linapple.git master"
rp_module_section="opt"
rp_module_flags="sdl1 !mali"

function depends_linapple() {
    getDepends git libzip-dev libsdl1.2-dev libsdl-image1.2-dev libcurl4-openssl-dev zlib1g-dev imagemagick
}

function sources_linapple() {
    gitPullOrClone
}

function build_linapple() {
    make
    md_ret_require="$md_build/build/bin/linapple"
}

function install_linapple() {
    md_ret_files=(
        'CHANGELOG'
        'INSTALL.md'
        'COPYING.txt'
        'build/bin/linapple'
        'res/linapple.conf'
        'res/Master.dsk'
        'README.md'
    )
}

function configure_linapple() {
    mkRomDir "apple2"

    addEmulator 1 "$md_id" "apple2" "$md_inst/linapple.sh --conf %ROM%"
    addSystem "apple2"

    [[ "$md_mode" == "remove" ]] && return

    # copy default config/disk if user doesn't have them installed
    local file
    for file in Master.dsk linapple.conf; do
        copyDefaultConfig "$file" "$md_conf_root/apple2/$file"
    done

    isPlatform "dispmanx" && setBackend "$md_id" "dispmanx"
    ! isPlatform "dispmanx" && isPlatform "kms" && setBackend "$md_id" "sdl12-compat"

    mkUserDir "$md_conf_root/apple2"
    moveConfigDir "$home/.linapple" "$md_conf_root/apple2"

    local file="$md_inst/linapple.sh"
    cat >"$file" << _EOF_
#!/bin/bash
pushd "$romdir/apple2"
$md_inst/linapple "\$@"
popd
_EOF_
    chmod +x "$file"
}
