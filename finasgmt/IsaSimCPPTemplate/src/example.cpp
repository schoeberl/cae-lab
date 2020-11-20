//Example source file
#include "example.h"

//Example constructor implementation
Example::Example(int ex) : ex(ex) {}

//Example methods implementation
int Example::getEx() const {
    return this->ex;
}

void Example::setEx(int newEx) {
    this->ex = newEx;
}