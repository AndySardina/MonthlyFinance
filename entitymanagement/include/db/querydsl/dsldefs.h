#ifndef DSLDEFS_H
#define DSLDEFS_H

#include "QQmlVarPropertyHelpers.h"
#include "QQmlConstRefPropertyHelpers.h"

#include "db/querydsl/predicate/stringpredicate.h"
#include "db/querydsl/predicate/numberpredicate.h"


template<typename T>
struct dsl_instantiation {
    using value_type = T;
};

template<>
struct dsl_instantiation<QString> {
    using value_type = StringPredicate;
};

template<>
struct dsl_instantiation<int> {
    using value_type = NumberPredicate<int>;
};

template<>
struct dsl_instantiation<double> {
    using value_type = NumberPredicate<double>;
};

#define DSL_PROPERTY(type, name) \
    public: \
        dsl_instantiation<type>::value_type q_##name = dsl_instantiation<type>::value_type(#name);


#define DSL_WRITABLE_CSTREF_PROPERTY(type, name) \
    QML_WRITABLE_CSTREF_PROPERTY(type, name) \
    DSL_PROPERTY(type, name)

#define DSL_WRITABLE_VAR_PROPERTY(type, name) \
    QML_WRITABLE_VAR_PROPERTY(type, name) \
    DSL_PROPERTY(type, name)

#endif // DSLDEFS_H
