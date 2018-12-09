#ifndef CURRENCY_H
#define CURRENCY_H

#include "entity.h"

#include <QString>

class ENTITYMANAGEMENTSHARED_EXPORT Currency : public Entity
{
    Q_OBJECT
    DSL_WRITABLE_CSTREF(QString, name)

public:
    Currency(QObject * parent = Q_NULLPTR): Entity(parent){}

     ~Currency() override = default;
};

#endif // CURRENCY_H

/*
struct dsl_instantiation<QString>{
    typedef StringPath value_type;
}

dsl_instantiation<QString>::value_type q_name;

 Currency currency = Currency();

  currencyRepository.findOne(
      where(currency.q_name.eq("CUC").and(currency.q_id.between(2,6)))
         .orderBy(currency->q_id)
  );

*/
