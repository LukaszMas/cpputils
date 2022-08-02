#ifndef LIBUTILS_ERRNO_H__
#define LIBUTILS_ERRNO_H__

#include <string>

namespace cpputils
{

// Passed through function signature parameter must be a POSIX errno
std::string strerror(int errnum);

} // namespace cpputils

#endif
