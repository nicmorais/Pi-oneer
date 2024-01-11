#ifndef TRACKMODEL_HPP
#define TRACKMODEL_HPP

#include <QJSValue>
#include <QObject>
/**
 * @brief simple model class for songs, also known as tracks.
 */
class TrackModel : public QObject
{
	Q_GADGET
public:
	Q_PROPERTY(QString title READ title WRITE setTitle)
	Q_PROPERTY(QString path READ path WRITE setPath)
	//	Q_PROPERTY(int length READ length WRITE setLength)
	Q_PROPERTY(QString artist READ artist WRITE setArtist)
	//	Q_PROPERTY(QString album READ album WRITE album)
	explicit TrackModel(QObject* parent = nullptr);
	TrackModel(const TrackModel&);
	TrackModel(const QJSValue&);

	QString title() const;
	void setTitle(const QString&);
	QString path() const;
	void setPath(const QString&);
	QString artist() const;
	void setArtist(const QString&);

	void operator=(const TrackModel&);
	QVariantMap toVariantMap() const;

private:
	QString m_title;
	QString m_path;
	QString m_artist;
};

#endif // TRACKMODEL_HPP
