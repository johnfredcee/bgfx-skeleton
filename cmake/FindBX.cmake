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

# Find path of each library
find_path(BX_INCLUDE_DIR
	NAMES
		bx/bx.h
	HINTS
		${BX_ROOT_DIR}/include
    ${FIND_EXTRA_FLAG}
)

#find_library(BX_LIBRARY_RELEASE bxRelease PATHS ${BX_ROOT_DIR}/lib ${FIND_EXTRA_FLAG})
#find_library(BX_LIBRARY_DEBUG	bxDebug PATHS ${BX_ROOT_DIR}/lib ${FIND_EXTRA_FLAG})

#set(BX_LIBRARY 
#	optimized 	${BX_LIBRARY_RELEASE}
#	debug		${BX_LIBRARY_DEBUG}
#)

if (BX_INCLUDE_DIR)
	set(BX_FOUND TRUE)
endif()