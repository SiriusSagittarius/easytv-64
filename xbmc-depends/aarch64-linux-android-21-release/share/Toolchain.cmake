set(DEPENDS_PATH "/home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release")
set(NATIVEPREFIX "/home/sven/easytv-64/xbmc-depends/x86_64-linux-gnu-native")

set(TARBALL_DIR "/opt/xbmc-tarballs")

set(OS "android")
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(CPU "arm64-v8a")
set(PLATFORM "")

# set CORE_SYSTEM_NAME and CMAKE_SYSTEM_NAME (sets CMAKE_CROSSCOMPILING)
if(OS STREQUAL linux)
  set(CMAKE_SYSTEM_NAME Linux)
  set(CORE_SYSTEM_NAME linux)
  set(CORE_PLATFORM_NAME )
  set(APP_RENDER_SYSTEM  CACHE STRING "Render system to use: \"gl\" or \"gles\"")
  if(PLATFORM STREQUAL webos)
    set(TOOLCHAIN /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64)
    set(HOST aarch64-linux-android)
  endif()
elseif(OS STREQUAL android)
  set(CMAKE_SYSTEM_NAME Android)
  set(CORE_SYSTEM_NAME android)
elseif(OS STREQUAL osx)
  set(CMAKE_SYSTEM_NAME Darwin)
  set(CORE_SYSTEM_NAME osx)
elseif(OS STREQUAL darwin_embedded)
  set(CMAKE_SYSTEM_NAME Darwin)
  set(CORE_SYSTEM_NAME darwin_embedded)
  if(PLATFORM STREQUAL appletvos)
    set(CORE_PLATFORM_NAME tvos)
  else()
    set(CORE_PLATFORM_NAME ios)
  endif()
endif()

