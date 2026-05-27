using Godot;

namespace RhythmSyncLocal.Core
{
	// Registrar como Autoload en Project > Project Settings > Autoload
	// Nombre: GameEvents
	public partial class GameEvents : Node
	{
		public static GameEvents Instance { get; private set; }

		[Signal] public delegate void BeatTickedEventHandler(int beatNumber);
		[Signal] public delegate void ScoreUpdatedEventHandler(int playerId, int newScore);
		[Signal] public delegate void GameStateChangedEventHandler(string newState);
		[Signal] public delegate void PlayerConnectedEventHandler(int playerId);
		[Signal] public delegate void SyncEventReceivedEventHandler(string eventJson);

		public override void _Ready()
		{
			Instance = this;
		}

		// Llamado desde cualquier Thread de forma segura
		public void EmitBeatSafe(int beat)
		{
			CallDeferred(MethodName.EmitSignal, SignalName.BeatTicked, beat);
		}

		public void EmitScoreSafe(int playerId, int score)
		{
			CallDeferred(MethodName.EmitSignal, SignalName.ScoreUpdated, playerId, score);
		}

		public void EmitStateSafe(string state)
		{
			CallDeferred(MethodName.EmitSignal, SignalName.GameStateChanged, state);
		}
	}
}
