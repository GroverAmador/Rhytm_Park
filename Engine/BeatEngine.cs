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

		private DateTime _startTime;
		private List<double> _timestampsReales = new List<double>();
		private const int BEATS_DE_PRUEBA = 10;
		
		public void Start(int bpm)
		{
			_bpm = bpm;
			_running = true;
			_currentBeat = 0;
			_startTime = DateTime.UtcNow;
			

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
				// Registramos cuántos ms pasaron desde el inicio
				double tiempoReal = (DateTime.UtcNow - _startTime).TotalMilliseconds;
				_timestampsReales.Add(tiempoReal);
				// Notificar a la UI de forma segura desde el Thread
				GameEvents.Instance.EmitBeatSafe(_currentBeat);

				if (_currentBeat == BEATS_DE_PRUEBA) {
					MedirJitter();
					_runnig = false
					break;
				}
				// Compensar el tiempo que tomó ejecutar el código
				var elapsed = (System.DateTime.UtcNow - start).TotalMilliseconds;
				var sleep = BeatInterval - (int)elapsed;
				if (sleep > 0) Thread.Sleep(sleep);
			}
		}
		 private void MedirJitter()
		{
			GD.PrintT("=== RESULTADOS DE PRUEBA DE JITTER ===");
			GD.PrintT($"BPM: {_bpm} | Intervalo esperado: {BeatInterval}ms");
			GD.PrintT("--------------------------------------");

			double jitterTotal = 0;
			double jitterMax = 0;

			for (int i = 0; i < _timestampsReales.Count; i++)
			{
				// Cuándo debería haber ocurrido este beat en teoría
				double tiempoEsperado = (i + 1) * BeatInterval;
				// Cuándo ocurrió realmente
				double tiempoReal = _timestampsReales[i];
				// La diferencia es el jitter de ese beat
				double jitter = Math.Abs(tiempoReal - tiempoEsperado);

				jitterTotal += jitter;
				if (jitter > jitterMax) jitterMax = jitter;

				string estado = jitter < 20 ? "✅" : "⚠️";
				GD.PrintT($"Beat {i + 1}: esperado={tiempoEsperado}ms | real={tiempoReal:F1}ms | jitter={jitter:F1}ms {estado}");
			}

			double jitterPromedio = jitterTotal / _timestampsReales.Count;
			GD.PrintT("--------------------------------------");
			GD.PrintT($"Jitter promedio: {jitterPromedio:F1}ms");
			GD.PrintT($"Jitter máximo:   {jitterMax:F1}ms");
			GD.PrintT(jitterPromedio < 20 ? "RESULTADO: ✅ Motor apto para el juego" : "RESULTADO: ⚠️ Jitter alto, revisar compensación");
			GD.PrintT("======================================");
		}
		public override void _ExitTree()
		{
			Stop();
		}
	}
}
