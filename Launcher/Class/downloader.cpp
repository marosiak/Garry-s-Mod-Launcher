#include "downloader.h"

Downloader::Downloader(QObject *parent) : QObject(parent){

}

void Downloader::startDownloading(){
    QNetworkAccessManager mgr;
    QNetworkRequest req( getDownloadUrl() );



    QSslConfiguration conf = req.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    req.setSslConfiguration(conf);


    QNetworkReply *reply = mgr.get(req);
    connect(reply, SIGNAL(downloadProgress(qint64,qint64)), this, SLOT(networkReplyProgress(qint64,qint64)));
    eventLoop.exec();
    if (reply->error() == QNetworkReply::NoError) {
        QString url = getSteamFolder().append("steamapps/common/GarrysMod/garrysmod/addons/").append(getDownloadName()).append(".zip");
        url.remove(0,8);
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
    emit progressRecived(curr, max);
}

//Getters and setters
QString Downloader::getDownloadName() const { return downloadName; }
QString Downloader::getSteamFolder() const{ return steamFolder; }
QString Downloader::getDownloadUrl() const { return downloadUrl; }
void Downloader::setDownloadName(const QString &value) { downloadName = value; }
void Downloader::setSteamFolder(const QString &value){ steamFolder = value; }
void Downloader::setDownloadUrl(const QString &value){ downloadUrl = value; }
