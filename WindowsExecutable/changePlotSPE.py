import argparse
import os

def replace_in_file(file_path, original, replacement):
    """Replaces all occurrences of a text in a file."""
    if not os.path.isfile(file_path):
        raise FileNotFoundError(f"The file '{file_path}' does not exist.")
    
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()

    updated_content = content.replace(original, replacement)

    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(updated_content)

    print(f"Replaced occurrences of '{original}' with '{replacement}' in '{file_path}'.")

def revert_replacement(file_path, replacement, original):
    """Reverts a previously applied replacement in a file."""
    replace_in_file(file_path, replacement, original)

def display_help(replacements):
    """Displays the usage instructions and the list of replacements."""
    print("Usage: python text_replacer.py <file> [--replaceX | --revertX]")
    print("\nAvailable replacements and arguments:")
    for i, (original, replacement) in enumerate(replacements, start=1):
        print(f"  {i}. Replace '{original}' with '{replacement}'")
        print(f"     --replace{i} to apply, --revert{i} to undo\n")
    print("Example:")
    print("  python text_replacer.py path/to/file.txt --replace1")
    print("  python text_replacer.py path/to/file.txt --revert1")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Replace or revert text passages in a file.")
    parser.add_argument("file", nargs="?", help="Path to the target text file.")
    parser.add_argument("--replace1", action="store_true", help="Replace 'def handle_dropdown_selection' with 'def handle_dropdown_selection2'.")
    parser.add_argument("--revert1", action="store_true", help="Revert the first replacement.")
    parser.add_argument("--replace2", action="store_true", help="Replace '######PLACEHOLDER COMMENT#########'.")
    parser.add_argument("--revert2", action="store_true", help="Revert the second replacement.")
    parser.add_argument("--replace3", action="store_true", help="Replace 'bufsize=1, shell=False, universal_newlines=True'.")
    parser.add_argument("--revert3", action="store_true", help="Revert the third replacement.")

    args = parser.parse_args()

    # Replacement rules
    replacements = [
        ("def handle_dropdown_selection(selection):", "def handle_dropdown_selection2(selection):"),
        ("######PLACEHOLDER COMMENT#########", "\tdef handle_dropdown_selection(selection):\n\t\twidgets_extra[0][\"outputradio\"].set(\"interactive window\")\n\t\tplotgo()"),
        ("bufsize=1, shell=False, universal_newlines=True", "bufsize=1, shell=False, universal_newlines=True, creationflags=subprocess.CREATE_NO_WINDOW")
    ]

    # Display help if no arguments are provided
    if not any(vars(args).values()):
        display_help(replacements)
        exit()

    # Check if the file argument is provided
    if not args.file:
        print("Error: No file specified. Use --help for usage details.")
        exit(1)

    # Execute replacements or reverts
    if args.replace1:
        replace_in_file(args.file, *replacements[0])
    if args.revert1:
        revert_replacement(args.file, *replacements[0][::-1])
    if args.replace2:
        replace_in_file(args.file, *replacements[1])
    if args.revert2:
        revert_replacement(args.file, *replacements[1][::-1])
    if args.replace3:
        replace_in_file(args.file, *replacements[2])
    if args.revert3:
        revert_replacement(args.file, *replacements[2][::-1])
