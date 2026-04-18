cd plugins
cargo build --release
mkdir -p ~/.config/anyrun/plugins
cp ../target/release/*.so ~/.config/anyrun/plugins/
