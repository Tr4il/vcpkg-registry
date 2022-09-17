vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO fbdtemme/dottorrent
  REF 4488d3e63b97bbcad392147e46c88587d83a1bc3
  SHA512 38ff25bb063925264dbd7e7d7722b976e89b42d79af6afcfa6af707428a0d2f31fbc7c7c6b4771b2bf41f473758813ba4f66ab4bf172768c1e551325fdd14b2f
  HEAD_REF dev
)


vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        isal   DOTTORRENT_USE_ISAL_CRYPTO
)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    ${FEATURE_OPTIONS}
    -DDOTTORRENT_BUILD_TESTS=OFF
    -DDOTTORRENT_CRYPTO_LIB="openssl"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
  PACKAGE_NAME dottorrent
  CONFIG_PATH lib/cmake/dottorrent
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)