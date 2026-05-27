using System.Collections.Generic;

namespace RhythmSyncLocal.Models
{
	public enum GameState { WaitingForPlayers, Countdown, Playing, Finished }

	public class GameSessionModel
	{
		public GameState State { get; set; } = GameState.WaitingForPlayers;
		public int Bpm { get; set; } = 120;
		public List<NoteModel> Notes { get; set; } = new();
		public PlayerModel Player1 { get; set; } = new() { Id = 1, Name = "Jugador 1" };
		public PlayerModel Player2 { get; set; } = new() { Id = 2, Name = "Jugador 2" };
		public int CurrentBeat { get; set; }
		public bool IsCoopSyncActive { get; set; }
	}
}
