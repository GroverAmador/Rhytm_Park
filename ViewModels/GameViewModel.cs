using Godot;
using RhythmSyncLocal.Core;
using RhythmSyncLocal.Models;

namespace RhythmSyncLocal.ViewModels
{
	public partial class GameViewModel : Node
	{
		private Label _beatLabel;
		private Label _syncStatusLabel;
		private Label _player1ScoreLabel;
		private Label _player2ScoreLabel;

		private GameSessionModel _session = new GameSessionModel();
		private int _currentBeat = 0;
		private string _syncStatus = "Waiting...";

		public override void _Ready()
		{
			// Comentado hasta que exista GameView.tscn (jueves 4 jun)
			// _beatLabel         = GetNode<Label>("UI/BeatLabel");
			// _syncStatusLabel   = GetNode<Label>("UI/SyncStatusLabel");
			// _player1ScoreLabel = GetNode<Label>("UI/Player1Score");
			// _player2ScoreLabel = GetNode<Label>("UI/Player2Score");

			GameEvents.Instance.BeatTicked      += OnBeatTicked;
			GameEvents.Instance.ScoreUpdated    += OnScoreUpdated;
			GameEvents.Instance.GameStateChanged += OnGameStateChanged;

			GD.Print("GameViewModel ready and subscribed to GameEvents");
			// SOLO PARA PRUEBA — quitar después del viernes 29
var engine = new RhythmSyncLocal.Engine.BeatEngine();
AddChild(engine); // necesario para que _ExitTree funcione en Godot
engine.Start(120);
		}

		private void OnBeatTicked(int beatNumber)
		{
			_currentBeat = beatNumber;
			_session.CurrentBeat = beatNumber;
			_beatLabel?.Set("text", $"Beat: {beatNumber}");
			GD.Print("Beat received: " + beatNumber);
		}

		private void OnScoreUpdated(int playerId, int newScore)
		{
			if (playerId == 1)
				_player1ScoreLabel?.Set("text", $"J1: {newScore}");
			else
				_player2ScoreLabel?.Set("text", $"J2: {newScore}");
		}

		private void OnGameStateChanged(string newState)
		{
			_syncStatus = newState;
			_syncStatusLabel?.Set("text", newState);
			GD.Print("Game state: " + newState);
		}

		public override void _Input(InputEvent @event)
		{
			if (@event.IsActionPressed("player1_hit")) OnHitNote(1);
			if (@event.IsActionPressed("player2_hit")) OnHitNote(2);
		}

		public void OnHitNote(int playerId)
		{
			GD.Print($"Jugador {playerId} presionó en beat {_currentBeat}");
		}

		public override void _ExitTree()
		{
			GameEvents.Instance.BeatTicked      -= OnBeatTicked;
			GameEvents.Instance.ScoreUpdated    -= OnScoreUpdated;
			GameEvents.Instance.GameStateChanged -= OnGameStateChanged;
		}
	}
}
