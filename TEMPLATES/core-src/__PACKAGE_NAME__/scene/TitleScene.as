package __PACKAGE_NAME__.scene {

    import starling.text.TextField;

    import krewfw.core.KrewScene;
    import krewfw.builtin_actor.display.ScreenCurtain;

    import __PACKAGE_NAME__.GameEvent;
    import __PACKAGE_NAME__.actor.title.*;

    //------------------------------------------------------------
    public class TitleScene extends KrewScene {

        private var _loadingBg:ScreenCurtain;

        //------------------------------------------------------------
        public override function getRequiredAssets():Array {
            return [
                 "image/atlas_game.png"
                ,"image/atlas_game.xml"
            ];
        }

        public override function getLayerList():Array {
            return ['l-back', 'l-front', 'l-ui', 'l-filter'];
        }

        public override function initLoadingView():void {
            var color:int = 0x000000;
            _loadingBg = new ScreenCurtain(color, color, color, color);
            setUpActor('l-back', _loadingBg);
        }

        public override function onLoadComplete():void {
            _loadingBg.passAway();
        }

        public override function initAfterLoad():void {
            var color:int = 0x555555;
            setUpActor('l-back', new ScreenCurtain(color, color, color, color));

            setUpActor('l-ui',   new TitleLogo());
            setUpActor('l-ui',   new StartButton());

            blackIn(0.5);

            listen(GameEvent.EXIT_SCENE, onSceneTransition);
        }

        protected function onSceneTransition(args:Object):void {
            whiteOut(0.3);
            addScheduledTask(0.3, function():void {
                exit();
            });
        }

        public override function getDefaultNextScene():KrewScene {
            return new GameScene();
        }
    }
}
