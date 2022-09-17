vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO fbdtemme/termcontrol
  REF 891a5891d915be024d1b926a594c1ad0c5cd6eb7
  SHA512 77c44f32d01bf6215e7c0d574836c6a863e0dc432a7e4cfa46c21107fd4388a47f6fef3e0a0d1915795d754aa7ec6904769534aabcbb636cefc50a18a61422ad
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