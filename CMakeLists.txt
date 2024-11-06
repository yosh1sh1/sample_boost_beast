cmake_minimum_required(VERSION 3.8)

project(sample_boost_beast)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAEK_CXX_EXTENSIONS OFF)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# find_package(Protobuf CONFIG REQUIRED)
# find_package(gRPC CONFIG REQUIRED)
find_package(Boost REQUIRED COMPONENTS system)

# add_definitions(
#     -D_GLIBCXX_USE_CXX11_ABI=0
# )

add_link_options(
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
)

add_compile_options(
    -Wall
    -Wextra
    -Werror
)

if(CMAKE_BUILD_TYPE MATCHES Release)
    add_compile_options(
        # 最適化など
    ) 
endif()

set(CMAKE_EXE_LIKNER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fuse-ld=gold")

link_directories(
    # /usr/local/lib
    /lib64/
)

#
# main
#
file(
    GLOB_RECURSE
    FILES
    ${PROJECT_SOURCE_DIR}/src/*.cc
)

add_executable(${PROJECT_NAME} ${FILES})

# target_include_directories(
#     ${PROJECT_NAME}
#     PUBLIC
#     ${PROJECT_SOURCE_DIR}/src/
# )

target_link_libraries(
    ${PROJECT_NAME}
    PUBLIC
    Boost::system
)


# #
# # server
# #
# file(
#     GLOB_RECURSE
#     GRPC_SAMPLE_SERVER_FILES
#     ${PROJECT_SOURCE_DIR}/src/server/*.cc
# )

# add_executable(${PROJECT_NAME}_server ${GRPC_SAMPLE_SERVER_FILES})

# target_include_directories(
#     ${PROJECT_NAME}_server
#     PUBLIC
#     ${PROJECT_SOURCE_DIR}/src/server
#     ${PROJECT_SOURCE_DIR}/generated-sources
# )

# target_link_libraries(
#     ${PROJECT_NAME}_server
#     PUBLIC
#     proto_domain
#     protobuf
#     gRPC::grpc++
#     gRPC::grpc++_reflection
# )

# INSTALL(TARGETS ${PROJECT_NAME}_server RUNTIME DESTINATION ${PROJECT_SOURCE_DIR}/bin)

# #
# # client
# #
# file(
#     GLOB_RECURSE
#     GRPC_SAMPLE_SERVER_FILES
#     ${PROJECT_SOURCE_DIR}/src/client/*.cc
# )

# add_executable(${PROJECT_NAME}_client ${GRPC_SAMPLE_SERVER_FILES})

# target_include_directories(
#     ${PROJECT_NAME}_client
#     PUBLIC
#     ${PROJECT_SOURCE_DIR}/src/client
#     ${PROJECT_SOURCE_DIR}/generated-sources
# )

# target_link_libraries(
#     ${PROJECT_NAME}_client
#     PUBLIC
#     proto_domain
#     protobuf
#     gRPC::grpc++
#     gRPC::grpc++_reflection
# )

# INSTALL(TARGETS ${PROJECT_NAME}_client RUNTIME DESTINATION ${PROJECT_SOURCE_DIR}/bin)