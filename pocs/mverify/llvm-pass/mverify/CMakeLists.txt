add_library(mverify SHARED MVerify.cpp)

target_link_libraries(mverify
    "$<$<PLATFORM_ID:Darwin>:-undefined dynamic_lookup>")
