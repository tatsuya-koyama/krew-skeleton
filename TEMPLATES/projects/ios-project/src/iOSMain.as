package {

    import flash.display.Sprite;
    import krewfw.KrewConfig;
    import krewfw.utils.krew;

    /**
     * Customize options or components for iOS publishing.
     */
    public class iOSMain extends Sprite {

        public function iOSMain() {
            krew.log("Kicked from iOSMain");

            KrewConfig.IS_AIR = true;
            KrewConfig.ASSET_URL_SCHEME = "app:/";

            var main:Main = new Main(this);
        }
    }
}
