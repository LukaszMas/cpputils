#ifndef LIBCPPUTILS_PARENT_EXIT_H__
#define LIBCPPUTILS_PARENT_EXIT_H__

namespace cpputils
{

// Exit execution if parent process was terminated by linux kernel
void exit_with_parent();

} // namespace cpputils

#endif
