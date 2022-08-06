#ifndef LIBUTILS_ERRNUM_H__
#define LIBUTILS_ERRNUM_H__

#include <string>

namespace cpputils
{

// Passed through function signature parameter must be a POSIX errno
std::string strerror(int errnum);

} // namespace cpputils

#endif
