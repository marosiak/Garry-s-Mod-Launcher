#ifndef UNZIPPER_H
#define UNZIPPER_H

#include <QObject>
#include <QString>
#include <QDebug>
#include <JlCompress.h>
#include <QProcess>

class Unzipper : public QObject{
    Q_OBJECT
public:
    explicit Unzipper(QObject *parent = nullptr);

private:
    QString steamPath;
signals:

public slots:
    void joinServer(QString ipAdress);
    QString getSteamPath() const;
    void setSteamPath(const QString &value);
    bool isInstalled(QString typ);
    void unzip();
};

#endif // UNZIPPER_H
