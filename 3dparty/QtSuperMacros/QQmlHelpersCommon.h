#ifndef QQMLHELPERSCOMMON_H
#define QQMLHELPERSCOMMON_H

#include <QtGlobal>

// NOTE : SFINAE trickery to find which type is the cheapest between T and const T &

template<typename T> struct CheapestType          { using type_def = const T &; };
template<>           struct CheapestType<bool>    { using type_def = bool; };
template<>           struct CheapestType<quint8>  { using type_def = quint8; };
template<>           struct CheapestType<quint16> { using type_def = quint16; };
template<>           struct CheapestType<quint32> { using type_def = quint32; };
template<>           struct CheapestType<quint64> { using type_def = quint64; };
template<>           struct CheapestType<qint8>   { using type_def = qint8; };
template<>           struct CheapestType<qint16>  { using type_def = qint16; };
template<>           struct CheapestType<qint32>  { using type_def = qint32; };
template<>           struct CheapestType<qint64>  { using type_def = qint64; };
template<>           struct CheapestType<float>   { using type_def = float; };
template<>           struct CheapestType<double>  { using type_def = double; };
template<typename T> struct CheapestType<T *>     { using type_def = T *; };

// NOTE : define to add/remove 'get_' prefix on getters

#ifdef QTQMLTRICKS_NO_PREFIX_ON_GETTERS
#   define MAKE_GETTER_NAME(name) name
#else
#   define MAKE_GETTER_NAME(name) get_##name
#endif

#endif // QQMLHELPERSCOMMON_H
