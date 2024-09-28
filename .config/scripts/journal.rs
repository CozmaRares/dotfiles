use std::collections::HashSet;
use std::env;
use std::process::Command;

struct Colors<'a> {
    date: &'a str,
    time: &'a str,
    host: &'a str,
    service: &'a str,
    pid: &'a str,
    message: &'a str,
}

#[inline]
fn colors_from_args<'a>(args: &'a Vec<String>) -> Colors<'a> {
    if args.len() < 7 {
        panic!("Error: Not enough arguments provided. Expected 6 arguments.");
    }

    Colors {
        date: &args[1],
        time: &args[2],
        host: &args[3],
        service: &args[4],
        pid: &args[5],
        message: &args[6],
    }
}

#[inline]
fn print_log(log: &str, colors: &Colors) {
    let parts: Vec<&str> = log.split_whitespace().collect();

    if parts.len() < 6 {
        println!("{}", log);
    }

    let date = format!("{} {}", parts[0], parts[1]);
    let time = parts[2];
    let host = parts[3];

    let service_pid: Vec<&str> = parts[4].split('[').collect();
    let service = service_pid[0];
    let pid = service_pid[1].trim_end_matches(']');

    let message = parts[5..].join(" ");

    let date_color = colors.date;
    let time_color = colors.time;
    let host_color = colors.host;
    let service_color = colors.service;
    let pid_color = colors.pid;
    let message_color = colors.message;

    println!(
        "<span color='{date_color}'>{date}</span> \
         <span color='{time_color}'>{time}</span> \
         <span color='{host_color}'>{host}</span> \
         <span color='{service_color}'>[{service}]</span> \
         [<span color='{pid_color}'>{pid}</span>] \
         <span color='{message_color}'>{message}</span>"
    );
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let colors = colors_from_args(&args);

    let exclude = vec!["kernel", "wpa_supplicant", "CTRL-EVENT-BEACON-LOSS"];

    let output = Command::new("journalctl")
        .arg("--since=today")
        .arg("--no-pager")
        .output()
        .expect("Failed to execute journalctl");

    let logs = String::from_utf8_lossy(&output.stdout);
    let mut seen = HashSet::new();
    let mut filtered_logs = Vec::new();

    for line in logs.lines() {
        if exclude.iter().any(|service| line.contains(service)) {
            continue;
        }

        if seen.insert(line) {
            filtered_logs.push(line);
        }
    }

    let len = filtered_logs.len();
    let last_100 = if len > 100 {
        &filtered_logs[len - 100..]
    } else {
        &filtered_logs[..]
    };

    for log in last_100 {
        print_log(log, &colors);
    }
}
