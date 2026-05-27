using Godot;
using RhythmSyncLocal.Core;
using RhythmSyncLocal.Models;

namespace RhythmSyncLocal.ViewModels
{
	public partial class GameViewModel : Node
	{
		private GameSessionModel _session = new();

		private Label _beatLabel;
		private Label _syncStatusLabel;
		private Label _player1ScoreLabel;
		private Label _player2ScoreLabel;

		public override void _Ready()
		{
			_beatLabel         = GetNode<Label>("UI/BeatLabel");
			_syncStatusLabel   = GetNode<Label>("UI/SyncStatusLabel");
			_player1ScoreLabel = GetNode<Label>("UI/Player1Score");
			_player2ScoreLabel = GetNode<Label>("UI/Player2Score");

			// Escuchar signals globales
			GameEvents.Instance.BeatTicked    += OnBeatTicked;
			GameEvents.Instance.ScoreUpdated  += OnScoreUpdated;
		}

		// Llamado desde el BeatEngine (Thread secundario) via GameEvents
		private void OnBeatTicked(int beatNumber)
		{
			_session.CurrentBeat = beatNumber;
			_beatLabel.Text = $"Beat: {beatNumber}";
		}

		private void OnScoreUpdated(int playerId, int newScore)
		{
			if (playerId == 1) _player1ScoreLabel.Text = $"J1: {newScore}";
			else               _player2ScoreLabel.Text = $"J2: {newScore}";
		}

		// Llamado cuando el jugador presiona su tecla
		public override void _Input(InputEvent @event)
		{
			if (@event.IsActionPressed("player1_hit")) OnHitNote(1);
			if (@event.IsActionPressed("player2_hit")) OnHitNote(2);
		}

		private void OnHitNote(int playerId)
		{
			// miércoles 27 may + martes 2 jun
		}

		public override void _ExitTree()
		{
			// Desconectar signals al salir
			GameEvents.Instance.BeatTicked   -= OnBeatTicked;
			GameEvents.Instance.ScoreUpdated -= OnScoreUpdated;
		}
	}
}
