/*
 * prepend-c — fast stdin line-prefixer.
 *
 * Reads every line from stdin and writes (prefix + line) to stdout.
 * Designed as a drop-in for the two sed-fork pattern used in the zsh
 * `prepend` function: avoids process substitution overhead entirely.
 *
 * Usage:
 *   command | prepend-c "  "
 *        or  prepend-c "  " < file
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    const char  *prefix = argc > 1 ? argv[1] : "";
    const size_t plen   = strlen(prefix);
    char        *line   = NULL;
    size_t       cap    = 0;
    ssize_t      n;

    while ((n = getline(&line, &cap, stdin)) != -1) {
        if (plen > 0) fwrite(prefix, 1, plen, stdout);
        fwrite(line, 1, (size_t)n, stdout);
    }

    free(line);
    return ferror(stdout) ? 1 : 0;
}
