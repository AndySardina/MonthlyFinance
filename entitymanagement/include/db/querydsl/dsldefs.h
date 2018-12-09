#ifndef DSLDEFS_H
#define DSLDEFS_H

#include "QQmlVarPropertyHelpers.h"
#include "QQmlConstRefPropertyHelpers.h"

#include "db/querydsl/predicate/stringpredicate.h"

template<typename T>
struct dsl_instantiation {
    using value_type = T;
};

template<>
struct dsl_instantiation<QString> {
    using value_type = StringPredicate;
};


#define DSL_WRITABLE_CSTREF(type, name) \
    QML_WRITABLE_CSTREF_PROPERTY(type, name) \
    public: \
       dsl_instantiation<type>::value_type q_##name = dsl_instantiation<type>::value_type(#name);

#endif // DSLDEFS_H
