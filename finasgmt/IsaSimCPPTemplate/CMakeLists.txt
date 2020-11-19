cmake_minimum_required(VERSION 3.10)

project(isasim CXX)

# Turn on automatic invocation of the MOC, UIC & RCC
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address")

file(GLOB SRCS_COMMON src/*.cpp)
file(GLOB HDRS src/*.h)

add_executable(isasim IsaSim.cpp ${SRCS_COMMON} ${HDRS})

