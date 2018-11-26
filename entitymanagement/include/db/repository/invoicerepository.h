#ifndef INVOICEREPOSITORY_H
#define INVOICEREPOSITORY_H

#include "repository.h"
#include <db/entity/invoice.h>

class InvoiceRepository : public Repository<Invoice, int>
{
public:
    InvoiceRepository() = default;

    virtual ~InvoiceRepository() = default;
};

#endif // INVOICEREPOSITORY_H
