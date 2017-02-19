# BGFX_FOUND
# BGFX_LIBRARY: (debug, optimized) for windows
# BGFX_INCLUDE_DIR
# function: assimp_copy_binaries (win32)

if (ANDROID)    
    set(BX_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deps/bx_android_arm CACHE PATH "BGFX root directory")
    set(FIND_EXTRA_FLAG NO_CMAKE_FIND_ROOT_PATH)
elseif (IOS)
    set(BX_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deps/bx_ios_arm CACHE PATH "Bgfx root directory")
    set(FIND_EXTRA_FLAG NO_CMAKE_FIND_ROOT_PATH)
else()
    set(BX_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deps/bx CACHE PATH "BGFX root directory")
endif()

if (MSVC)
	if(CMAKE_SIZEOF_VOID_P EQUAL 8)
		set(BX_BUILT_DIR ${BGFX_ROOT_DIR}/.build/win64_vs2015/bin CACHE PATH "BGFX built binaries directory")
	else()
		set(BX_BUILT_DIR ${BGFX_ROOT_DIR}/.build/win32_vs2015/bin CACHE PATH "BGFX built binaries directory")
	endif()
endif()

# Find path of each library
find_path(BX_INCLUDE_DIR
	NAMES
		bx/bx.h
	HINTS
		${BX_ROOT_DIR}/include
    ${FIND_EXTRA_FLAG}
)

find_library(BX_LIBRARY_RELEASE bxRelease PATHS ${BX_BUILT_DIR} ${FIND_EXTRA_FLAG})
find_library(BX_LIBRARY_DEBUG	bxDebug PATHS ${BX_BUILT_DIR} ${FIND_EXTRA_FLAG})

set(BX_LIBRARY 
	optimized 	${BX_LIBRARY_RELEASE}
	debug		${BX_LIBRARY_DEBUG}
)

if (BX_INCLUDE_DIR AND BX_LIBRARY_DEBUG AND BX_LIBRARY_RELEASE)
	set(BX_FOUND TRUE)
endif()