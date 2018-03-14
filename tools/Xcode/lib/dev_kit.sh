#!/usr/bin/env bash
#
# My shell library.
# Create by Poplax [linjiang9999<at>gmail.com]
# Date 2018-03-12
#

#########
# Basic #
#########

# Error tip.
err() {
    local red="\033[1;31m"
    local normal="\033[0m"

    local err_text
    err_text="$1"

    echo -e "<${red}Error${normal}> ${err_text}" >&2
}

# Message tip.
message() {
    local green="\033[1;32m"
    local normal="\033[0m"

    local message_text
    message_text="$1"

    echo -e "[${green}Message${normal}] ${message_text}"
}

lx_abspath() {
    pushd . >/dev/null
    if [ -d "$1" ]; then
        cd "$1"
        dirs -l +0
    else
        cd "$(dirname "$1")"
        local cur_dir=$(dirs -l +0)

        if [ "${cur_dir}" == "/" ]; then
            echo "${cur_dir}$(basename "$1")"
        else
            echo "${cur_dir}/$(basename "$1")"
        fi
    fi
    popd >/dev/null
}

lx_mkdir() {
    local target_dir
    target_dir="$1"

    if [[ -z "${target_dir}" ]]; then
        err "Target dir can't be empty."
        exit -1
    fi

    if [[ ! -d "${target_dir}" ]]; then
        mkdir -p "${target_dir}"
    fi
}

# Lowcase
lx_lowcase() {
    local word
    word="$1"

    echo "${word}" | tr '[:upper:]' '[:lower:]'
}

# **********************************************************************
# <--- iOS icon
declare -r DEFAULT_APPICON_NAME='iTunesArtwork'
declare -r DEFAULT_ICON_EXTENSION='.png'

# Make image.
lx_make_image() {
    local size
    local input_file
    local output_dir
    local filename="default_file${DEFAULT_ICON_EXTENSION}"

    size="$1"
    input_file="$2"
    output_dir="$3"

    if [[ "$#" -ge 4 ]]; then
        filename="$4"
    fi

    if [[ "${size}" -lt 10 || "${size}" -gt 2048 ]]; then
        err "Out of image size, min = 10, max = 2048."
        exit -1
    fi

    local output_file="${output_dir}/${filename}"
    if convert "${input_file}" -resize ${size} "${output_file}"; then
        message "Created ${output_file}"
    fi
}

# Make iOS icons.
lx_make_ios_icons() {
    local origin_file
    local output_dir

    origin_file="$1"
    output_dir="$2"

    # Sizes value
    local app_store_1x="1024"
    lx_make_image "${app_store_1x}" "${origin_file}" "${output_dir}" "${DEFAULT_APPICON_NAME}${DEFAULT_ICON_EXTENSION}"

    local suffix

    local iphone_3x="20 29 40 60"
    for m_size in ${iphone_3x}; do
        suffix=''
        for i in {1..3}; do
            [[ $i -gt 1 ]] && suffix="@${i}x"
            lx_make_image "$((${m_size} * ${i}))" "${origin_file}" "${output_dir}" "iphone_${m_size}${suffix}${DEFAULT_ICON_EXTENSION}"
        done
    done

    local ipad_2x="20 29 40 76"
    for m_size in ${ipad_2x}; do
        suffix=''
        for i in {1..2}; do
            [[ $i -gt 1 ]] && suffix="@${i}x"
            lx_make_image "$((${m_size} * ${i}))" "${origin_file}" "${output_dir}" "ipad_${m_size}${suffix}${DEFAULT_ICON_EXTENSION}"
        done
    done

    # iPad Pro
    local ipad_pro_size="167"
    lx_make_image "${ipad_pro_size}" "${origin_file}" "${output_dir}" "ipad_pro_${ipad_pro_size}${DEFAULT_ICON_EXTENSION}"

}

lx_make_ios_config() {
    local config_file='Contents.json'

    local output_dir
    output_dir="$1"

    cat <<CONFIG_IOS >"${output_dir}/${config_file}"
{
  "images" : [
    {
      "size" : "20x20",
      "idiom" : "iphone",
      "filename" : "iphone_20@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "20x20",
      "idiom" : "iphone",
      "filename" : "iphone_20@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "iphone_29@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "iphone_29@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "40x40",
      "idiom" : "iphone",
      "filename" : "iphone_40@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "40x40",
      "idiom" : "iphone",
      "filename" : "iphone_40@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "60x60",
      "idiom" : "iphone",
      "filename" : "iphone_60@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "60x60",
      "idiom" : "iphone",
      "filename" : "iphone_60@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "20x20",
      "idiom" : "ipad",
      "filename" : "ipad_20.png",
      "scale" : "1x"
    },
    {
      "size" : "20x20",
      "idiom" : "ipad",
      "filename" : "ipad_20@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "ipad",
      "filename" : "ipad_29.png",
      "scale" : "1x"
    },
    {
      "size" : "29x29",
      "idiom" : "ipad",
      "filename" : "ipad_29@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "40x40",
      "idiom" : "ipad",
      "filename" : "ipad_40.png",
      "scale" : "1x"
    },
    {
      "size" : "40x40",
      "idiom" : "ipad",
      "filename" : "ipad_40@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "76x76",
      "idiom" : "ipad",
      "filename" : "ipad_76.png",
      "scale" : "1x"
    },
    {
      "size" : "76x76",
      "idiom" : "ipad",
      "filename" : "ipad_76@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "83.5x83.5",
      "idiom" : "ipad",
      "filename" : "ipad_pro_167.png",
      "scale" : "2x"
    },
    {
      "size" : "1024x1024",
      "idiom" : "ios-marketing",
      "filename" : "iTunesArtwork.png",
      "scale" : "1x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}
CONFIG_IOS
}
# iOS icon END. --->
