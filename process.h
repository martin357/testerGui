#ifndef PROCESS_H
#define PROCESS_H
#include <QProcess>
#include <QVariant>
#include <QDebug>

class Process : public QProcess {
    Q_OBJECT

public:
    Process(QObject *parent = 0) : QProcess(parent) { }

    Q_INVOKABLE void start(const QString &program, const QVariantList &arguments) {
        QStringList args;
        qDebug() << "Trying to start " << program;
        // convert QVariantList from QML to QStringList for QProcess

        for (int i = 0; i < arguments.length(); i++)
            args << arguments[i].toString();

        QProcess::start(program, args);
    }

    Q_INVOKABLE QByteArray readAll() {
        return QProcess::readAll();
    }
    Q_INVOKABLE QByteArray readAllStandardError() {
        return QProcess::readAllStandardError();
    }
    Q_INVOKABLE QByteArray readAllStandardOutput() {
        return QProcess::readAllStandardOutput();
    }
    Q_INVOKABLE void kill() {
        QProcess::kill();
    }
    Q_INVOKABLE void terminate() {
        QProcess::terminate();
    }


};
#endif // PROCESS_H
