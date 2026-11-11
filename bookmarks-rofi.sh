#!/usr/bin/env bash
#
# bookmarks-rofi.sh — pick a bookmark from ~/.bookmarks via rofi, open in browser.
#
# ~/.bookmarks format (one per line):   Name | URL
# Blank lines and lines starting with # are ignored.

# --- config (edit these) ---------------------------------------------------
LAUNCHER="rofi -dmenu -i -p Bookmarks:"   # swap for: dmenu -i -p Bookmarks:
BROWSER="google-chrome"
BOOKMARKS_FILE="$HOME/.bookmarks"
# ---------------------------------------------------------------------------

notify() {
	if command -v notify-send >/dev/null 2>&1; then
		notify-send "bookmarks-rofi" "$1"
	else
		echo "bookmarks-rofi: $1" >&2
	fi
}

# Strip comments/blank lines once; reuse for the menu and the lookup.
entries=$(grep -vE '^\s*(#|$)' "$BOOKMARKS_FILE" 2>/dev/null)

if [ -z "$entries" ]; then
	notify "no bookmarks found in $BOOKMARKS_FILE"
	exit 1
fi

# Show only the names (everything before the first '|', trimmed).
choice=$(printf '%s\n' "$entries" \
	| sed -E 's/[[:space:]]*\|.*$//' \
	| $LAUNCHER)

# Escape / no selection -> exit quietly.
[ -z "$choice" ] && exit 0

# Look the chosen name back up to its URL (first match wins).
url=$(printf '%s\n' "$entries" | awk -F'|' -v name="$choice" '
	{
		n = $1; gsub(/^[[:space:]]+|[[:space:]]+$/, "", n)
		if (n == name) {
			u = $2; gsub(/^[[:space:]]+|[[:space:]]+$/, "", u)
			print u
			exit
		}
	}')

if [ -z "$url" ]; then
	notify "no URL found for: $choice"
	exit 1
fi

exec "$BROWSER" "$url"
