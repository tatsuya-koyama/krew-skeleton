package __PACKAGE_NAME__.actor.game {

    import starling.text.TextField;

    import krewfw.core.KrewActor;
    import krewfw.utils.starling.TextFactory;

    //------------------------------------------------------------
    public class NiceLogo extends KrewActor {

        //------------------------------------------------------------
        public override function init():void {
            addText(_makeLogo(), 0, 50 + 3);
        }

        private function _makeLogo():TextField {
            var text:TextField = TextFactory.makeText(
                480, 120, "GREAT AWESOME\nNICE GAME\n SCREEN", 28, "tk_cooper", 0xffffaa,
                0, 0, "center", "top", false
            );
            return text;
        }
    }
}
