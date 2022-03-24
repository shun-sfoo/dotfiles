use std::{fs, process::Command};

const ENV_PATH: &str = "/Sources/dotfiles/env";

fn main() {
    link();
}

fn link() {
    println!("\x1b[34mREADY TO LINK\x1b[0m");
    let home_dir = std::env::var("HOME").expect("MUST RUN IN USER");
    let dotfile_dir = home_dir.clone() + ENV_PATH;
    let path = fs::read_dir(dotfile_dir).expect("DOTFILES PATH IS ERROR");

    for entry in path {
        let dir = entry.expect("CHILD FILE IS ERROR");
        let original_name = dir.file_name();
        let link = home_dir.clone() + "/." + &original_name.clone().into_string().expect("Error");
        println!("\x1b[32mln -s {:?} {:?}\x1b[0m", dir.path(), link);
        let _task = Command::new("ln")
            .arg("-s")
            .arg(dir.path())
            .arg(link)
            .output()
            .expect("failed");
    }
    println!("\x1b[34mLINK DOWN\x1b[0m");
}
