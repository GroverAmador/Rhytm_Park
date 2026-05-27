using Godot;
using RhythmSyncLocal.Core;

namespace RhythmSyncLocal.ViewModels
{
	public partial class MenuViewModel : Node
	{
		// Referencias a nodos de la escena (se asignan en _Ready)
		private Label _statusLabel;
		private Button _hostButton;
		private Button _joinButton;

		private string _statusMessage = "Esperando conexión...";
		public string StatusMessage
		{
			get => _statusMessage;
			set
			{
				_statusMessage = value;
				// Actualizar UI de forma segura
				if (_statusLabel != null)
					_statusLabel.CallDeferred("set_text", value);
			}
		}

		public override void _Ready()
		{
			// Obtener referencias a nodos de la escena
			_statusLabel = GetNode<Label>("UI/StatusLabel");
			_hostButton  = GetNode<Button>("UI/HostButton");
			_joinButton  = GetNode<Button>("UI/JoinButton");

			// Conectar signals de botones (equivalente a Commands en MVVM)
			_hostButton.Pressed += OnHostGame;
			_joinButton.Pressed += OnJoinGame;

			_statusLabel.Text = _statusMessage;
		}

		private void OnHostGame()
		{
			StatusMessage = "Iniciando como host...";
			// lunes 1 jun: aquí va la lógica de TcpListener
		}

		private void OnJoinGame()
		{
			StatusMessage = "Conectando al host...";
			// lunes 1 jun: aquí va la lógica de TcpClient
		}
	}
}
