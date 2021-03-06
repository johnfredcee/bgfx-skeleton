# BGFX_FOUND
# BGFX_LIBRARY: (debug, optimized) for windows
# BGFX_INCLUDE_DIR
# function: assimp_copy_binaries (win32)

if (ANDROID)    
    set(BGFX_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deps/bgfx_android_arm CACHE PATH "BGFX root directory")
    set(FIND_EXTRA_FLAG NO_CMAKE_FIND_ROOT_PATH)
elseif (IOS)
    set(BGFX_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deps/bgfx_ios_arm CACHE PATH "Bgfx root directory")
    set(FIND_EXTRA_FLAG NO_CMAKE_FIND_ROOT_PATH)
else()
    set(BGFX_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/deps/bgfx CACHE PATH "BGFX root directory")
endif()

# Find path of each library
find_path(BGFX_INCLUDE_DIR
	NAMES
		bgfx/bgfx.h
	HINTS
		${BGFX_ROOT_DIR}/include
    ${FIND_EXTRA_FLAG}
)

if (MSVC)
	if(CMAKE_SIZEOF_VOID_P EQUAL 8)
		set(BGFX_BUILT_DIR ${BGFX_ROOT_DIR}/.build/win64_vs2017/bin CACHE PATH "BGFX built binaries directory")
	else()
		set(BGFX_BUILT_DIR ${BGFX_ROOT_DIR}/.build/win32_vs2017/bin CACHE PATH "BGFX built binaries directory")
	endif()
endif()

find_library(BGFX_LIBRARY_RELEASE bgfxRelease PATHS ${BGFX_BUILT_DIR} ${FIND_EXTRA_FLAG})
find_library(BGFX_LIBRARY_DEBUG	bgfxDebug PATHS ${BGFX_BUILT_DIR} ${FIND_EXTRA_FLAG})

find_library(BGFX_COMMON_LIBRARY_RELEASE example-CommonRelease PATHS ${BGFX_BUILT_DIR} ${FIND_EXTRA_FLAG})
find_library(BGFX_COMMON_LIBRARY_DEBUG	example-CommonDebug PATHS ${BGFX_BUILT_DIR} ${FIND_EXTRA_FLAG})

find_library(BGFX_GLUE_LIBRARY_RELEASE example-glueRelease PATHS ${BGFX_BUILT_DIR} ${FIND_EXTRA_FLAG})
find_library(BGFX_GLUE_LIBRARY_DEBUG   example-glueDebug PATHS ${BGFX_BUILT_DIR} ${FIND_EXTRA_FLAG})

set(BGFX_LIBRARY 
	optimized 	${BGFX_LIBRARY_RELEASE}
	debug		${BGFX_LIBRARY_DEBUG}
)

set(BGFX_COMMON_LIBRARY 
	optimized 	${BGFX_COMMON_LIBRARY_RELEASE}
	debug		${BGFX_COMMON_LIBRARY_DEBUG}
)

set(BGFX_GLUE_LIBRARY 
	optimized 	${BGFX_GLUE_LIBRARY_RELEASE}
	debug		${BGFX_GLUE_LIBRARY_DEBUG}
)

if (BGFX_LIBRARY_RELEASE AND BGFX_LIBRARY_DEBUG AND BGFX_COMMON_LIBRARY_RELEASE AND BGFX_COMMON_LIBRARY_DEBUG AND BGFX_INCLUDE_DIR)
	set(BGFX_FOUND TRUE)
endif()