
if(DEFINED IN_SOURCE_BUILD)
    set(LLVM_LINK_COMPONENTS BitWriter Core IPO IrReader InstCombine Instrumentation Target Linker Analysis ScalarOpts Support Svf Cudd)
    add_llvm_tool( wpa wpa.cpp )
else()
    add_executable( wpa wpa.cpp )

    target_link_libraries( wpa Svf Cudd ${llvm_libs} ${PRJHOME}/mpk-rust-demangle/target/release/libmpk_rust_demangle.a)

    link_directories(
            ${PRJHOME}/mpk-rust-demangle/target/release)
    set_target_properties( wpa PROPERTIES
                           RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
endif()


