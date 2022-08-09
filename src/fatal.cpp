#include "fatal.h"

#include <exception> /* std::terminate() */
#include <tuple>     /* std::ignore */
#include <string.h>  /* strlen */
#include <unistd.h>> /* STDERR_FILENO */

// Write a string directly to the stderr
static void write_stderr(const char* str)
{
    // Ignore the output of the write due to the character of fatal_error call
    std::ignore = write(STDERR_FILENO, str, strlen(str));
}

void fatal_error(const char* msg)
{
    write_stderr("Terminating due to a fatal error: ");
    write_stderr(msg);
    write_stderr("\n");
    std::terminate();
}
