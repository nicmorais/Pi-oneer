#include "musicplaymanager.hpp"

#include <QQmlContext>

MusicPlayManager::MusicPlayManager(QObject *parent)
	: QObject{parent}
{
	m_status = "paused";
	m_player      = new QMediaPlayer{this};
	m_audioOutput = new QAudioOutput{this};
	m_player->setAudioOutput(m_audioOutput);
	m_audioOutput->setVolume(m_volume);
	connect(m_player, &QMediaPlayer::positionChanged, this, [&]() {
		m_position = m_player->position();
		Q_EMIT positionChanged();
	});

	connect(m_player, &QMediaPlayer::errorChanged, this, [this]() {
		qDebug() << m_player->errorString();
	});
}

int MusicPlayManager::position() const
{
	return m_player->position();
}

int MusicPlayManager::duration() const
{
	return m_player->duration();
}

TrackModel MusicPlayManager::currentTrack() const
{
	return m_currentTrack;
}

void MusicPlayManager::setCurrentTrack(const TrackModel& track)
{
	m_currentTrack = track;
}

QString MusicPlayManager::status() const
{
	return m_status;
}

int MusicPlayManager::volume() const
{
	return m_volume;
}

void MusicPlayManager::setVolume(int volume)
{
	m_volume = volume;
}

void MusicPlayManager::play(const TrackModel& track)
{
	m_player->setSource(QUrl::fromLocalFile(track.path()));
	m_player->play();
	m_status = "playing";
	m_currentTrack = track;
	Q_EMIT statusChanged();
	Q_EMIT currentTrackChanged();
}

void MusicPlayManager::pause()
{
	m_player->pause();
	m_status = "paused";
	Q_EMIT statusChanged();
}

void MusicPlayManager::resume()
{
	if (m_currentTrack.path().isEmpty()) {
		return;
	}
	m_player->play();
	m_status = "playing";
	Q_EMIT statusChanged();
}
