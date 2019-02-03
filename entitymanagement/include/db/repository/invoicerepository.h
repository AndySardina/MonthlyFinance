#ifndef INVOICEREPOSITORY_H
#define INVOICEREPOSITORY_H

#include "repository.h"
#include <db/entity/invoice.h>

using InvoiceRepository = Repository<Invoice, int>;

#endif // INVOICEREPOSITORY_H
