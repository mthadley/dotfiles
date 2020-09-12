use strsim::{levenshtein};
use std::{env, io::{self, BufRead}};

fn main() {
    let compare_to = env::args().nth(1).expect("Expected string to compare against.");

    let mut lines = io::stdin()
        .lock()
        .lines()
        .map(|line| line.expect("Failed to read line from stdin."))
        .filter(|line| line != &compare_to)
        .collect::<Vec<String>>();

    lines.sort_by_cached_key(|line| levenshtein(line, &compare_to));

    for line in lines {
        println!("{}", line);
    }
}
