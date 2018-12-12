#ifndef INCORRECTRESULTSIZEDATAACCESSEXCEPTION_H
#define INCORRECTRESULTSIZEDATAACCESSEXCEPTION_H

#include <exception>

#include <QString>

class IncorrectResultSizeDataAccessException: public std::exception
{
public:
    const char * what () const noexcept override {
          return "Incorrect result size.";
   }
};

#endif // INCORRECTRESULTSIZEDATAACCESSEXCEPTION_H
