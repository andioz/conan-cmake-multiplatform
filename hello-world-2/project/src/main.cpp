#include <gtest/gtest.h>
#include <gmock/gmock.h>

TEST(Main, HelloWorld) {
SUCCEED();
}

int main(
    int argc,
    char* argv[]
) {
  testing::InitGoogleTest(&argc, argv);
  testing::InitGoogleMock(&argc, argv);
  return RUN_ALL_TESTS();
}
