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
    QString getSteamFolder() const;


signals:
    void progressRecived(int curr, int max, QString contentName);
    void downloadingFinished(QString typ);
public slots:
    void startDownloading(QString typ);
    void networkReplyProgress(qint64 curr,qint64 max);
    void setDownloadUrl(const QString &value);
    void setSteamFolder(const QString &value);
    void setDownloadName(const QString &value);
    void downloadingFinishedSlot();
    QString getCurrDownloading() const;
private:
    QString downloadUrl;
    QString steamFolder;
    QString downloadName;
    QString currDownloading;
    QEventLoop eventLoop;

public slots:
};

#endif // DOWNLOADER_H
