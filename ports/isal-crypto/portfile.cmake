vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO intel/isa-l_crypto
    REF 6e62643df9ed6c2c62e287d14f192057189dda8d
    SHA512 c7b12f22d510bf1009c2abe905690589b9f67fc1211ecea36744eab4a10e81e7f421bd43b734fa5f6d1646f76007f061c72b9ec1598a328fd098f370ed6af802
    HEAD_REF master
)

if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64" OR VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    vcpkg_find_acquire_program(NASM)
    get_filename_component(NASM_PATH "${NASM}" DIRECTORY)
    vcpkg_add_to_path("${NASM_PATH}")
endif()

if (VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
    if (VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
        set(NMAKE_TARGET dll)
    else()
        set(NMAKE_TARGET static)
    endif()

    vcpkg_build_nmake(
        SOURCE_PATH "${SOURCE_PATH}"
        PROJECT_NAME Makefile.nmake
        TARGET ${NMAKE_TARGET}
        OPTIONS
            CFLAGS_REL=
    )

    if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        set(NMAKE_BINARY_DIR "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
        if (VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
            file(INSTALL "${NMAKE_BINARY_DIR}/isa-l_crypto.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin")
            file(INSTALL "${NMAKE_BINARY_DIR}/isa-l_crypto.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
        else()
            file(INSTALL "${NMAKE_BINARY_DIR}/isa-l_crypto_static.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
        endif()
    endif()

    if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        set(NMAKE_BINARY_DIR "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
        if (VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
            file(INSTALL "${NMAKE_BINARY_DIR}/isa-l_crypto.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/bin")
            file(INSTALL "${NMAKE_BINARY_DIR}/isa-l_crypto.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
        else()
            file(INSTALL "${NMAKE_BINARY_DIR}/isa-l_crypto_static.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
        endif()
    endif()

    file(GLOB ISAL_HDRS "${SOURCE_PATH}/include/*")
    file(INSTALL ${ISAL_HDRS} DESTINATION "${CURRENT_PACKAGES_DIR}/include/isal_crypto")
    file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/isa-l_crypto.def" DESTINATION "${CURRENT_PACKAGES_DIR}/include/isal_crypto")

elseif (VCPKG_TARGET_IS_WINDOWS AND VCPKG_TARGET_IS_MINGW)
    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64" OR VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
        vcpkg_find_acquire_program(YASM)
        get_filename_component(YASM_PATH "${NASM}" DIRECTORY)
        vcpkg_add_to_path("${YASM_PATH}")
    endif()

else()
    vcpkg_configure_make(
        SOURCE_PATH "${SOURCE_PATH}"
        AUTOCONFIG
    )
    vcpkg_install_make()
    vcpkg_fixup_pkgconfig()
    
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
endif()

configure_file("${CMAKE_CURRENT_LIST_DIR}/unofficial-isal-crypto-config.cmake" "${CURRENT_PACKAGES_DIR}/share/unofficial-isal-crypto/unofficial-isal-crypto-config.cmake" @ONLY)
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
