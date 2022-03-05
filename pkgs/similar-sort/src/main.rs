use std::{
    env,
    io::{self, BufRead},
};
use strsim::levenshtein;

fn main() {
    let compare_to = env::args()
        .nth(1)
        .expect("Expected string to compare against.");

    let stdin = io::stdin();
    let lines = stdin
        .lock()
        .lines()
        .map(|line| line.expect("Failed to read line from stdin."));

    let sorted_lines = sorted_by_similiarity(lines, &compare_to);

    println!("{}", sorted_lines.join("\n"));
}

fn sorted_by_similiarity(strs: impl Iterator<Item = String>, compare_to: &str) -> Vec<String> {
    let mut sorted = strs.filter(|s| s != compare_to).collect::<Vec<String>>();
    sorted.sort_by_cached_key(|line| levenshtein(line, compare_to));
    sorted
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn returns_strings_in_similar_order() {
        assert_eq!(
            sorted_by_similiarity(
                vec![
                    String::from("spec/models/user_spec.rb"),
                    String::from("spec/controllers/articles_controller_spec.rb"),
                    String::from("spec/controllers/users_controller_spec.rb"),
                ]
                .into_iter(),
                "app/controllers/users_controller.rb"
            ),
            vec![
                String::from("spec/controllers/users_controller_spec.rb"),
                String::from("spec/controllers/articles_controller_spec.rb"),
                String::from("spec/models/user_spec.rb"),
            ]
        )
    }

    #[test]
    fn filters_out_the_string_being_compared_to() {
        assert_eq!(
            sorted_by_similiarity(
                vec![
                    String::from("spec/models/user_spec.rb"),
                    String::from("spec/controllers/articles_controller_spec.rb"),
                    String::from("spec/controllers/users_controller_spec.rb"),
                ]
                .into_iter(),
                "spec/models/user_spec.rb"
            ),
            vec![
                String::from("spec/controllers/users_controller_spec.rb"),
                String::from("spec/controllers/articles_controller_spec.rb"),
            ]
        )
    }
}
