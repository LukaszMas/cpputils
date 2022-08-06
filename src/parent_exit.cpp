#include "../include/parent_exit.h"

#include <sys/prctl.h> /* prctl() */
#include <csignal>     /* SIGTERM */
#include <cstdio>      /* std::perror() */
#include <cstdlib>     /* std::exit() */

extern "C"
{
#include <unistd.h> /* getppid() */
}

namespace cpputils
{

void exit_with_parent()
{
    // Operations on a process or thread
    int r = prctl(PR_SET_PDEATHSIG, SIGTERM);
    // On error -1 is returned and errno is set to indicate the error
    if (r == -1)
    {
        // Print a textual description of the error code currently stored in
        // the system variable errno to stderr
        std::perror(0);
        std::exit(EXIT_FAILURE);
    }
    // test in case the original parent exited just before the prctl() call
    if (getppid() == 1)
        std::exit(EXIT_FAILURE);
}

} // namespace cpputils
