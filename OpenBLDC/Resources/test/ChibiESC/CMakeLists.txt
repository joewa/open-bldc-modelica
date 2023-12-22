#message(STATUS "${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR}")
# Some test applications

include_directories(. ../../Include)
add_compile_definitions(SIM_TARGET BOARD_LOOONG_STRIP_F4)


if (UNIX)
  # Make sure to link with the correct threading library (defines ${CMAKE_THREAD_LIBS_INIT}):
  find_package (Threads)
endif (UNIX)
# alternative way to compile with threading for gcc. However, using recommended find_package (Threads) way for the moment
#if (CMAKE_COMPILER_IS_GNUCC)
#SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pthread")
#endif (CMAKE_COMPILER_IS_GNUCC)

if (CYGWIN)
  if ( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    find_library( CRYPTO_LIBRARY crypto
        PATHS   ${PROJECT_SOURCE_DIR}/Library/win64)
    find_library( SSL_LIBRARY ssl
        PATHS   ${PROJECT_SOURCE_DIR}/Library/win64)
  elseif ( CMAKE_SIZEOF_VOID_P EQUAL 4 )
    find_library( CRYPTO_LIBRARY crypto
        PATHS   ${PROJECT_SOURCE_DIR}/Library/win32)
    find_library( SSL_LIBRARY ssl
        PATHS   ${PROJECT_SOURCE_DIR}/Library/win32)
  else ( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    message(SEND_ERROR "Uups. Neither 64, nor 32 bit??")
  endif ( CMAKE_SIZEOF_VOID_P EQUAL 8 )
elseif (UNIX)
  if ( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    find_library( CRYPTO_LIBRARY crypto
        PATHS   ${PROJECT_SOURCE_DIR}/Library/linux64)
    find_library( SSL_LIBRARY ssl
        PATHS   ${PROJECT_SOURCE_DIR}/Library/linux64)
  elseif ( CMAKE_SIZEOF_VOID_P EQUAL 4 )
    find_library( CRYPTO_LIBRARY crypto
        PATHS   ${PROJECT_SOURCE_DIR}/Library/linux32)
    find_library( SSL_LIBRARY ssl
        PATHS   ${PROJECT_SOURCE_DIR}/Library/linux32)
  else ( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    message(SEND_ERROR "Uups. Neither 64, nor 32 bit??")
  endif ( CMAKE_SIZEOF_VOID_P EQUAL 8 )
endif ()

add_executable(chibiESC main.c bal.c bal_interface.c bal_term.c misc.c pwmadcdma.c scanf.c siminterfaces.c ../Util/ModelicaUtilities.c)
set_property(TARGET chibiESC PROPERTY FOLDER "test/ChibiESC")
if (MSVC OR MINGW)
  target_link_libraries(chibiESC Ws2_32)
endif (MSVC OR MINGW)
