use std::{
    collections::HashMap,
    fs::File,
    io::{self, BufRead, BufReader},
};

fn main() {
    /*
    $ -> commands
        cd -> change dir // cd "x" -> go to x // cd .. -> go back where last cd
        ls ->list
    123 abc -> size=123 name=abc
    dir xyz -> contains dir xyz
    make a vector per dir
    if &ls save to vector
    /* expected structure
    cd a
    ls
    (a,[file,file, dir b])
    (b,[file, dir c])
    (/,[file, dir a, dir b])
    we start from root
    cd / = we save whereIam
    ls
    save tree
    if cd a
        if cd char && ls
            save

    */
    */

    print!("{:?}", summing(parsing_1("test.txt").expect("error!!!")));
}
fn summing(the_map: HashMap<String, Vec<String>>) -> io::Result<i32> {
    let result = the_map.get("a").unwrap().to_vec();
    let bla: Vec<i32> = result
        .into_iter()
        .filter(|x| x.chars().next().unwrap().is_numeric())
        .map(|z| z.to_string().split_at(z.find(" ").unwrap()).0.to_owned())
        .map(|y| y.parse::<i32>().unwrap().to_owned())
        .collect();
    let sum = bla.into_iter().sum();
    Ok(sum)
    // Ok(bla)
    // let _result = the_map.get_key_value("e");
}
fn parsing_1(file_name: &str) -> io::Result<HashMap<String, Vec<String>>> {
    let mut the_map: HashMap<String, Vec<String>> = HashMap::new();

    let mut list: Vec<String> = Vec::new();
    let mut log: Vec<String> = Vec::new();
    let file = File::open(file_name)?;
    let reader = BufReader::new(file);
    let mut counter: usize = 2;
    for line in reader.lines() {
        //    if(line.)
        let current_pos: &str = &line?;

        log.push(current_pos.to_string());
        if log.len() > 2 && log[log.len() - counter - 1].clone().starts_with("$ cd") {
            the_map.insert(
                log[log.len() - counter - 1]
                    .clone()
                    .replacen("$ cd ", "", 3),
                list.clone(),
            );
            if !current_pos.starts_with("$") && log[log.len() - counter].starts_with("$ ls") {
                list.push(current_pos.to_string());
                the_map.insert(
                    log[log.len() - counter - 1]
                        .clone()
                        .replacen("$ cd ", "", 3),
                    list.clone(),
                );
                counter = &counter + 1;
            } else {
                counter = 2;
                list.clear()
            }
        }
        // list.push(String::from(line?))
    }

    Ok(the_map)
}
