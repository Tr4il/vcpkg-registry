

if(NOT TARGET unofficial::isal-crypto::isal-crypto)
    add_library(unofficial::isal-crypto::isal-crypto UNKNOWN IMPORTED)
    get_filename_component(z_vcpkg_isal_crypto_prefix "${CMAKE_CURRENT_LIST_FILE}" PATH)
    get_filename_component(z_vcpkg_isal_crypto_prefix "${z_vcpkg_isal_crypto_prefix}" PATH)
    get_filename_component(z_vcpkg_isal_crypto_prefix "${z_vcpkg_isal_crypto_prefix}" PATH)
    find_library(Z_VCPKG_isal_crypto_LIBRARY_RELEASE NAMES isal_crypto isa-l_crypto_static isa-l_crypto PATHS "${z_vcpkg_isal_crypto_prefix}/lib" NO_DEFAULT_PATH REQUIRED)
    set_target_properties(unofficial::isal-crypto::isal-crypto PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${z_vcpkg_isal_crypto_prefix}/include"
        IMPORTED_CONFIGURATIONS RELEASE
        IMPORTED_LOCATION_RELEASE "${Z_VCPKG_isal_crypto_LIBRARY_RELEASE}"
    )
    if("@VCPKG_BUILD_TYPE@" STREQUAL "")
        find_library(Z_VCPKG_isal_crypto_LIBRARY_DEBUG NAMES isal_crypto isa-l_crypto_static isa-l_crypto PATHS "${z_vcpkg_isal_crypto_prefix}/debug/lib" NO_DEFAULT_PATH REQUIRED)
        set_property(TARGET unofficial::isal-crypto::isal-crypto APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(unofficial::isal-crypto::isal-crypto PROPERTIES IMPORTED_LOCATION_DEBUG "${Z_VCPKG_isal_crypto_LIBRARY_DEBUG}")
    endif()
    unset(z_vcpkg_isal_crypto_prefix)
endif()