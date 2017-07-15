#ifndef DOWNLOADER_H
#define DOWNLOADER_H

#include <QObject>
#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QUrlQuery>
#include <QThread>
#include <QEventLoop>
#include <QFile>

class Downloader : public QObject
{
    Q_OBJECT
public:
    explicit Downloader(QObject *parent = nullptr);
    QNetworkReply *reply;
    QEventLoop eventLoop;


    QString getDownloadUrl() const;
    QString getSteamFolder() const;


    QString getDownloadName() const;


signals:
    void progressRecived(int curr, int max);
public slots:
    void startDownloading();
    void networkReplyProgress(qint64 curr,qint64 max);
    void setDownloadUrl(const QString &value);
    void setSteamFolder(const QString &value);
    void setDownloadName(const QString &value);
private:
    QString downloadUrl;
    QString steamFolder;
    QString downloadName;

public slots:
};

#endif // DOWNLOADER_H
