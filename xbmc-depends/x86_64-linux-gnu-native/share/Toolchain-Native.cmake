set(NATIVEPREFIX "/home/sven/easytv-64/xbmc-depends/x86_64-linux-gnu-native")

set(TARBALL_DIR "/opt/xbmc-tarballs")

set(OS "linux")
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(CPU "x86_64")
set(ARCH_DEFINES -DTARGET_POSIX -DTARGET_LINUX)

if(OS STREQUAL linux)
  set(CMAKE_SYSTEM_NAME Linux)
elseif(OS STREQUAL osx)
  set(CMAKE_SYSTEM_NAME Darwin)
endif()

if(CMAKE_SYSTEM_NAME STREQUAL Darwin)
  if(CPU STREQUAL "arm")
    set(CPU arm64)
  endif()
  if(CPU STREQUAL arm64)
    set(CMAKE_OSX_DEPLOYMENT_TARGET 11.0)
  else()
    set(CMAKE_OSX_DEPLOYMENT_TARGET 10.14)
  endif()

  set(CMAKE_OSX_SYSROOT "")
endif()
set(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
set(CMAKE_C_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)
set(CMAKE_AR /usr/bin/ar CACHE FILEPATH "Archiver")
SET(CMAKE_AS /usr/bin/as CACHE FILEPATH "Assembler")
set(CMAKE_LINKER /usr/bin/ld CACHE FILEPATH "Linker")
set(CMAKE_NM /usr/bin/nm CACHE FILEPATH "Nm")
set(CMAKE_STRIP /usr/bin/strip CACHE PATH "strip binary" FORCE)
set(CMAKE_OBJDUMP /usr/bin/objdump CACHE FILEPATH "Objdump")
set(CMAKE_RANLIB /usr/bin/ranlib CACHE FILEPATH "Ranlib")

if(NOT "yes" STREQUAL "")
  set(CMAKE_CXX_COMPILER_LAUNCHER /usr/bin/ccache)
  set(CMAKE_C_COMPILER_LAUNCHER /usr/bin/ccache)
endif()

set(CMAKE_C_FLAGS " -I/home/sven/easytv-64/xbmc-depends/x86_64-linux-gnu-native/include")
set(CMAKE_CXX_FLAGS "  -I/home/sven/easytv-64/xbmc-depends/x86_64-linux-gnu-native/include")
set(CMAKE_EXE_LINKER_FLAGS " -L/home/sven/easytv-64/xbmc-depends/x86_64-linux-gnu-native/lib")

# where is the target environment
set(CMAKE_FIND_ROOT_PATH /home/sven/easytv-64/xbmc-depends/x86_64-linux-gnu-native)
set(CMAKE_LIBRARY_PATH /home/sven/easytv-64/xbmc-depends/x86_64-linux-gnu-native/lib)
if(NOT "/home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64" STREQUAL "")
  list(APPEND CMAKE_FIND_ROOT_PATH /home/sven/android-tools/android-sdk-linux/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64)
endif()
if(NOT "" STREQUAL "")
  list(APPEND CMAKE_FIND_ROOT_PATH  /usr)
endif()

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_FRAMEWORK LAST)

set(ENV{PATH} "${NATIVEPREFIX}/bin:$ENV{PATH}")
