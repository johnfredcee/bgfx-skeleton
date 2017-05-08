# BIMG_FOUND
# BIMG_LIBRARY: (debug, optimized) for windows
# BIMG_INCLUDE_DIR
# function: assimp_copy_binaries (win32)

if (ANDROID)    
    set(BIMG_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deps/bimg_android_arm CACHE PATH "BIMG root directory")
    set(FIND_EXTRA_FLAG NO_CMAKE_FIND_ROOT_PATH)
elseif (IOS)
    set(BIMG_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deps/bimg_ios_arm CACHE PATH "BIMG root directory")
    set(FIND_EXTRA_FLAG NO_CMAKE_FIND_ROOT_PATH)
else()
    set(BIMG_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deps/bimg CACHE PATH "BIMG root directory")
endif()

if (MSVC)
	if(CMAKE_SIZEOF_VOID_P EQUAL 8)
		set(BIMG_BUILT_DIR ${BGFX_ROOT_DIR}/.build/win64_vs2015/bin CACHE PATH "BIMG built binaries directory")
	else()
		set(BIMG_BUILT_DIR ${BGFX_ROOT_DIR}/.build/win32_vs2015/bin CACHE PATH "BIMG built binaries directory")
	endif()
endif()

# Find path of each library
find_path(BIMG_INCLUDE_DIR
	NAMES
		bimg/bimg.h
	HINTS
		${BIMG_ROOT_DIR}/include
    ${FIND_EXTRA_FLAG}
)

find_library(BIMG_LIBRARY_RELEASE BimgRelease PATHS ${BIMG_BUILT_DIR} ${FIND_EXTRA_FLAG})
find_library(BIMG_DECODE_LIBRARY_RELEASE Bimg_DecodeRelease PATHS ${BIMG_BUILT_DIR} ${FIND_EXTRA_FLAG})
find_library(BIMG_ENCODE_LIBRARY_RELEASE Bimg_EncodeRelease PATHS ${BIMG_BUILT_DIR} ${FIND_EXTRA_FLAG})
find_library(BIMG_LIBRARY_DEBUG	BimgDebug PATHS ${BIMG_BUILT_DIR} ${FIND_EXTRA_FLAG})
find_library(BIMG_DECODE_LIBRARY_DEBUG   Bimg_DecodeDebug PATHS ${BIMG_BUILT_DIR} ${FIND_EXTRA_FLAG})
find_library(BIMG_ENCODE_LIBRARY_DEBUG   Bimg_EncodeDebug PATHS ${BIMG_BUILT_DIR} ${FIND_EXTRA_FLAG})

set(BIMG_LIBRARY 
	optimized 	${BIMG_LIBRARY_RELEASE}
	debug		${BIMG_LIBRARY_DEBUG}
)

set(BIMG_DECODE_LIBRARY 
	optimized 	${BIMG_DECODE_LIBRARY_RELEASE}
	debug		${BIMG_DECODE_LIBRARY_DEBUG}
)

set(BIMG_ENCODE_LIBRARY 
	optimized 	${BIMG_ENCODE_LIBRARY_RELEASE}
	debug		${BIMG_ENCODE_LIBRARY_DEBUG}
)

if (BIMG_INCLUDE_DIR AND BIMG_LIBRARY_DEBUG AND BIMG_LIBRARY_RELEASE)
	set(BIMG_FOUND TRUE)
endif()