#ifndef INVOICEREPOSITORY_H
#define INVOICEREPOSITORY_H

#include "repository.h"
#include <db/entity/invoice.h>

class InvoiceRepository : public Repository<Invoice, int>
{
public:
    InvoiceRepository() = default;

    virtual ~InvoiceRepository() = default;

    // Repository interface
public:
    void save(Invoice* entity);

protected:
    Invoice* createEntity(const QSqlQuery &q);
};

#endif // INVOICEREPOSITORY_H
