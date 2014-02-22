package __PACKAGE_NAME__.actor.title {

    import starling.display.Image;
    import starling.text.TextField;
    import starling.animation.Transitions;

    import krewfw.core.KrewActor;
    import krewfw.core.KrewBlendMode;
    import krewfw.utils.starling.TextFactory;
    import krewfw.builtin_actor.ui.TextButton;

    import __PACKAGE_NAME__.GameEvent;

    //------------------------------------------------------------
    public class StartButton extends KrewActor {

        //------------------------------------------------------------
        public override function init():void {
            touchable = true;

            // make text button
            var textField:TextField = TextFactory.makeText(
                480, 60, "Tap to Start", 26, "tk_cooper", 0xffffff,
                0, 180 + 3, 'center', 'center', true
            );

            var textButton:TextButton = new TextButton(textField, function():void {
                touchable = false;
                sendMessage(GameEvent.EXIT_SCENE);
            });

            addActor(textButton);

            // blink animation
            var blinkSlowlyLoop:Function = function():void {
                act().blink(textButton, 1.2).doit(0, blinkSlowlyLoop);
            };
            act().doit(0, blinkSlowlyLoop);

            // appear animation
            alpha = 0;
            act().alphaTo(0.4, 1);
            act().move(0.5, 0, -3, Transitions.EASE_IN_OUT);
        }

    }
}
