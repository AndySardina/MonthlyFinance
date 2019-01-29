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

    QCOMPARE(currencies.size(), 179);
    QCOMPARE(currencies.at(1)->alphabeticCode(), "EUR");
    QCOMPARE(currencies.at(1)->id(), 2);
}

void EntitiesTest::predicates()
{
    auto currency = Currency();
    auto exp = currency.q_alphabeticCode.contains("U").AND(currency.q_alphabeticCode.contains("R"));

    QCOMPARE( QString("alphabetic_code LIKE \'%U%\' AND alphabetic_code LIKE \'%R%\'") , exp.getQuery());

    auto entity = currencyRepository.findOne( currency.q_alphabeticCode.containsIgnoreCase("eu") );
    QTEST_ASSERT(entity != nullptr);
    QCOMPARE(entity->alphabeticCode(), "EUR");

    entity = currencyRepository.findOne( currency.q_alphabeticCode.eq("CUC") );
    QTEST_ASSERT(entity != nullptr);
    QCOMPARE(entity->alphabeticCode(), "CUC");

    entity = currencyRepository.findOne( currency.q_alphabeticCode.eqIgnoreCase("SeK") );
    QTEST_ASSERT(entity != nullptr);
    QCOMPARE(entity->alphabeticCode(), "SEK");

    entity = currencyRepository.findOne( currency.q_alphabeticCode.startWith("SE") );
    QTEST_ASSERT(entity != nullptr);
    QCOMPARE(entity->alphabeticCode(), "SEK");

    entity = currencyRepository.findOne( currency.q_alphabeticCode.endWith("UC") );
    QTEST_ASSERT(entity != nullptr);
    QCOMPARE(entity->alphabeticCode(), "CUC");

    QCOMPARE( currencyRepository.count( currency.q_alphabeticCode.neq("CUC")      ),  178 );
    QCOMPARE( currencyRepository.count( currency.q_numericCode.between(150, 370)  ),   30 );
    QCOMPARE( currencyRepository.count( currency.q_numericCode.gt(1000)           ),    0 );
    QCOMPARE( currencyRepository.count( currency.q_numericCode.lt(360)            ),   50 );
}

void EntitiesTest::cleanupTestCase()
{
    QDir dataDir(QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation));
    QString dbFile = dataDir.filePath("monthlyfinance.db");

    dataDir.remove(dbFile);
}

QTEST_MAIN(EntitiesTest)
#include "entitiestest.moc"
