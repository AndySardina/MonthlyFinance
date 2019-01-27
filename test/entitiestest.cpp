#include <functional>

#include <QtTest/QtTest>
#include <QDebug>
#include <QVariant>

#include "db/entitymanager.h"
#include "db/repository/currencyrepository.h"
#include "db/querydsl/private/tree.h"


class EntitiesTest: public QObject
{
    Q_OBJECT
public:
    EntitiesTest();

private slots:
    void currencies();
    void predicates();
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

    QCOMPARE(currencies.size(), 262);
    QCOMPARE(currencies.at(0)->name(), "EUR");
    QCOMPARE(currencies.at(0)->id(), 1);

    auto *nok = new Currency();
    nok->set_id(4);
    nok->set_name("NOK");
    currencyRepository.save(nok);

    QCOMPARE(currencyRepository.count(), 4);

    currencyRepository.deleteById(4);
}

void EntitiesTest::predicates()
{
    auto currency = Currency();
    auto exp = currency.q_alphabeticCode.contains("U").AND(currency.q_alphabeticCode.contains("R"));

    QCOMPARE( QString("name LIKE \'%U%\' AND name LIKE \'%R%\'") , exp.getQuery());

    auto entity = currencyRepository.findOne( currency.q_alphabeticCode.containsIgnoreCase("eu") );
    QTEST_ASSERT(entity != nullptr);
    QCOMPARE(entity->name(), "EUR");

    entity = currencyRepository.findOne( currency.q_alphabeticCode.eq("CUC") );
    QTEST_ASSERT(entity != nullptr);
    QCOMPARE(entity->name(), "CUC");

    entity = currencyRepository.findOne( currency.q_alphabeticCode.eqIgnoreCase("SeK") );
    QTEST_ASSERT(entity != nullptr);
    QCOMPARE(entity->name(), "SEK");

    entity = currencyRepository.findOne( currency.q_alphabeticCode.startWith("S") );
    QTEST_ASSERT(entity != nullptr);
    QCOMPARE(entity->name(), "SEK");

    entity = currencyRepository.findOne( currency.q_alphabeticCode.endWith("C") );
    QTEST_ASSERT(entity != nullptr);
    QCOMPARE(entity->name(), "CUC");

    QCOMPARE( currencyRepository.count( currency.q_alphabeticCode.neq("CUC")  ),  2 );
    QCOMPARE( currencyRepository.count( currency.q_id.between(150, 360) ),  30 );
    QCOMPARE( currencyRepository.count( currency.q_id.gt(1000)         ),  0 );
    QCOMPARE( currencyRepository.count( currency.q_id.lt(300)         ),  50 );
}

void EntitiesTest::cleanupTestCase()
{
    QDir dataDir(QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation));
    QString dbFile = dataDir.filePath("monthlyfinance.db");

    dataDir.remove(dbFile);
}

QTEST_MAIN(EntitiesTest)
#include "entitiestest.moc"
