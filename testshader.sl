#include <test_header.h>

// testshader with a dependency on test_header for testing out the makefile!
surface
testshader()
{
    Ci = test_func();
    Oi = Os;
}
