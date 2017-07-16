#include "unzipper.h"

Unzipper::Unzipper(QObject *parent) : QObject(parent)
{

}

void Unzipper::joinServer(QString ipAdress){
    QString cmd = getSteamPath().append("/steamapps/common/GarrysMod/hl2.exe"); cmd.remove(0,8);
    QStringList arguments;
    arguments << "+connect" << ipAdress;
    QProcess *myProcess = new QProcess();
     myProcess->start(cmd, arguments);
}

QString Unzipper::getSteamPath() const{return steamPath;}

void Unzipper::setSteamPath(const QString &value){steamPath = value;}

bool Unzipper::isInstalled(QString typ){
    QString path;
    if (typ == "css"){
        path = getSteamPath().append("/steamapps/common/GarrysMod/garrysmod/addons/css/");
    }
    if (typ == "hl2ep1"){
        path = getSteamPath().append("/steamapps/common/GarrysMod/garrysmod/addons/hl2ep1/");
    }
    if (typ == "hl2ep2"){
        path = getSteamPath().append("/steamapps/common/GarrysMod/garrysmod/addons/hl2ep2/");
    }
    qDebug() << path;
    path.remove(0,8);
    return QDir(path).exists();
}

void Unzipper::unzip(){
    QString path, extractPath;
    path = getSteamPath().append("/steamapps/common/GarrysMod/garrysmod/addons/css.zip"); path.remove(0,8);
    extractPath = getSteamPath().append("/steamapps/common/GarrysMod/garrysmod/addons/css/"); extractPath.remove(0,8);
    JlCompress::extractDir(path, extractPath);
    QFile::remove(path);

    path = getSteamPath().append("/steamapps/common/GarrysMod/garrysmod/addons/hl2ep1.zip"); path.remove(0,8);
    extractPath = getSteamPath().append("/steamapps/common/GarrysMod/garrysmod/addons/hl2ep1/"); extractPath.remove(0,8);
    JlCompress::extractDir(path, extractPath);
    QFile::remove(path);

    path = getSteamPath().append("/steamapps/common/GarrysMod/garrysmod/addons/hl2ep2.zip"); path.remove(0,8);
    extractPath = getSteamPath().append("/steamapps/common/GarrysMod/garrysmod/addons/hl2ep2/"); extractPath.remove(0,8);
    JlCompress::extractDir(path, extractPath);
    QFile::remove(path);

}
