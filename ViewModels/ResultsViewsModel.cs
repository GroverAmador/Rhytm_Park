using Godot;

namespace RhythmSyncLocal.ViewModels
{
	public partial class ResultsViewModel : Node
	{
		private Label _player1ScoreLabel;
		private Label _player2ScoreLabel;
		private Label _resultMessageLabel;

		public override void _Ready()
		{
			_player1ScoreLabel  = GetNode<Label>("UI/Player1Score");
			_player2ScoreLabel  = GetNode<Label>("UI/Player2Score");
			_resultMessageLabel = GetNode<Label>("UI/ResultMessage");
		}

		public void ShowResults(int p1Score, int p2Score)
		{
			_player1ScoreLabel.Text  = $"Jugador 1: {p1Score}";
			_player2ScoreLabel.Text  = $"Jugador 2: {p2Score}";
			_resultMessageLabel.Text = p1Score >= p2Score
				? "¡Jugador 1 gana!"
				: "¡Jugador 2 gana!";
		}
	}
}
