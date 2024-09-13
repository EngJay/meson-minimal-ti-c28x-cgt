##
# @file meson.build
# @brief Top-level Meson module for minimal C28x build example for TI F28379D.
#
# @author Jason Scott <reachme@jasonpscott.com>
# @date 2024-09-13
#
# @copyright Copyright (c) 2024
#
project(
    'minimal-ti-c28x-cgt-f2837xd',
    ['c'],
    default_options: [
        'debug=false', # Defaults to release build.
        'warning_level=3',
        'optimization=2',
        # `build.*` options affect `native: true targets`,
        # plain options affect `native: false` targets.
        'c_std=c99',
        'build.c_std=c99',
    ],
    meson_version: '>=1.4.0',
    version: '0.1.0',
)

# TI C28x C2000 CGT tools location.
# 
ti_c28x_c2000_cgt_dir = '/root/ti/cgt/ti-cgt-c2000_22.6.1.LTS'

#region FLAGS

# Build type.
#
build_is_debug = get_option('debug')
if build_is_debug
    # Specify build as debug and leave C assertions enabled.
    add_project_arguments('-DDEBUG', language: ['c'])
    add_project_arguments('-DDEBUG', language: ['c'], native: true)
else
    # Specify build as release and disable C assertions.
    add_project_arguments('-DRELEASE -DNDEBUG', language: ['c'])
    add_project_arguments('-DRELEASE -DNDEBUG', language: ['c'], native: true)
endif

c_compile_flags = [
    '--cla_support=cla1',
    '--float_support=fpu32',
    '--tmu_support=tmu0',
    '--vcu_support=vcu2',
    '--diag_suppress=10063',
    '--diag_warning=225',
    '--diag_wrap=off',
    '--display_error_number',
    '--abi=eabi', # Crucial flag that is not included in the linker rule by the Ninja backend.
    '--define=F2837xD',
    '--define=CPU1',
]

c_linker_flags = [
    '-mminimal-ti-c28x-cgt-f2837xd.map',
    '--heap_size=0x200',
    '--stack_size=0x3F8',
    '--warn_sections',
    '-i' + ti_c28x_c2000_cgt_dir / 'lib',
    '-i' + ti_c28x_c2000_cgt_dir / 'include',
    '--reread_libs',
    '--define=RAM',
    '--diag_wrap=off',
    '--display_error_number',
    '--xml_link_info=minimal_ti_c28x_cgt_f2837xd_linkInfo.xml',
    # '--entry_point=code_start',
    '--rom_model',
    '-llibc.a',
]

#endregion FLAGS

#region SOURCES

# The name of the excutable file to be created.
# 
app_executable_name = 'minimal-ti-c28x-cgt-f2837xd'

# Application and CGT include directories.
# 
app_include_dirs_arr = [
    ti_c28x_c2000_cgt_dir / 'include',
]

# Application source files.
# 
app_src_files = [
    'src' / 'main.c',
    'src' / 'F2837xD_CodeStartBranch.asm',
]

# Create objects to pass to executable target.
# 
all_app_include_dirs = include_directories(app_include_dirs_arr)
all_app_src_files = files(app_src_files)

# Linker script required for F2837xd CPU1 RAM.
# 
linker_script = meson.current_source_dir() / '2837xD_RAM_lnk_cpu1.cmd'

#endregion SOURCES

# Excutable target for the application.
# 
app_exe = executable(
    app_executable_name,
	all_app_src_files,
	include_directories: [all_app_include_dirs],
    c_args: [c_compile_flags],
	link_args: [linker_script, c_linker_flags],
)
