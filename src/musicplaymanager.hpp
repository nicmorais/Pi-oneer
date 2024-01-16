#ifndef MUSICPLAYMANAGER_HPP
#define MUSICPLAYMANAGER_HPP

#include "trackmodel.hpp"

#include <QAudioOutput>
#include <QMediaPlayer>
#include <QObject>
#include <QQmlEngine>

/**
 * @brief Plays a track, and can also stop or pause it.
 * notifies when the track changes (for playlists)
 */
class MusicPlayManager : public QObject
{
	Q_OBJECT
	Q_PROPERTY(TrackModel currentTrack READ currentTrack WRITE setCurrentTrack
				   NOTIFY currentTrackChanged)
	Q_PROPERTY(int position READ position NOTIFY positionChanged)
	Q_PROPERTY(int duration READ duration NOTIFY durationChanged)
	Q_PROPERTY(QString status READ status NOTIFY statusChanged)
	Q_PROPERTY(float volume READ volume WRITE setVolume NOTIFY volumeChanged)

public:
	explicit MusicPlayManager(QObject* parent = nullptr);
	TrackModel currentTrack() const;
	void setCurrentTrack(const TrackModel&);
	int position() const;
	int duration() const;
	QString status() const;
	float volume() const;
	void setVolume(float);

	Q_INVOKABLE void play(const TrackModel&);
	Q_INVOKABLE void resume();
	Q_INVOKABLE void pause();

private:
	int m_position;
	TrackModel m_currentTrack;
	QMediaPlayer* m_player;
	QAudioOutput* m_audioOutput;
	QString m_status;
	float m_volume;

Q_SIGNALS:
	void currentTrackChanged();
	void positionChanged();
	void durationChanged();
	void statusChanged();
	void volumeChanged();
};

#endif // MUSICPLAYMANAGER_HPP
