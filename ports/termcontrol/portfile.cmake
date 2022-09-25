vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO fbdtemme/termcontrol
  REF 24657ed0d323ad8cc30186f959a67b374ba2890d
  SHA512 8f24d06da9d001acbfcdebb7902ff037fe30609a9925a33197e3fc656da633e8bacfdecf347af6238a2b5f5bf066f209f3423c76a40a8e7d330214a6a6f91e09
  HEAD_REF use-vcpkg
)


vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DTERMCONTROL_BUILD_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
  PACKAGE_NAME termcontrol
  CONFIG_PATH lib/cmake/termcontrol
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)