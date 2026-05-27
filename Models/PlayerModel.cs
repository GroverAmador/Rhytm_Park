namespace RhythmSyncLocal.Models
{
	public class PlayerModel
	{
		public int Id { get; set; }
		public string Name { get; set; } = string.Empty;
		public int Score { get; set; }
		public int Combo { get; set; }
		public bool IsConnected { get; set; }
	}
}
