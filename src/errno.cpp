#include "errnum.h"
#include <string>

extern "C"
{
#include <string.h>
}

// The overloaded versions strerror_r() defined in <string.h> with different
// return types are handled with the overloaded inspect_error() function

char* inspect_error(int res, char* buf, int errnum)
{
    if (res)
        sprintf(buf, "Unknown errnum: %d", errnum);
    return buf;
}

char* inspect_error(char* res, char*, int)
{
    return res;
}

namespace cpputils
{

std::string strerror(int errnum)
{
    char buf[256];

    auto res = strerror_r(errnum, buf, sizeof(buf));
    return inspect_error(res, buf, errnum);
}

} // namespace cpputils
