#include <QtTest/QtTest>
#include <QDebug>
#include <QVariant>

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
    QVariant a(2.5);
    qDebug() << a.toString();

    auto currencies = currencyRepository.findAll();

    QCOMPARE(currencies.size(), 2);
    QCOMPARE(currencies.at(0)->name(), "EUR");

    Currency *sek = new Currency();
    sek->set_id(3);
    sek->set_name("SEK");
    currencyRepository.save(sek);

    currencies = currencyRepository.findAll();

    QCOMPARE(currencies.size(), 3);
}

void EntitiesTest::cleanupTestCase()
{
    QDir dataDir(QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation));
    QString dbFile = dataDir.filePath("monthlyfinance.db");

    dataDir.remove(dbFile);
}


QTEST_MAIN(EntitiesTest)
#include "entitiestest.moc"
