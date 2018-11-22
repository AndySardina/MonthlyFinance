#include <QtTest/QtTest>

#include "db/entitymanager.h"
#include "db/repository/currencyrepository.h"

class EntitiesTest: public QObject
{
    Q_OBJECT
public:
    EntitiesTest();

private slots:
    void currencies();
    void cleanupTestCase();

private:
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
