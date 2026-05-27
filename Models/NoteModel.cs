namespace RhythmSyncLocal.Models
{
	public enum NoteResult { None, Perfect, Good, Miss }

	public class NoteModel
	{
		public double BeatTime { get; set; }
		public bool IsHit { get; set; }
		public NoteResult Result { get; set; } = NoteResult.None;
		public int AssignedPlayerId { get; set; }
	}
}
