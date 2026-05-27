using Godot;
using System.Threading;
using RhythmSyncLocal.Core;

namespace RhythmSyncLocal.Engine
{
	public partial class BeatEngine : Node
	{
		private Thread _beatThread;
		private bool _running = false;
		private int _bpm = 120;
		private int _currentBeat = 0;

		// Intervalo entre beats en milisegundos
		private int BeatInterval => 60000 / _bpm;

		public void Start(int bpm)
		{
			_bpm = bpm;
			_running = true;
			_currentBeat = 0;

			_beatThread = new Thread(BeatLoop)
			{
				IsBackground = true,
				Priority = ThreadPriority.Highest,
				Name = "BeatEngineThread"
			};
			_beatThread.Start();
		}

		public void Stop()
		{
			_running = false;
			_beatThread?.Join(500);
		}

		private void BeatLoop()
		{
			while (_running)
			{
				var start = System.DateTime.UtcNow;

				_currentBeat++;
				// Notificar a la UI de forma segura desde el Thread
				GameEvents.Instance.EmitBeatSafe(_currentBeat);

				// Compensar el tiempo que tomó ejecutar el código
				var elapsed = (System.DateTime.UtcNow - start).TotalMilliseconds;
				var sleep = BeatInterval - (int)elapsed;
				if (sleep > 0) Thread.Sleep(sleep);
			}
		}

		public override void _ExitTree()
		{
			Stop();
		}
	}
}
