vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO fbdtemme/cliprogress
  REF 2eac24940cd0e07ac914cc4b76a38108bfb578a7
  SHA512 432ed6cda6d65bfd57a5ec9e5f402e4c3d15daf5d4451bf10575961033fcb3456b0fb3720b364f6c6d8ba199a217575a778fa087fcb15f960a325ea33990bfc7
  HEAD_REF dev
)


vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DCLIPROGRESS_BUILD_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
  PACKAGE_NAME cliprogress
  CONFIG_PATH lib/cmake/cliprogress
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)