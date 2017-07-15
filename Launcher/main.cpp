#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <./Class/downloader.h>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Downloader downloader;
          QQmlContext* ctx = engine.rootContext();
          ctx->setContextProperty("downloader", &downloader);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
