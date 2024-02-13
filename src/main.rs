#[link(name = "util")]
extern "C" {
    fn print_hex(hex: u64);
}

fn main() {
    unsafe { print_hex(0x42) };
}
