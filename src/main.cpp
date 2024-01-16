#include "musicplaymanager.hpp"
#include "musictablemodel.hpp"
#include "trackmodel.hpp"
#include "vncitem.hpp"

#include <QDir>
#include <QFileInfo>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <iostream>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
	QGuiApplication app(argc, argv);
	app.setApplicationName("pi-oneer");
	app.setOrganizationName("Pi-oneer");

	qmlRegisterType<VncItem>("pioneer", 1, 0, "VncItem");
	qmlRegisterType<MusicTableModel>("pioneer", 1, 0, "MusicTableModel");
	qmlRegisterType<TrackModel>("pioneer", 1, 0, "TrackModel");
	qmlRegisterType<MusicPlayManager>("pioneer", 1, 0, "MusicPlayManager");
	qputenv("QT_QUICK_CONTROLS_STYLE", "Material");
	qputenv("QT_QUICK_CONTROLS_MATERIAL_THEME", "Dark");

	QQmlApplicationEngine engine;

	const QUrl url(QStringLiteral("qrc:/pioneer/src/main.qml"));
	QObject::connect(
		&engine, &QQmlApplicationEngine::objectCreated, &app,
		[url](QObject* obj, const QUrl& objUrl) {
			if (!obj && url == objUrl)
				QCoreApplication::exit(-1);
		},
		Qt::QueuedConnection);
	engine.load(url);

	return app.exec();
}
