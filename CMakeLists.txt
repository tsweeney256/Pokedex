cmake_minimum_required(VERSION 2.8)
project(pokedex)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${pokedex_SOURCE_DIR}/cmake")
set(BIN_DIR ${pokedex_SOURCE_DIR}/)

# Bump up warning levels appropriately for clang, gcc & msvc and build in debug mode
if (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" OR ${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic -std=c++1y")
	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_DEBUG} -g")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_RELEASE} -O2")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
	if (CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
		string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
	else()
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")
	endif()
endif()

find_package(SDL2 REQUIRED)
find_package(SDL2_image REQUIRED)
find_package(SDL2_ttf REQUIRED)
find_package(Sqlite3 REQUIRED)

include_directories(${SDL2_INCLUDE_DIR} ${SDL2_IMAGE_INCLUDE_DIR} ${SDL2_TTF_INCLUDE_DIR} ${SQLITE3_INCLUDE_DIR})
include_directories(include)

add_executable(
	${PROJECT_NAME}
	main.cpp
	render_context.cpp
	imgui.cpp
	imgui_sdlbackend.cpp
	home_screen.cpp
    pokedex_screen.cpp
	sprite.cpp
	texture.cpp
	PokemonData.cpp
	screen_dispatcher.cpp
)

target_link_libraries(${PROJECT_NAME} ${SDL2_LIBRARY} ${SDL2_TTF_LIBRARY} ${SDL2_IMAGE_LIBRARY} ${SQLITE3_LIBRARIES})
install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION ${BIN_DIR})
