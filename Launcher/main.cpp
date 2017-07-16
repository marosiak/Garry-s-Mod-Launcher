#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <./Class/downloader.h>
#include <./Class/unzipper.h>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Downloader downloader;
    Unzipper unzipper;
    QQmlContext* ctx = engine.rootContext();
    ctx->setContextProperty("downloader", &downloader);
    ctx->setContextProperty("unzipper", &unzipper);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
