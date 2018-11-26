#ifndef INVOICEREPOSITORY_H
#define INVOICEREPOSITORY_H

#include "repository.h"
#include <db/entity/invoice.h>

class ENTITYMANAGEMENTSHARED_EXPORT InvoiceRepository : public Repository<Invoice, int>
{
};

#endif // INVOICEREPOSITORY_H
