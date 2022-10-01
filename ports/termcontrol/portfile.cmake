vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO fbdtemme/termcontrol
  REF 4946d5bd4ad3a84f76b96f594e9206a479c64415
  SHA512 37f8bc31bd42993874fc176c575238f0cd4f10655b1999313e76f1f578924cfe6e3ab5c56478df1f3db8150fd24e51be7b0776bac2fb4da6e33ab9b489054902
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