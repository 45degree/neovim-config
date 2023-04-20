;; cpp
#include <gtest/gtest.h>

int 
main(int argc, char *argv[]) {
  testing::InitGoogleTest(&argc, argv);

  {{_cursor_}}

  return RUN_ALL_TESTS();
}
