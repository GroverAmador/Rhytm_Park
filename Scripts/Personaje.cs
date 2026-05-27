using Godot;
using System;


public partial class Personaje : CharacterBody2D
{
	[Export]
	public float Speed{get; set;} = 300.0f;
	[Export]
	public float gravity { get; set; } = 200f;
	[Export]
	public float jumpStrenght { get; set; } = -100f;
	public override void _PhysicsProcess(double delta)
	{
		Vector2 v = Velocity;
		if (!IsOnFloor())
			v.Y += gravity * (float)delta;
		
		var jp = Input.IsActionJustPressed("saltar");
		if(jp && IsOnFloor())
		{
			v.Y = jumpStrenght;
		}
		var direction = Input.GetAxis("izquierda", "derecha");
		if(direction != 0)
		{
            v.X = Speed * direction;
        }
		else
			v.X = 0;
		Velocity = v;
        MoveAndSlide();
    }
}
