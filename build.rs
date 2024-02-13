fn main() {
    nasm_rs::compile_library_args("libutil.a", &["asm/util.asm"], &[]).unwrap();
}
