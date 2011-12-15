cmake_minimum_required (VERSION 2.8)
cmake_policy (SET CMP0015 OLD)

set (CMAKE_BUILD_TYPE "" CACHE STRING "")

project (VIMRC)
set (VIMRC_VERSION_MAJOR 1)
set (VIMRC_VERSION_MINOR 0)

set (VIMRC_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/etc/vim/")

# Copy files with 644 permissions
install(FILES vimrc.custom
    DESTINATION ${VIMRC_INSTALL_DIR})

