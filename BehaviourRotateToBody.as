package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;

	/*
	* fullRotate если true, игнорирует скорость и пределы поворота
	* в правой части нижняя и верхняя границы должны быть одного знака
	*/
	public class BehaviourRotateToBody {
		protected var bodyA:b2Body;
		protected var bodyB:b2Body;
		protected var speedRotate:Number;
		protected var fullRotate:Boolean = false;
		protected var firstReg:b2Vec2;
		protected var secondReg:b2Vec2;
		
		public function BehaviourRotateToBody(_bodyA:b2Body, 
											  _bodyB:b2Body,
											  _firstReg:b2Vec2 = null,
											  _secondReg:b2Vec2 = null,
											  _speedRotate:Number = 1 / 60,
											  _fullRotate:Boolean = false) 
		{
			// constructor code
			bodyA = _bodyA;
			bodyB = _bodyB;
			speedRotate = _speedRotate;
			firstReg = _firstReg;
			secondReg = _secondReg;
			fullRotate = _fullRotate;
		}
		
		public function Update():void
		{			
			var rX:Number = bodyA.GetWorldCenter().x - bodyB.GetWorldCenter().x;
			var rY:Number = bodyA.GetWorldCenter().y - bodyB.GetWorldCenter().y;
			var angleRotBodyB:Number = Math.atan2(rY, rX);
			var difAngle:Number = bodyA.GetAngle() - angleRotBodyB;
			var angle:Number = 0.0;
			
			if(firstReg && secondReg) {
				if(!((angleRotBodyB > firstReg.x && angleRotBodyB < firstReg.y) ||
				   (angleRotBodyB > secondReg.x && angleRotBodyB < secondReg.y))) return;
			} else if(firstReg) if(!(angleRotBodyB > firstReg.x && angleRotBodyB < firstReg.y)) return;
			else if(secondReg) if(!(angleRotBodyB > secondReg.x && angleRotBodyB < secondReg.y)) return;
			
			if(difAngle < 0.001) {
				if(Math.abs(difAngle) > Math.abs(speedRotate)) angle = speedRotate + bodyA.GetAngle();
				else angle = angleRotBodyB;
			} else if(difAngle > 0.001) {
				if(Math.abs(difAngle) > Math.abs(speedRotate)) angle = -speedRotate + bodyA.GetAngle();
				else angle = angleRotBodyB;
			}
			
			if(fullRotate) bodyA.SetAngle(angleRotBodyB);
			else bodyA.SetAngle(angle);
		}
	}
	
}
