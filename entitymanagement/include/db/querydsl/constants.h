#ifndef CONSTANTS_H
#define CONSTANTS_H

enum class Direction
{
    PARENT,
    LEFT,
    RIGHT
};

enum class Type
{
    STRING,
    NUMBER,
    DATE,
    COLUMN,
    AND,
    OR,
    EQ,
    NEQ,
    BETWEEN,
    GT,
    GOE,
    LT,
    LOE,
    LIKE
};

#endif // CONSTANTS_H
