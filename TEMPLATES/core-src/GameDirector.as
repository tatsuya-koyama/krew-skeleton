package {

    import krewfw.core.KrewScene;
    import krewfw.core.KrewGameDirector;

    import __PACKAGE_NAME__.scene.TitleScene;

    //------------------------------------------------------------
    public class GameDirector extends KrewGameDirector {

        //------------------------------------------------------------
        public function GameDirector() {
            var firstScene:KrewScene = new TitleScene();
            startGame(firstScene);
        }

        protected override function getInitialGlobalAssets():Array {
            return [
                 'bmp_font/tk_cooper.png'
                ,'bmp_font/tk_cooper.fnt'
            ];
        }
    }
}
