#include "trackmodel.hpp"

#include <QVariantMap>

TrackModel::TrackModel(QObject* parent) : QObject{parent} {}

TrackModel::TrackModel(const TrackModel& other)
{
	m_title  = other.title();
	m_artist = other.artist();
	m_path   = other.path();
}

TrackModel::TrackModel(const QJSValue&)
{
	qDebug() << "qjsvalue constructor called";
}

QString TrackModel::title() const
{
	return m_title;
}

void TrackModel::setTitle(const QString& title)
{
	m_title = title;
}

QString TrackModel::path() const
{
	return m_path;
}

void TrackModel::setPath(const QString& path)
{
	m_path = path;
}

QString TrackModel::artist() const
{
	return m_artist;
}

void TrackModel::setArtist(const QString& artist)
{
	m_artist = artist;
}

void TrackModel::operator=(const TrackModel& other)
{
	m_title = other.title();
	m_artist = other.artist();
	m_path   = other.path();
}

QVariantMap TrackModel::toVariantMap() const
{
	QVariantMap variantMap;
	variantMap["title"] = title();
	variantMap["path"]  = path();
	return variantMap;
}
