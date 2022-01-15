use std::{fs, process::Command};

const ENV_PATH: &str = "/Sources/dotfiles/env";
const _CABAL_DIR: &str = "/.cabal";
const _STACK_DIR: &str = "/.stack";

fn main() {
    link();
    haskell();
}

fn link() {
    println!("READY TO LINK");
    let home_dir = std::env::var("HOME").expect("MUST RUN IN USER");
    let dotfile_dir = home_dir.clone() + ENV_PATH;
    let path = fs::read_dir(dotfile_dir).expect("DOTFILES PATH IS ERROR");

    for entry in path {
        let dir = entry.expect("CHILD FILE IS ERROR");
        let original_name = dir.file_name();
        let link = home_dir.clone() + "/." + &original_name.clone().into_string().expect("Error");
        println!("ln -s {:?} {:?}", dir.path(), link);
        let _task = Command::new("ln")
            .arg("-s")
            .arg(dir.path())
            .arg(link)
            .output()
            .expect("failed");
    }
    println!("link DOWN");
}

fn haskell() {
    println!("CONFIGURATION HASKELL ENVIROMENT");

    println!("HASKELL ENVIROMENT DONE");
}
