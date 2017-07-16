#include "downloader.h"

Downloader::Downloader(QObject *parent) : QObject(parent){

}

void Downloader::startDownloading(QString typ){

    QNetworkAccessManager mgr;
    QString u;
    QString name;
    if (typ == "css"){
        u = "http://d740fw1da.c0.pl/java.zip";
        name = "css";
    }
    if (typ == "hl2ep1"){
        u = "http://d740fw1da.c0.pl/java.zip";
        name = "hl2ep1";
    }
    if (typ == "hl2ep2"){
        u = "http://d740fw1da.c0.pl/java.zip";
        name = "hl2ep2";
    }
    currDownloading = name;

    QNetworkRequest req(u);

    QSslConfiguration conf = req.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    req.setSslConfiguration(conf);


    QNetworkReply *reply = mgr.get(req);
    connect(reply, SIGNAL(downloadProgress(qint64,qint64)), this, SLOT(networkReplyProgress(qint64,qint64)));
    connect(reply, SIGNAL(finished()), this, SLOT(downloadingFinishedSlot()));
    eventLoop.exec();

    if (reply->error() == QNetworkReply::NoError) {
        QString url = getSteamFolder().append("/steamapps/common/GarrysMod/garrysmod/addons/").append(name).append(".zip");
        url.remove(0,8);
        qDebug() << url;
        QFile file(url);

        file.open(QIODevice::WriteOnly );
        file.write(reply->readAll());
        file.close();
        qDebug() << "File downloaded.";
        delete reply;
    }
    else {
        qDebug() << "Error while downloading file " <<reply->errorString();
        delete reply;
    }
}

void Downloader::networkReplyProgress(qint64 curr, qint64 max){
    emit progressRecived(curr, max, currDownloading);
}

//Getters and setters
QString Downloader::getSteamFolder() const{ return steamFolder; }
void Downloader::setDownloadName(const QString &value) { downloadName = value; }

void Downloader::downloadingFinishedSlot(){
    eventLoop.exit();
    emit downloadingFinished(currDownloading);
}

QString Downloader::getCurrDownloading() const
{
    return currDownloading;
}
void Downloader::setSteamFolder(const QString &value){ steamFolder = value; }
void Downloader::setDownloadUrl(const QString &value){ downloadUrl = value; }
