package __PACKAGE_NAME__.actor.title {

    import starling.text.TextField;

    import krewfw.core.KrewActor;
    import krewfw.utils.starling.TextFactory;

    //------------------------------------------------------------
    public class TitleLogo extends KrewActor {

        //------------------------------------------------------------
        public override function init():void {
            var text:TextField = _makeTitleLogo();
            addText(text, 0, 90 + 3);

            alpha = 0;
            act().alphaTo(0.4, 1);
            act().moveEaseOut(0.5, 0, -3);
        }

        private function _makeTitleLogo():TextField {
            var text:TextField = TextFactory.makeText(
                480, 100, "TITLE LOGO", 30, "tk_cooper", 0xffcc55,
                0, 0, "center", "top", false
            );
            return text;
        }
    }
}
