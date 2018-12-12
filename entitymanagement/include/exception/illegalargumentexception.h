#ifndef ILLEGALARGUMENTEXCEPTION_H
#define ILLEGALARGUMENTEXCEPTION_H

#include <exception>

class IllegalArgumentException: public std::exception
{
public:
    const char * what () const noexcept override {
          return "The argument passed is illegal or inappropriate.";
   }
};

#endif // ILLEGALARGUMENTEXCEPTION_H
