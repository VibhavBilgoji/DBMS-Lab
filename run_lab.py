#!/usr/bin/env python3
import sys
import os
import re
import subprocess

SUDO_PWD = "9422181844"
DB_NAME = "College"

def parse_lab_file(filepath):
    """
    Parses a lab exercise SQL file into pairs of (question_text, query_sql).
    Handles questions prefixed with '-- <num>.' or similar comment formats.
    """
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    # Split by comment headers matching questions: e.g. '-- 1. ' or '-- 1\n'
    pattern = r"(?:^|\n)--\s*(\d+[\.\)].*?)(?=\n(?:[^-]|\z))"
    chunks = re.split(pattern, content, flags=re.DOTALL)

    items = []
    # chunks[0] is preamble before first question
    idx = 1
    while idx < len(chunks):
        q_header = chunks[idx].strip()
        sql_part = chunks[idx + 1].strip() if idx + 1 < len(chunks) else ""
        
        # Clean up any trailing inline comments if needed, but keep valid SQL
        sql_lines = []
        for line in sql_part.splitlines():
            # Keep line unless it's an alternate query comment or pure comment
            sql_lines.append(line)
        cleaned_sql = "\n".join(sql_lines).strip()
        
        if cleaned_sql:
            items.append((q_header, cleaned_sql))
        idx += 2

    return items

def execute_sql(sql):
    """Executes SQL against MariaDB College database and returns formatted table output."""
    cmd = ["sudo", "-S", "mariadb", "-u", "root", DB_NAME, "-t", "-e", sql]
    proc = subprocess.run(
        cmd,
        input=f"{SUDO_PWD}\n",
        text=True,
        capture_output=True
    )
    if proc.returncode != 0 and proc.stderr:
        # Filter out the [sudo] password prompt line
        err_lines = [l for l in proc.stderr.splitlines() if "[sudo]" not in l]
        return "\n".join(err_lines).strip()
    return proc.stdout.strip()

def print_separator(char="=", length=70):
    print(char * length)

def display_item(index, q_header, sql, total):
    print_separator("=")
    print(f"\033[1;36m[{index}/{total}] -- {q_header}\033[0m")
    print_separator("-")
    print(f"\033[0;33m{sql}\033[0m\n")
    output = execute_sql(sql)
    if output:
        print(output)
    else:
        print("\033[0;32m(Query executed successfully, empty set)\033[0m")
    print()

def main():
    if len(sys.argv) < 2 or sys.argv[1] in ("-h", "--help"):
        print("Usage:")
        print("  python3 run_lab.py <lab_number>                 # Run all queries for a lab")
        print("  python3 run_lab.py <lab_number> -i              # Interactive step-by-step mode")
        print("  python3 run_lab.py <lab_number> <query_number>  # Run a specific query (e.g. 6 4)")
        print()
        print("Examples:")
        print("  python3 run_lab.py 6")
        print("  python3 run_lab.py 6 -i")
        print("  python3 run_lab.py 6 10")
        sys.exit(0)

    lab_num = sys.argv[1]
    curr_dir = os.path.dirname(os.path.abspath(__file__))
    filename = f"Lab_{lab_num}_Exercise.sql"
    filepath = os.path.join(curr_dir, filename)

    if not os.path.exists(filepath):
        print(f"\033[1;31mError: File '{filename}' not found in {curr_dir}\033[0m")
        sys.exit(1)

    items = parse_lab_file(filepath)
    if not items:
        print(f"\033[1;31mNo queries could be parsed from {filename}\033[0m")
        sys.exit(1)

    interactive = False
    target_q = None

    if len(sys.argv) >= 3:
        arg2 = sys.argv[2]
        if arg2 in ("-i", "--interactive"):
            interactive = True
        elif arg2.isdigit():
            target_q = int(arg2)
        else:
            print(f"Unknown option: {arg2}")
            sys.exit(1)

    print(f"\n\033[1;32m>>> Loaded {len(items)} queries from {filename} <<<\033[0m\n")

    if target_q is not None:
        if 1 <= target_q <= len(items):
            q_header, sql = items[target_q - 1]
            display_item(target_q, q_header, sql, len(items))
        else:
            print(f"\033[1;31mError: Question {target_q} not found. Available questions: 1 to {len(items)}\033[0m")
            sys.exit(1)
        return

    for idx, (q_header, sql) in enumerate(items, start=1):
        display_item(idx, q_header, sql, len(items))
        if interactive and idx < len(items):
            try:
                choice = input("\033[1;37m[Press Enter for next query, or 'q' to quit]: \033[0m").strip().lower()
                if choice == "q":
                    print("\nExiting interactive mode.")
                    break
            except (KeyboardInterrupt, EOFError):
                print("\nInterrupted.")
                break

if __name__ == "__main__":
    main()
