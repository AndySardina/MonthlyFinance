#include <QtTest/QtTest>

#include "db/entitymanager.h"
#include <db/repository/expenserepository.h>
#include "db/repository/expensecategoryrepository.h"
#include "db/repository/currencyrepository.h"

class EntitiesTest: public QObject
{
    Q_OBJECT
public:
    EntitiesTest();

private slots:
    void expenseCategories();
    void expense();
    void currencies();
    void cleanupTestCase();

private:
    ExpenseCategoryRepository expenseCategoryRepository;
    ExpenseRepository expenseRepository;
    CurrencyRepository currencyRepository;
};


EntitiesTest::EntitiesTest()
{
    EntityManager entityManager;

    try {
        entityManager.initConection();
    } catch (const std::runtime_error& e) {
        qDebug() << e.what();
    }

}

void EntitiesTest::expenseCategories(){
    auto categories = expenseCategoryRepository.findAll();

    QCOMPARE(categories.size(), 1);

    QCOMPARE(categories.at(0)->name(), "Comida");

    expenseCategoryRepository.deleteAll();

    auto r = expenseCategoryRepository.findAll();
    QCOMPARE(r.size(), 0);

    expenseCategoryRepository.saveAll(categories);
    QCOMPARE(expenseCategoryRepository.findById(1)->name(), "Comida");
}

void EntitiesTest::expense()
{
    auto category = expenseCategoryRepository.findById(1);

    Expense* entity = new Expense();
    entity->set_id(1);
    entity->set_category(category);
    entity->set_date(QDate::currentDate());
    entity->set_amount(5.5);
    entity->set_description("Manzanas");

    expenseRepository.save(entity);

    auto expenses = expenseRepository.findAll();

    QCOMPARE(expenses.size(), 1);

    QCOMPARE(expenses.at(0)->category()->name(), "Comida");
    QCOMPARE(expenses.at(0)->amount(), entity->amount());
    QCOMPARE(expenses.at(0)->description(), entity->description());

    expenseRepository.deleteAll();
}

void EntitiesTest::currencies()
{
    auto currencies = currencyRepository.findAll();

    QCOMPARE(currencies.size(), 2);
    QCOMPARE(currencies.at(0)->name(), "EUR");
}

void EntitiesTest::cleanupTestCase()
{
    QDir dataDir(QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation));
    QString dbFile = dataDir.filePath("monthlyfinance.db");

    dataDir.remove(dbFile);
}


QTEST_MAIN(EntitiesTest)
#include "entitiestest.moc"
