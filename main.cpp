#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QLocale>
#include "process.h"

static QJSValue getIPs(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)

    QString IPs;
    const QHostAddress &localhost = QHostAddress(QHostAddress::LocalHost);
    for (const QHostAddress &address: QNetworkInterface::allAddresses()) {
        if (address.protocol() == QAbstractSocket::IPv4Protocol && address != localhost) {
             qDebug() << address.toString();
             IPs += address.toString() + "\n";
        }

    }
    QJSValue appInfo = scriptEngine->newObject();
    appInfo.setProperty("IPs", IPs);
    return appInfo;
}

int main(int argc, char *argv[])
{
    qmlRegisterType<Process>("Process", 1, 0, "Process");
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterSingletonType("Native", 1, 0, "AppInfo", getIPs);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
