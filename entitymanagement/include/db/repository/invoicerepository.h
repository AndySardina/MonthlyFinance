#ifndef INVOICEREPOSITORY_H
#define INVOICEREPOSITORY_H

#include "repository.h"
#include <db/entity/invoice.h>

typedef Repository<Invoice, int> InvoiceRepository;

#endif // INVOICEREPOSITORY_H