if(CORE_SYSTEM_NAME STREQUAL darwin_embedded)
  # Necessary to build the main Application (but not other dependencies)
  # with Xcode (and a bundle with Makefiles) (https://cmake.org/Bug/view.php?id=15329)
  if(NOT PROJECT_SOURCE_DIR MATCHES "tools/depends")
    message(STATUS "Toolchain enabled ${CORE_PLATFORM_NAME} bundle for project ${PROJECT_NAME}")
    set(CMAKE_MACOSX_BUNDLE YES)
    set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
    # Need to set this attribute to "" in order to
    # completely disable code signing
    # see: https://gitlab.kitware.com/cmake/cmake/issues/19112
    set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "")
    set(CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE "NO")
    if(CORE_PLATFORM_NAME STREQUAL tvos)
      set(CMAKE_XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "3")
      set(CMAKE_XCODE_ATTRIBUTE_TVOS_DEPLOYMENT_TARGET 12.0)
    else()
      set(CMAKE_XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2")
      set(CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET 11.0)
    endif()
  endif()
endif()

if(CMAKE_SYSTEM_NAME STREQUAL Darwin)
  set(CMAKE_OSX_SYSROOT /home/sven/android-tools/android-sdk-linux)
  set(CMAKE_XCODE_ATTRIBUTE_ARCHS ${CPU})
endif()
set(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
set(CMAKE_C_COMPILER /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang)
set(CMAKE_CXX_COMPILER /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang++)
set(CMAKE_AR /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar CACHE FILEPATH "Archiver")
SET(CMAKE_AS /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-as CACHE FILEPATH "Assembler")
set(CMAKE_LINKER /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/bin/ld CACHE FILEPATH "Linker")
set(CMAKE_NM /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-nm CACHE FILEPATH "Nm")
set(CMAKE_STRIP /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip CACHE PATH "strip binary" FORCE)
set(CMAKE_OBJDUMP /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-objdump CACHE FILEPATH "Objdump")
set(CMAKE_RANLIB /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ranlib CACHE FILEPATH "Ranlib")

if(NOT "yes" STREQUAL "")
  set(CMAKE_CXX_COMPILER_LAUNCHER /usr/bin/ccache)
  set(CMAKE_C_COMPILER_LAUNCHER /usr/bin/ccache)
endif()

# where is the target environment
set(CMAKE_FIND_ROOT_PATH /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release)
set(CMAKE_LIBRARY_PATH /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/lib)
if(NOT "/home/sven/android-tools/android-sdk-linux" STREQUAL "")
  list(APPEND CMAKE_FIND_ROOT_PATH /home/sven/android-tools/android-sdk-linux /home/sven/android-tools/android-sdk-linux/usr)
endif()
# Currently this is only set to reject android by default
if(NOT "/home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64" STREQUAL "")
  list(APPEND CMAKE_FIND_ROOT_PATH /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/aarch64-linux-android /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/aarch64-linux-android/sysroot /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/aarch64-linux-android/sysroot/usr /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/aarch64-linux-android/libc /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/lib/aarch64-linux-android/sysroot /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/usr /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr)
  # Explicitly set this as last. This potentially is /usr which can then cause linux
  # cross compilation to search paths that are not relevant to target arch (eg host libs)
  # x86/x86_64 jenkins CI jobs require /usr for libs like iconv
  list(APPEND CMAKE_FIND_ROOT_PATH /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64)
  set(CMAKE_LIBRARY_PATH "${CMAKE_LIBRARY_PATH}:/home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/usr/lib/aarch64-linux-android:/home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/lib/aarch64-linux-android")
endif()

# add Android directories and tools
if(CORE_SYSTEM_NAME STREQUAL android)
  set(NDKROOT /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358)
  set(SDKROOT /home/sven/android-tools/android-sdk-linux)
  set(TOOLCHAIN /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64)
  set(HOST aarch64-linux-android)
  list(APPEND CMAKE_LIBRARY_PATH ${TOOLCHAIN}/sysroot/usr/lib/${HOST}/21)
  string(REPLACE ":" ";" SDK_BUILDTOOLS_PATH "/home/sven/android-tools/android-sdk-linux/tools:/home/sven/android-tools/android-sdk-linux/platform-tools:/home/sven/android-tools/android-sdk-linux/build-tools/37.0.0")
endif()

set(CMAKE_ASM_NASM_FLAGS "")
set(CMAKE_C_FLAGS "-DANDROID -fexceptions -funwind-tables -fstack-protector-strong -no-canonical-prefixes -fPIC -DPIC -mtune=cortex-a53 -DNDEBUG=1 -Os  -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include/android-21 -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include")
set(CMAKE_CXX_FLAGS "-DANDROID -fexceptions -funwind-tables -fstack-protector-strong -no-canonical-prefixes -fPIC -DPIC -mtune=cortex-a53 -frtti -DNDEBUG=1 -Os  -std=c++17 -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include/android-21 -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include")
set(CMAKE_C_FLAGS_RELEASE "-DANDROID -fexceptions -funwind-tables -fstack-protector-strong -no-canonical-prefixes -fPIC -DPIC -mtune=cortex-a53 -DNDEBUG=1 -Os  -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include/android-21 -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include")
set(CMAKE_CXX_FLAGS_RELEASE "-DANDROID -fexceptions -funwind-tables -fstack-protector-strong -no-canonical-prefixes -fPIC -DPIC -mtune=cortex-a53 -frtti -DNDEBUG=1 -Os  -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include/android-21 -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include")
set(CMAKE_C_FLAGS_DEBUG "-DANDROID -fexceptions -funwind-tables -fstack-protector-strong -no-canonical-prefixes -fPIC -DPIC -mtune=cortex-a53 -Og -g -D_DEBUG  -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include/android-21 -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include")
set(CMAKE_CXX_FLAGS_DEBUG "-DANDROID -fexceptions -funwind-tables -fstack-protector-strong -no-canonical-prefixes -fPIC -DPIC -mtune=cortex-a53 -frtti -Og -g -D_DEBUG  -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include/android-21 -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include")
set(CMAKE_CPP_FLAGS "-DANDROID -fexceptions -funwind-tables -fstack-protector-strong -no-canonical-prefixes -fPIC -DPIC -mtune=cortex-a53 -DNDEBUG=1 -Os  -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include/android-21 -isystem /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/include")
set(CMAKE_EXE_LINKER_FLAGS "-L/home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/lib -Wl,--exclude-libs,libgcc.a -Wl,--exclude-libs,libatomic.a -L/home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/lib/android-21  ")
set(ENV{CFLAGS} ${CMAKE_C_FLAGS})
set(ENV{CXXFLAGS} ${CMAKE_CXX_FLAGS})
set(ENV{CPPFLAGS} ${CMAKE_CPP_FLAGS})
set(ENV{LDFLAGS} ${CMAKE_EXE_LINKER_FLAGS})
# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_FRAMEWORK LAST)
set(ENV{PKG_CONFIG_LIBDIR} /home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/lib/pkgconfig:/home/sven/easytv-64/xbmc-depends/aarch64-linux-android-21-release/share/pkgconfig)

# Binary Addons
if(NOT CORE_SYSTEM_NAME STREQUAL linux)
  set(ADDONS_PREFER_STATIC_LIBS ON)
endif()

# common usage in autoconf to refer to host arch tool use
set(CC_FOR_BUILD "gcc")
set(CXX_FOR_BUILD "g++")
set(LD_FOR_BUILD "/usr/bin/ld")
set(CC_BINARY_FOR_BUILD "gcc")
set(CXX_BINARY_FOR_BUILD "g++")
set(AR_FOR_BUILD "/usr/bin/ar")
set(RANLIB_FOR_BUILD "/usr/bin/ranlib")
set(AS_FOR_BUILD "/usr/bin/as")
set(NM_FOR_BUILD "/usr/bin/nm")
set(STRIP_FOR_BUILD "/usr/bin/strip")
set(READELF_FOR_BUILD "/usr/bin/readelf")
set(OBJDUMP_FOR_BUILD "/usr/bin/objdump")

# flags for host arch building
set(CFLAGS_FOR_BUILD " -I/home/sven/easytv-64/xbmc-depends/x86_64-linux-gnu-native/include")
set(LDFLAGS_FOR_BUILD " -L/home/sven/easytv-64/xbmc-depends/x86_64-linux-gnu-native/lib")

# other build tools
find_program(NASM nasm HINTS "${NATIVEPREFIX}/bin" REQUIRED)

# common autoconf build tools
find_program(AUTOCONF autoconf HINTS "${NATIVEPREFIX}/bin" REQUIRED)
find_program(ACLOCAL aclocal HINTS "${NATIVEPREFIX}/bin" REQUIRED)
find_program(AUTOHEADER autoheader HINTS "${NATIVEPREFIX}/bin" REQUIRED)
find_program(AUTOMAKE automake HINTS "${NATIVEPREFIX}/bin" REQUIRED)
find_program(AUTOM4TE autom4te HINTS "${NATIVEPREFIX}/bin" REQUIRED)
find_program(AUTOPOINT autopoint HINTS "${NATIVEPREFIX}/bin" REQUIRED)
find_program(AUTORECONF autoreconf HINTS "${NATIVEPREFIX}/bin" REQUIRED)
find_program(LIBTOOL libtool HINTS "${NATIVEPREFIX}/bin" REQUIRED)
find_program(LIBTOOLIZE libtoolize HINTS "${NATIVEPREFIX}/bin" REQUIRED)

set(ENV{ACLOCAL_PATH} "${DEPENDS_PATH}/share/aclocal:${NATIVEPREFIX}/share/aclocal")
set(ENVPATH "${NATIVEPREFIX}/bin:$ENV{PATH}")

# Dependency build tool config files
find_file(MESON-CROSS "cross-file.meson" PATHS "${DEPENDS_PATH}/share" NO_CMAKE_FIND_ROOT_PATH REQUIRED)
# autoconf config.site
find_file(CONFIG_SITE "config.site" PATHS "${DEPENDS_PATH}/share" NO_CMAKE_FIND_ROOT_PATH REQUIRED)

# Env variables for non cmake target environments
set(PROJECT_TARGETENV "AS=${CMAKE_AS}"
                      "AR=${CMAKE_AR}"
                      "CC=${CMAKE_C_COMPILER}"
                      "CXX=${CMAKE_CXX_COMPILER}"
                      "NM=${CMAKE_NM}"
                      "LD=${CMAKE_LINKER}"
                      "STRIP=${CMAKE_STRIP}"
                      "RANLIB=${CMAKE_RANLIB}"
                      "OBJDUMP=${CMAKE_OBJDUMP}"
                      "CFLAGS=${CMAKE_C_FLAGS}"
                      "CPPFLAGS=${CMAKE_CPP_FLAGS}"
                      "LDFLAGS=${CMAKE_EXE_LINKER_FLAGS}"
                      "PKG_CONFIG_LIBDIR=$ENV{PKG_CONFIG_LIBDIR}"
                      "AUTOM4TE=${AUTOM4TE}"
                      "AUTOMAKE=${AUTOMAKE}"
                      "AUTOCONF=${AUTOCONF}"
                      "AUTORECONF=${AUTORECONF}"
                      "ACLOCAL=${ACLOCAL}"
                      "ACLOCAL_PATH=$ENV{ACLOCAL_PATH}"
                      "AUTOPOINT=${AUTOPOINT}"
                      "AUTOHEADER=${AUTOHEADER}"
                      "LIBTOOL=${LIBTOOL}"
                      "LIBTOOLIZE=${LIBTOOLIZE}"
                      "CONFIG_SITE=${CONFIG_SITE}"
                      )

# Env variables for non cmake host environments
set(PROJECT_BUILDENV CC_FOR_BUILD=${CC_FOR_BUILD}
                     CXX_FOR_BUILD=${CXX_FOR_BUILD}
                     LD_FOR_BUILD=${LD_FOR_BUILD}
                     CC_BINARY_FOR_BUILD=${CC_FOR_BUILD}
                     CXX_BINARY_FOR_BUILD=${CXX_FOR_BUILD}
                     AR_FOR_BUILD=${AR_FOR_BUILD}
                     RANLIB_FOR_BUILD=${RANLIB_FOR_BUILD}
                     AS_FOR_BUILD=${AS_FOR_BUILD}
                     NM_FOR_BUILD=${NM_FOR_BUILD}
                     STRIP_FOR_BUILD=${STRIP_FOR_BUILD}
                     READELF_FOR_BUILD=${READELF_FOR_BUILD}
                     OBJDUMP_FOR_BUILD=${OBJDUMP_FOR_BUILD}
                     CFLAGS_FOR_BUILD=${CFLAGS_FOR_BUILD}
                     LDFLAGS_FOR_BUILD=${LDFLAGS_FOR_BUILD}
                     )

# variable to easily set host/target env for non cmake internal dep builds
set(DEP_BUILDENV ${CMAKE_COMMAND} -E env ${PROJECT_TARGETENV} ${PROJECT_BUILDENV})

set(KODI_DEPENDSBUILD 1)

