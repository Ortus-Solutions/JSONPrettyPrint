component extends="coldbox.system.testing.BaseTestCase" {

    /**
    * @beforeAll
    */
    function registerModuleUnderTest() {
        getController().getModuleService()
            .registerAndActivateModule( "JSONPrettyPrint", "testingModuleRoot" );
    }

    /**
    * @beforeEach
    */
    function setupIntegrationTest() {
        setup();
    }

}