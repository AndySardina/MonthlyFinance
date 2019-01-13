#include "db/entitymanager.h"

#include <stdexcept>

#include <QStandardPaths>
#include <QDebug>
#include <QFileInfo>
#include <QDir>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDirIterator>

void EntityManager::initConection()
{
    QDir dataDir(QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation));
    dataDir.mkpath(dataDir.path());

    QString dbFile = dataDir.filePath("monthlyfinance.db");
    bool initialize = !QFileInfo::exists(dbFile);

    qDebug() << dbFile;

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(dbFile);

    if (!db.open()) {
        throw std::runtime_error("Cannot open database. Unable to establish a database connection.");
    }

    if(initialize)
        initializeDB();
}

void EntityManager::initializeDB()
{
    auto fileReader = [](const QString& fileName){
        QFile f(fileName);
        QString content;

        if (f.open(QFile::ReadOnly | QFile::Text)){
            QTextStream in(&f);
            content = in.readAll();
        }

        return content;
    };

    auto applyScript = [&](const QString& fileName){
        qDebug() << "Applying script: " << fileName;
        QString content = fileReader(fileName);

        QSqlQuery query;
        query.exec(content);

        QSqlError error = query.lastError();
        if( error.isValid() )
            throw std::runtime_error(error.text().toStdString());
    };


    auto applyScripts = [&](const QString& dirName){
        QDir dir (dirName);

        for(QString& file : dir.entryList(QDir::Files)) {
            applyScript( dir.filePath(file) );
        }
    };

    applyScripts(":/resources/schema");
    applyScripts(":/resources/data");

}
