#ifndef PROCESS_H
#define PROCESS_H
/*
    Copyright 2019, Prusa Research s.r.o.

    This file is part of testerGui

    testerGui is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include <QProcess>
#include <QVariant>
#include <QDebug>
/* Process wrapper */
class Process : public QProcess {
    Q_OBJECT
public slots:
    void slot_started() {
        qDebug() << "started()";
    }
    void slot_errorOccurred(QProcess::ProcessError x) {
        qDebug() << "errorOccurred(): " << x;
    }
public:
    Process(QObject *parent = 0) : QProcess(parent) { }

    Q_INVOKABLE void start(const QString &program, const QVariantList &arguments) {
        QStringList args;
        qDebug() << "Trying to start " << program;
        // convert QVariantList from QML to QStringList for QProcess

        for (int i = 0; i < arguments.length(); i++) {
            args << arguments[i].toString();
            qDebug() <<  arguments[i].toString();
        }
        connect(this, SIGNAL(started()), this, SLOT(slot_started()));
        connect(this, SIGNAL(errorOccurred(QProcess::ProcessError)), this, SLOT(slot_errorOccurred(QProcess::ProcessError)));
        QProcess::start(program, args, QProcess::Unbuffered  | QProcess::ReadWrite);
        QProcess::waitForStarted(2000);
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
